package com.tpo.tpo6.DTO;

public record InstrumentExchangeTypePriceDTO(
        String symbol,
        String instrumentName,
        String typeName,
        String exchangeName,
        String exchangeCountry,
        String currency,
        Double price,
        Integer volume
        ) {
}
