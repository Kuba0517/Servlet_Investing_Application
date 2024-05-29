<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Tailwind Project</title>
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
    <div class="grid grid-cols-4 gap-4 w-11/12 mt-10 mb-10">
        <div class="col-span-2 h-96 bg-mainblue-400 rounded-main flex flex-col justify-center items-center">
            <section class="p-10 text-white text-center">
                <h2 class="text-5xl font-bold">INVEST IN YOUR FUTURE</h2>
                <p class="text-2xl">With TPO Finances</p>
            </section>
            <div class="flex justify-center gap-x-4">
                <button class="p-5 bg-mainblue-500 rounded-main text-color-main-light transform hover:scale-110 transition duration-500 ease-in-out">Invest with us</button>
                <button class="p-5 bg-mainblue-100 rounded-main text-color-main-dark transform hover:scale-110 transition duration-500 ease-in-out">Check out our reviews</button>
            </div>
        </div>
        <div class="bg-mainblue-500 rounded-main p-10 flex flex-col items-center justify-center text-white">
            <div class="text-center text-6xl mb-3">
                <i class="fa-regular fa-face-angry"></i>
            </div>
            <h1 id="customers" class="text-5xl text-center" data-target="1500">0</h1>
            <p class="text-center mt-4">Mad Customers</p>
        </div>
        <div class="bg-mainblue-400 rounded-main p-10 flex flex-col items-center justify-center text-white">
            <div class="text-center mb-3 text-6xl">
                <i class="fa-solid fa-people-robbery"></i>
            </div>
            <h1 class="text-5xl text-center" data-target="1000000">0</h1>
            <p id="money-lost" class="text-center mt-4">Total money lost</p>
        </div>
        <div class="col-span-2 bg-mainblue-500 rounded-main p-10 flex flex-col items-center justify-center text-white">
            <div class="text-center text-6xl mb-3">
                <i class="fa-solid fa-person-drowning"></i>
            </div>
            <h1 class="text-5xl text-center" data-target="98">0</h1>
            <p id="roi" class="text-center mt-4">Average Lost (%)</p>
        </div>
        <div class="col-span-2 bg-mainblue-400 p-10 rounded-main">
            <form action="tpo-servlet" method="get">
                <div class="grid grid-cols-2 gap-4">
                    <div class="flex flex-col">
                        <label for="instrument_name" class="mb-2 text-white">Instrument Name</label>
                        <input type="text" id="instrument_name" name="instrument_name" class="p-2 rounded">
                    </div>
                    <div class="flex flex-col">
                        <label for="symbol" class="mb-2 text-white">Symbol</label>
                        <input type="text" id="symbol" name="symbol" class="p-2 rounded">
                    </div>
                    <div class="flex flex-col">
                        <label for="exchange_name" class="mb-2 text-white">Exchange Name</label>
                        <input type="text" id="exchange_name" name="exchange_name" class="p-2 rounded">
                    </div>
                    <div class="flex flex-col">
                        <label for="type_name" class="mb-2 text-white">Instrument Type</label>
                        <input type="text" id="type_name" name="type_name" class="p-2 rounded">
                    </div>
                    <div class="flex flex-col">
                        <label for="exchange_country" class="mb-2 text-white">Exchange Country</label>
                        <input type="text" id="exchange_country" name="exchange_country" class="p-2 rounded">
                    </div>
                    <div class="flex flex-col">
                        <label for="sort_by" class="mb-2 text-white">Sort By</label>
                        <select id="sort_by" name="sort_by" class="p-2 rounded">
                            <option value="">Select</option>
                            <option value="price">Price</option>
                            <option value="volume">Volume</option>
                        </select>
                    </div>
                    <div class="flex flex-col">
                        <label for="sort_order" class="mb-2 text-white">Sort Order</label>
                        <select id="sort_order" name="sort_order" class="p-2 rounded">
                            <option value="asc">Ascending</option>
                            <option value="desc">Descending</option>
                        </select>
                    </div>
                </div>
                <div class="flex justify-center mt-4">
                    <button type="submit" class="bg-mainblue-500 text-white py-2 px-4 rounded-main transform hover:scale-105 transition duration-500 ease-in-out">Search</button>
                </div>
            </form>
        </div>
        <div class="bg-mainblue-400 rounded-main p-10 flex flex-col items-center justify-center text-white">
            <p class="text-center mt-4">"I lost all my money investing here!"</p>
        </div>
        <div class="bg-mainblue-500 rounded-main p-10 flex flex-col items-center justify-center text-white">
            <p class="text-center mt-4">"Worst financial decision I ever made."</p>
        </div>
        <div class="bg-mainblue-400 rounded-main p-10 flex flex-col items-center justify-center text-white">
            <p class="text-center mt-4">"Avoid at all costs!"</p>
        </div>
        <div class="bg-mainblue-500 rounded-main p-10 flex flex-col items-center justify-center text-white">
            <p class="text-center mt-4">"Terrible customer service and results."</p>
        </div>
    </div>
</main>

<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.9.1/gsap.min.js"></script>
<script src="static/js/app.js"></script>
</body>
</html>