package com.tpo.tpo6;

import com.tpo.tpo6.DTO.InstrumentExchangeTypePriceDTO;
import com.tpo.tpo6.models.Instrument;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(value = "/tpo-servlet")
public class TpoServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

//        for (Map.Entry<String, String> filter : filters.entrySet()) {
//            switch (filter.getKey()) {
//                case "instrument_name":
//                    query.append(" AND i.name ILIKE ?");
//                    break;
//                case "symbol":
//                    query.append(" AND i.symbol ILIKE ?");
//                    break;
//                case "exchange_name":
//                    query.append(" AND e.name ILIKE ?");
//                    break;
//                case "type_name":
//                    query.append(" AND it.type_name ILIKE ?");
//                    break;
//                case "exchange_country":
//                    query.append(" AND e.country ILIKE ?");
//                    break;
//            }
//        }

       Map<String, String> filters = new HashMap<>();
       request.getParameterMap().forEach((k,v) -> filters.put(k, v[0]));

       String sortBy = filters.remove("sort_by");
       String sortOrder = filters.remove("sort_order");

        List<InstrumentExchangeTypePriceDTO> financialInstruments = DatabaseConnection.getSingleInstance().getFinancialInstruments(
            filters, sortBy, sortOrder
        );

        request.setAttribute("financialInstruments", financialInstruments);

        request.setAttribute("symbol", filters.get("symbol"));
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("sortOrder", sortOrder);

        try {
            request.getRequestDispatcher("/instrumentsList.jsp").forward(request, response);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }
    }

}
