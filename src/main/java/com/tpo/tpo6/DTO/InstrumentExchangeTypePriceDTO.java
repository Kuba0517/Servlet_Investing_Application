package com.tpo.tpo6.DTO;

import java.util.Optional;

public record InstrumentExchangeTypePriceDTO(
        String symbol,
        String instrumentName,
        String exchangeName,
        String exchangeCountry,
        String currency,
        double price,
        long volume,
        byte[] logo
        ) {
}
