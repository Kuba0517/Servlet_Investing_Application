package com.tpo.tpo6.models;

import java.sql.Date;

public record HistoricalPrice(
        int instrumentId,
        Date date,
        double price,
        long volume
) {}
