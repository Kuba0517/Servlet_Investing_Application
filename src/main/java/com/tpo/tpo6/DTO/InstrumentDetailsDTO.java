package com.tpo.tpo6.DTO;

import com.tpo.tpo6.models.HistoricalPrice;

import java.util.List;

public record InstrumentDetailsDTO(
        byte[] logo,
        String symbol,
        String instrumentName,
        String exchangeName,
        String exchangeCountry,
        String currency,
        List<HistoricalPrice> prices
) {
}
