package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.SalesDAO;

@WebServlet("/admin/print/*")
public class PrintServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private SalesDAO salesDAO;
    
    @Override
    public void init() throws ServletException {
        salesDAO = new SalesDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        try {
            if (pathInfo != null && pathInfo.startsWith("/order/")) {
                // Print individual order
                String orderId = pathInfo.substring("/order/".length());
                printOrder(request, response, Integer.parseInt(orderId));
            } else if (pathInfo != null && pathInfo.equals("/all")) {
                // Print all sales report
                printAllSales(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error generating print view");
        }
    }
    
    private void printOrder(HttpServletRequest request, HttpServletResponse response, int orderId) 
            throws SQLException, ServletException, IOException {
        // Get order details
        List<Map<String, Object>> orderDetails = salesDAO.getDetailedSalesRecords();
        Map<String, Object> order = orderDetails.stream()
                .filter(o -> ((Integer)o.get("orderId")) == orderId)
                .findFirst()
                .orElse(null);
                
        if (order != null) {
            request.setAttribute("order", order);
            request.setAttribute("isSingleOrder", true);
            request.getRequestDispatcher("/admin/print-view.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Order not found");
        }
    }
    
    private void printAllSales(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        // Get all sales data
        List<Map<String, Object>> salesList = salesDAO.getDetailedSalesRecords();
        Map<String, Object> summary = salesDAO.getSalesSummary();
        
        request.setAttribute("salesList", salesList);
        request.setAttribute("summary", summary);
        request.setAttribute("isSingleOrder", false);
        request.getRequestDispatcher("/admin/print-view.jsp").forward(request, response);
    }
} 