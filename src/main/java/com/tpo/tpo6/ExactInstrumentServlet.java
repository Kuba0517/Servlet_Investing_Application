package com.tpo.tpo6;

import com.tpo.tpo6.DTO.InstrumentDetailsDTO;
import com.tpo.tpo6.models.HistoricalPrice;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(value = "/instruments/*")
public class ExactInstrumentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String symbol = request.getPathInfo().substring(1);

        request.setAttribute("symbol", symbol);

        DatabaseConnection dbConn = DatabaseConnection.getSingleInstance();
        InstrumentDetailsDTO instrument = dbConn.getInstrumentDetailsBySymbol(symbol);

        request.setAttribute("instrument", instrument);
        if (instrument.prices() != null) {
            request.setAttribute("instrument-data", createInstrumentDataJson(instrument.prices()));
        }

        request.getRequestDispatcher("/instrumentDetails.jsp").forward(request, response);
    }

    private String createInstrumentDataJson(List<HistoricalPrice> prices){
        StringBuilder instrumentData = new StringBuilder("[");
        for (HistoricalPrice price : prices) {
            instrumentData.append("{\"x\": ").append("\"").append(price.date().toString()).append("\"").append(", ")
                    .append("\"y1\": ")
                    .append(price.price())
                    .append(", ")
                    .append("\"y2\": ")
                    .append(price.volume())
                    .append("},\n");
        }
        instrumentData.delete(instrumentData.length() - 2, instrumentData.length() - 1);
        instrumentData.append("]");

        return instrumentData.toString();
    }
}
