<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.tpo.tpo6.DTO.InstrumentExchangeTypePriceDTO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.io.ByteArrayInputStream" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Financial Instruments</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800&family=Sora:wght@100..800&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
          integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link href="${pageContext.request.contextPath}/css/global_styles.css" rel="stylesheet">
</head>
<body class="bg-mainblue-100">
<main class="flex flex-col items-center w-full">
    <div class="bg-mainblue-500 text-white p-10 rounded-main w-11/12 mt-10 mb-5 flex items-center justify-between">
        <a href="index.jsp" class="text-4xl hover-icon">
            <i class="fas fa-arrow-left"></i>
        </a>
        <h1 class="text-5xl font-bold flex-grow text-center">Financial Instruments</h1>
        <div class="w-12"></div>
    </div>
    <form action="instruments" method="get" class="">
        <div class="flex flex-col gap-y-3 text-color-main-dark">
            <div class="flex justify-around gap-x-5">
                <div class="flex flex-col">
                    <label for="instrument_name" class="mb-2">Instrument Name</label>
                    <input type="text" id="instrument_name" name="instrument_name" class="p-2 rounded">
                </div>
                <div class="flex flex-col">
                    <label for="symbol" class="mb-2">Symbol</label>
                    <input type="text" id="symbol" name="symbol" class="p-2 rounded">
                </div>
            </div>
            <div class="flex text-color-main-dark justify-around gap-x-2">
                <div class="flex flex-col">
                    <label for="type_name" class="mb-2">Type</label>
                    <select id="type_name" name="type_name" class="p-2 rounded">
                        <option value="">Select</option>
                        <option value="stock">Stock</option>
                        <option value="bond">Bond</option>
                        <option value="commodity">Commodity</option>
                        <option value="etf">ETF</option>
                        <option value="cryptocurrency">Cryptocurrency</option>
                    </select>
                </div>
                <div class="flex flex-col">
                    <label for="exchange_name" class="mb-2">Exchange Name</label>
                    <select id="exchange_name" name="exchange_name" class="p-2 rounded">
                        <option value="">Select</option>
                        <option value="nyse">NYSE</option>
                        <option value="nasdaq">NASDAQ</option>
                        <option value="lse">LSE</option>
                        <option value="gpw">GPW</option>
                    </select>
                </div>
                <div class="flex flex-col">
                    <label for="exchange_country" class="mb-2">Exchange Country</label>
                    <select id="exchange_country" name="exchange_country" class="p-2 rounded">
                        <option value="">Select</option>
                        <option value="poland">Poland</option>
                        <option value="usa">USA</option>
                        <option value="uk">UK</option>
                    </select>
                </div>
            </div>
            <div class="flex flex-col">
                <label for="sort_by" class="mb-2">Sort By</label>
                <select id="sort_by" name="sort_by" class="p-2 rounded">
                    <option value="">Select</option>
                    <option value="price">Price</option>
                    <option value="volume">Volume</option>
                </select>
            </div>
            <div class="flex flex-col">
                <label for="sort_order" class="mb-2">Sort Order</label>
                <select id="sort_order" name="sort_order" class="p-2 rounded">
                    <option value="asc">Ascending</option>
                    <option value="desc">Descending</option>
                </select>
            </div>
        </div>
        <div class="flex justify-center mt-4">
            <button type="submit"
                    class="bg-mainblue-500 text-white py-2 px-4 rounded-main transform hover:scale-105 transition duration-500 ease-in-out">
                Search
            </button>
        </div>
    </form>
    <div class="bg-white rounded-3xl p-10 w-11/12 shadow-lg">
        <% List<InstrumentExchangeTypePriceDTO> financialInstruments = (List<InstrumentExchangeTypePriceDTO>) request.getAttribute("financialInstruments"); %>
        <% if (financialInstruments != null && !financialInstruments.isEmpty()) { %>
        <div class="flex justify-around text-center font-semibold mb-4">
            <div class="w-1/7">Logo</div>
            <div class="w-1/7">Symbol</div>
            <div class="w-1/7">Name</div>
            <div class="w-1/7">Exchange</div>
            <div class="w-1/7">Country</div>
            <div class="w-1/7">Price</div>
            <div class="w-1/7">Volume</div>
        </div>
        <hr class="mb-4">
        <div>
            <% for (InstrumentExchangeTypePriceDTO instrument : financialInstruments) { %>
            <a href="${pageContext.request.contextPath}/instruments/<%= instrument.symbol() %>">
                <div class="flex mb-5 justify-around text-center cursor-pointer bg-mainblue-400 rounded-main p-5 text-white items-center hover-bg-gradient">
                    <div class="w-1/6">
                        <% if (instrument.logo() != null) { %>
                        <img src="data:image/png;base64,
                        <%= Base64.getEncoder().encodeToString(instrument.logo()) %>"
                             alt="<%= instrument.symbol() %> logo" class="h-12 w-12 mx-auto rounded-xl">
                        <% } else { %>
                        <p>No logo available</p>
                        <% } %>
                    </div>
                    <div class="w-1/6"><p class="text-xl"><%= instrument.symbol() %>
                    </p></div>
                    <div class="w-1/6"><p class="text-xl"><%= instrument.instrumentName() %>
                    </p></div>

                    <% if (instrument.exchangeName() != null) { %>
                    <div class="w-1/6"><p class="text-xl"><%= instrument.exchangeName() %>
                    </p></div>
                    <% } else { %>
                    <div class="w-1/6"><p class="text-xl">none</p></div>
                    <% } %>

                    <% if (instrument.exchangeName() != null) { %>
                    <div class="w-1/6"><p class="text-xl"><%= instrument.exchangeCountry() %>
                    </p></div>
                    <% } else { %>
                    <div class="w-1/6"><p class="text-xl">none</p></div>
                    <% } %>

                    <% NumberFormat numberFormat = NumberFormat.getNumberInstance(request.getLocale());%>
                    <div class="w-1/6"><p
                            class="text-xl"><%= numberFormat.format(instrument.price()) + " " + instrument.currency() %>
                    </p></div>
                    <div class="w-1/6"><p
                            class="text-xl"><%= numberFormat.format(instrument.volume()) + " " + instrument.currency() %>
                    </p></div>
                </div>
                    <% } %>
        </div>
        </a>
        <% } else { %>
        <p class="text-center text-2xl text-mainblue-500">No financial instruments found.</p>
        <% } %>
    </div>
</main>
</body>
</html>