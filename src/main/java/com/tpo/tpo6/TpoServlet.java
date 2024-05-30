package com.tpo.tpo6;

import com.tpo.tpo6.DTO.InstrumentExchangeTypePriceDTO;
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");

        Map<String, String> filters = new HashMap<>();
        request.getParameterMap().forEach((k, v) -> filters.put(k, v[0]));

        String sortBy = filters.remove("sort_by");
        String sortOrder = filters.remove("sort_order");

        List<InstrumentExchangeTypePriceDTO> financialInstruments = DatabaseConnection.getSingleInstance().getFinancialInstruments(
                filters, sortBy, sortOrder
        );

        request.setAttribute("financialInstruments", financialInstruments);
        request.setAttribute("map", filters);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("sortOrder", sortOrder);

        request.getRequestDispatcher("/instrumentsList.jsp").forward(request, response);
    }
}
