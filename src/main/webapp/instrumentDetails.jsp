<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.tpo.tpo6.DTO.InstrumentDetailsDTO" %>
<%@ page import="com.tpo.tpo6.models.HistoricalPrice" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Base64" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instrument Details</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800&family=Sora:wght@100..800&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
          integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link href="${pageContext.request.contextPath}/css/global_styles.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="bg-mainblue-100">
<main class="flex flex-col items-center w-full">
    <div class="bg-mainblue-500 text-white p-10 rounded-main w-11/12 mt-10 mb-5 flex items-center justify-between">
        <a href="${pageContext.request.contextPath}/instruments?instrument_name=&symbol=&exchange_name=&type_name=&exchange_country=&sort_by=&sort_order=asc"
           class="text-4xl hover-icon">
            <i class="fas fa-arrow-left"></i>
        </a>
        <h1 class="text-5xl font-bold flex-grow text-center">Instrument Details</h1>
        <div class="w-12"></div>
    </div>
    <div class="bg-white rounded-3xl p-10 w-11/12 shadow-lg">
        <%
            InstrumentDetailsDTO instrument = (InstrumentDetailsDTO) request.getAttribute("instrument");
            if (instrument != null) {
                NumberFormat numberFormat = NumberFormat.getNumberInstance(request.getLocale());
        %>
        <div class="flex justify-around text-center font-semibold mb-4">
            <div class="w-1/7">Icon</div>
            <div class="w-1/7">Symbol</div>
            <div class="w-1/7">Name</div>
            <div class="w-1/7">Exchange</div>
            <div class="w-1/7">Country</div>
            <div class="w-1/7">Currency</div>
        </div>
        <hr class="mb-4">
        <div class="flex justify-around text-center bg-mainblue-400 rounded-main p-5 text-white items-center">
            <div class="w-1/7">
                <% if (instrument.logo() != null) { %>
                <img src="data:image/png;base64,
                        <%= Base64.getEncoder().encodeToString(instrument.logo()) %>"
                     alt="<%= instrument.symbol() %> logo" class="h-12 w-12 mx-auto rounded-xl">
                <% } else { %>
                <p>No logo available</p>
                <% } %>
            </div>
            <div class="w-1/7"><p class="text-xl"><%= instrument.symbol() %>
            </p></div>
            <div class="w-1/7"><p class="text-xl"><%= instrument.instrumentName() %>
            </p></div>
            <div class="w-1/7"><p class="text-xl"><%= instrument.exchangeName() %>
            </p></div>
            <div class="w-1/7"><p class="text-xl"><%= instrument.exchangeCountry() %>
            </p></div>
            <div class="w-1/7"><p class="text-xl"><%= instrument.currency() %>
            </p></div>
        </div>

        <div class="flex justify-center my-5 gap-x-2">
            <p class="font-semibold">Price</p>
            <span id="chart-toggle" class="border bg-mainblue-500 rounded-full border-grey flex items-center cursor-pointer w-12 justify-start">
                <span class="rounded-full border w-6 h-6 border-grey shadow-inner bg-white shadow">
                </span>
          </span>
            <p class="font-semibold">Volume</p>
        </div>

        <canvas id="financial-chart" class="w-full h-96 mt-10"></canvas>
        <div class="mt-10">
            <h2 class="text-3xl font-bold text-center mb-5">Historical Prices</h2>
            <div class="flex justify-around text-center font-semibold mb-4">
                <div class="w-1/2">Date</div>
                <div class="w-1/2">Price</div>
            </div>
            <%
                List<HistoricalPrice> prices = instrument.prices();
                for (HistoricalPrice price : prices) {
            %>
            <div class="flex justify-around text-center mb-4">
                <div class="w-1/2"><p class="text-xl"><%= price.date() %>
                </p></div>
                <div class="w-1/2"><p class="text-xl"><%= numberFormat.format(price.price()) %>
                </p></div>
            </div>
            <% } %>
        </div>
        <% } else { %>
        <p class="text-center text-2xl text-mainblue-500">Instrument not found.</p>
        <% } %>
    </div>
</main>
<script>
    const ctx = document.getElementById('financial-chart').getContext('2d');
    const financialData = <%= request.getAttribute("instrument-data") %>;

    const labels = financialData.map(data => data.x);
    const prices = financialData.map(data => data.y1);
    const volumes = financialData.map(data => data.y2);

    const data = {
        labels: labels,
        datasets: [{
            label: 'Price',
            data: prices,
            borderColor: '#06111F',
            yAxisID: 'y-axis-price'
        }, {
            label: 'Volume',
            data: volumes,
            borderColor: '#7091e6',
            yAxisID: 'y-axis-volume',
            hidden: true
        }]
    };


    const config = {
        type: 'line',
        data: data,
        options: {
            interaction: {
                intersect: false
            },
            plugins: {
                legend: false
            },
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    };

    const chart = new Chart(ctx, config)

    const chartToggle = document.getElementById('chart-toggle');

    chartToggle.addEventListener('click', function () {
        chartToggle.classList.forEach(c => {
            if (c === 'justify-start'){
                chart.data.datasets[0].hidden = true;
                chart.data.datasets[1].hidden = false;
                chart.update();
                chartToggle.classList.remove('justify-start');
                chartToggle.classList.add('justify-end');
                chartToggle.classList.remove('bg-mainblue-500');
                chartToggle.classList.add('bg-mainblue-400');
            } else if (c === 'justify-end') {
                chart.data.datasets[0].hidden = false;
                chart.data.datasets[1].hidden = true;
                chart.update();
                chartToggle.classList.remove('justify-end');
                chartToggle.classList.add('justify-start');
                chartToggle.classList.remove('bg-mainblue-400');
                chartToggle.classList.add('bg-mainblue-500');
            }
        });

    });
</script>
</body>
</html>

<%--dodac mozliwosc skrocenia okresu--%>
