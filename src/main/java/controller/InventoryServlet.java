package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import modal.User;
import modal.Bike;
import util.DatabaseUtil;

@WebServlet("/admin/inventory")
public class InventoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    public InventoryServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Check if user is logged in and is an admin
        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/AdminLoginServlet");
            return;
        }

        try (Connection conn = DatabaseUtil.getConnection()) {
            // Get inventory summary
            Map<String, Integer> summary = getInventorySummary(conn);
            request.setAttribute("summary", summary);
            
            // Get inventory list
            List<Bike> inventory = getInventoryList(conn);
            request.setAttribute("inventory", inventory);
            
            // Forward to inventory page
            request.getRequestDispatcher("/admin/inventory.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/admin/inventory.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Check if user is logged in and is an admin
        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/AdminLoginServlet");
            return;
        }

        String action = request.getParameter("action");
        
        if ("updateStock".equals(action)) {
            try {
                int bikeId = Integer.parseInt(request.getParameter("bikeId"));
                int newStock = Integer.parseInt(request.getParameter("newStock"));
                
                updateBikeStock(bikeId, newStock);
                response.sendRedirect(request.getContextPath() + "/admin/inventory?message=stock_updated");
                
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/inventory?error=invalid_input");
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/admin/inventory?error=database_error");
            }
        }
    }

    private Map<String, Integer> getInventorySummary(Connection conn) throws SQLException {
        Map<String, Integer> summary = new HashMap<>();
        
        // Get total stock
        String totalStockQuery = "SELECT COUNT(*) as total FROM bike";
        try (PreparedStatement stmt = conn.prepareStatement(totalStockQuery);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                summary.put("totalStock", rs.getInt("total"));
            }
        }
        
        // Get low stock items (less than 5)
        String lowStockQuery = "SELECT COUNT(*) as lowStock FROM bike WHERE Stock_Quantity < 5 AND Stock_Quantity > 0";
        try (PreparedStatement stmt = conn.prepareStatement(lowStockQuery);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                summary.put("lowStock", rs.getInt("lowStock"));
            }
        }
        
        // Get out of stock items
        String outOfStockQuery = "SELECT COUNT(*) as outOfStock FROM bike WHERE Stock_Quantity = 0";
        try (PreparedStatement stmt = conn.prepareStatement(outOfStockQuery);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                summary.put("outOfStock", rs.getInt("outOfStock"));
            }
        }
        
        // Get total value
        String totalValueQuery = "SELECT COALESCE(SUM(Price * Stock_Quantity), 0) as totalValue FROM bike";
        try (PreparedStatement stmt = conn.prepareStatement(totalValueQuery);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                summary.put("totalValue", rs.getInt("totalValue"));
            }
        }
        
        return summary;
    }

    private List<Bike> getInventoryList(Connection conn) throws SQLException {
        List<Bike> inventory = new ArrayList<>();
        
        String query = "SELECT * FROM bike ORDER BY Model_Name";
        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Bike bike = new Bike();
                bike.setBikeId(rs.getInt("BikeID"));
                bike.setBrandName(rs.getString("Brand_Name"));
                bike.setModelName(rs.getString("Model_Name"));
                bike.setType(rs.getString("Type"));
                bike.setPrice(rs.getDouble("Price"));
                bike.setStockQuantity(rs.getInt("Stock_Quantity"));
                inventory.add(bike);
            }
        }
        
        return inventory;
    }

    private void updateBikeStock(int bikeId, int newStock) throws SQLException {
        try (Connection conn = DatabaseUtil.getConnection()) {
            String query = "UPDATE bike SET Stock_Quantity = ? WHERE BikeID = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setInt(1, newStock);
                stmt.setInt(2, bikeId);
                stmt.executeUpdate();
            }
        }
    }
} 