<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.tpo.tpo6.DTO.InstrumentExchangeTypePriceDTO" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Financial Instruments</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800&family=Sora:wght@100..800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="styles.css" rel="stylesheet">
    <style>
        body {
            font-family: "Sora", sans-serif;
        }
        .bg-mainblue-100 {
            background-color: #EDE8F5;
        }
        .bg-mainblue-200 {
            background-color: #ADBBDA;
        }
        .bg-mainblue-300 {
            background-color: #8697c4;
        }
        .bg-mainblue-400 {
            background-color: #7091e6;
        }
        .bg-mainblue-500 {
            background-color: #06111F;
        }
        .rounded-main {
            border-radius: 40px;
        }
        .text-color-main-dark {
            color: #3D52A0;
        }
        .text-color-main-light {
            color: #EDE8F5;
        }
    </style>
</head>
<body class="bg-mainblue-100">
<main class="flex flex-col items-center w-full">
    <!-- Header -->
    <div class="bg-mainblue-500 text-white p-10 rounded-main w-11/12 mt-10 mb-5 text-center">
        <h1 class="text-5xl font-bold">Financial Instruments</h1>
    </div>

    <!-- Financial Instruments List -->
    <div class="bg-white rounded-main p-10 w-11/12 shadow-lg">
        <% List<InstrumentExchangeTypePriceDTO> financialInstruments = (List<InstrumentExchangeTypePriceDTO>) request.getAttribute("financialInstruments"); %>
        <% if (financialInstruments != null && !financialInstruments.isEmpty()) { %>
        <div class="flex justify-around text-center font-semibold mb-4">
            <div class="w-1/6">Symbol</div>
            <div class="w-1/6">Name</div>
            <div class="w-1/6">Exchange</div>
            <div class="w-1/6">Country</div>
            <div class="w-1/6">Price</div>
            <div class="w-1/6">Volume</div>
        </div>
        <hr class="mb-4">
        <div class="space-y-4">
            <% for (InstrumentExchangeTypePriceDTO instrument : financialInstruments) { %>
            <div class="flex justify-center items-center text-center bg-mainblue-400 rounded-main p-5 text-white">
                <div class="w-1/6"><p class="text-xl"><%= instrument.symbol() %></p></div>
                <div class="w-1/6"><p class="text-xl"><%= instrument.instrumentName() %></p></div>
                <div class="w-1/6"><p class="text-xl"><%= instrument.exchangeName() %></p></div>
                <div class="w-1/6"><p class="text-xl"><%= instrument.exchangeCountry() %></p></div>
                <div class="w-1/6"><p class="text-xl"><%= instrument.price() + " " + instrument.currency() %></p></div>
                <div class="w-1/6"><p class="text-xl"><%= instrument.volume() + " " + instrument.currency() %></p></div>
            </div>
            <% } %>
        </div>
        <% } else { %>
        <p class="text-center text-2xl text-mainblue-500">No financial instruments found.</p>
        <% } %>
    </div>
</main>
</body>
</html>
