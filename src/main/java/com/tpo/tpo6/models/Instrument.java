package com.tpo.tpo6.models;

public record Instrument(
        int id,
        String symbol,
        String name,
        int typeId,
        int exchangeId
) {}
