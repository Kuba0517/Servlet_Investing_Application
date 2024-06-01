package com.tpo.tpo6.models;

import java.time.LocalDate;

public record HistoricalPrice(
        LocalDate date,
        double price,
        long volume
) {}
