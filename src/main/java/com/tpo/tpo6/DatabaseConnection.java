package com.tpo.tpo6;

import com.tpo.tpo6.DTO.InstrumentExchangeTypePriceDTO;
import com.tpo.tpo6.models.Instrument;
import com.tpo.tpo6.models.InstrumentType;
import com.tpo.tpo6.models.StockExchange;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public final class DatabaseConnection {
    private static final String DB_URL = "jdbc:postgresql://localhost:5432/tpo_finances";
    private static final String DB_USER = "postgres";
    private static final String DB_PASSWORD = "password";
    private Connection connection;

    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("PostgreSQL JDBC Driver not found", e);
        }
    }

    // Singleton instance
    private static DatabaseConnection singleInstance;

    private DatabaseConnection() {
        try {
            this.connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static DatabaseConnection getSingleInstance() {
        if (singleInstance == null) {
            synchronized (DatabaseConnection.class) {
                if (singleInstance == null) {
                    singleInstance = new DatabaseConnection();
                }
            }
        }
        return singleInstance;
    }

    public Connection getConnection() {
        return connection;
    }

    private String createQuery(Map<String, String> filters, String sortBy, String sortOrder) {
        StringBuilder query = new StringBuilder(
                "SELECT i.symbol, i.name as instrument_name,\n" +
                        "                            it.type_name as type_name, e.name as exchange_name, " +
                        "e.country as exchange_country, c.name as currency, hp.price, hp.volume" +
                        "                            FROM instruments i" +
                        "                            JOIN instrument_types it ON i.type_id = it.id" +
                        "                            JOIN exchanges e ON i.exchange_id = e.id" +
                        "                            JOIN currencies c ON i.currency_id = c.id" +
                        "                            JOIN historical_prices hp ON i.id = hp.instrument_id" +
                        "                            WHERE hp.date = (SELECT MAX(date) FROM historical_prices)");

        for (Map.Entry<String, String> filter : filters.entrySet()) {
            switch (filter.getKey()) {
                case "instrument_name":
                    query.append(" AND i.name ILIKE ?");
                    break;
                case "symbol":
                    query.append(" AND i.symbol ILIKE ?");
                    break;
                case "exchange_name":
                    query.append(" AND e.name ILIKE ?");
                    break;
                case "type_name":
                    query.append(" AND it.type_name ILIKE ?");
                    break;
                case "exchange_country":
                    query.append(" AND e.country ILIKE ?");
                    break;

                default:
                    query.append("");
            }
        }

        if (!sortBy.isEmpty()) {
            query.append(" ORDER BY ");
            switch (sortBy) {
                case "price":
                    query.append("hp.price * c.exchange_rate ");
                    break;
                case "volume":
                    query.append("hp.volume * c.exchange_rate ");
                    break;
                default:
                    query.append(sortBy).append(" ");
            }
            query.append(sortOrder.equals("desc") ? "DESC" : "");
        }

        return query.toString();
    }

    private void setParameters(PreparedStatement stmt, Map<String, String> filters) throws SQLException {
        int index = 1;
        for (Map.Entry<String, String> filter : filters.entrySet()) {
            stmt.setString(index++, "%" + filter.getValue() + "%");
        }
    }

    public List<InstrumentExchangeTypePriceDTO> getFinancialInstruments(Map<String, String> filters, String sortBy, String sortOrder) {
        List<InstrumentExchangeTypePriceDTO> instruments = new ArrayList<>();
        try {
            Connection conn = getSingleInstance().getConnection();
            String query = createQuery(filters, sortBy, sortOrder);
            PreparedStatement stmt = conn.prepareStatement(query);
            setParameters(stmt, filters);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                InstrumentExchangeTypePriceDTO response = new InstrumentExchangeTypePriceDTO(
                        rs.getString("symbol"),
                        rs.getString("instrument_name"),
                        rs.getString("type_name"),
                        rs.getString("exchange_name"),
                        rs.getString("exchange_country"),
                        rs.getString("currency"),
                        rs.getDouble("price"),
                        rs.getInt("volume")
                );
                instruments.add(response);
            }
            rs.close();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return instruments;
    }


    public static void main(String[] args) {
        DatabaseConnection dbConn = DatabaseConnection.getSingleInstance();
        Map<String, String> filters = new HashMap<>();
        filters.put("instrument_name", "Apple");
        //filters.put("exchange_country", "USA");

        String sortBy = "volume";
        String sortOrder = "";

        List<InstrumentExchangeTypePriceDTO> instruments = dbConn.getFinancialInstruments(filters, sortBy, sortOrder);
        for (InstrumentExchangeTypePriceDTO instrument : instruments) {
            System.out.println(instrument);
        }
    }
}
