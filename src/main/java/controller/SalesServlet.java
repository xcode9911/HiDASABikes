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
import modal.Sales;

@WebServlet("/admin/sales")
public class SalesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private SalesDAO salesDAO;
    
    @Override
    public void init() throws ServletException {
        salesDAO = new SalesDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println("SalesServlet: Processing request with action: " + action);
        
        try {
            if (action == null || action.equals("view")) {
                // Load all data for the main sales page
                System.out.println("Loading all sales data...");
                
                // Get sales summary
                Map<String, Object> summary = salesDAO.getSalesSummary();
                request.setAttribute("totalSales", summary.get("totalSales"));
                request.setAttribute("monthlySales", summary.get("monthlySales"));
                request.setAttribute("totalOrders", summary.get("totalOrders"));
                request.setAttribute("avgOrderValue", summary.get("avgOrderValue"));
                
                // Get detailed sales records
                List<Map<String, Object>> salesList = salesDAO.getDetailedSalesRecords();
                request.setAttribute("salesList", salesList);
                
                // Get monthly sales data for chart
                List<Map<String, Object>> monthlySales = salesDAO.getMonthlySales();
                request.setAttribute("monthlySalesData", monthlySales);
                
                request.getRequestDispatcher("/admin/sales.jsp").forward(request, response);
            } else if (action.equals("summary")) {
                Map<String, Object> summary = salesDAO.getSalesSummary();
                request.setAttribute("summary", summary);
            } else if (action.equals("list")) {
                List<Map<String, Object>> salesList = salesDAO.getDetailedSalesRecords();
                request.setAttribute("salesList", salesList);
            } else if (action.equals("monthly")) {
                List<Map<String, Object>> monthlySales = salesDAO.getMonthlySales();
                request.setAttribute("monthlySalesData", monthlySales);
            }
        } catch (SQLException e) {
            System.err.println("Database error in SalesServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/admin/sales.jsp").forward(request, response);
        }
    }
} 