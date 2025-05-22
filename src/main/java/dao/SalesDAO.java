package dao;

import java.sql.Connection;


import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import modal.Sales;
import util.DatabaseUtil;

public class SalesDAO {
    
    // Get all sales records
    public List<Sales> getAllSales() throws SQLException {
        List<Sales> salesList = new ArrayList<>();
        String sql = "SELECT s.*, o.OrderID, p.PaymentID " +
                    "FROM sale s " +
                    "JOIN order_sale os ON s.SaleID = os.SaleID " +
                    "JOIN `order` o ON os.OrderID = o.OrderID " +
                    "JOIN order_payment op ON o.OrderID = op.OrderID " +
                    "JOIN payment p ON op.PaymentID = p.PaymentID " +
                    "ORDER BY s.Sale_Date DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Sales sale = new Sales();
                sale.setSaleId(rs.getInt("SaleID"));
                sale.setSaleDate(rs.getDate("Sale_Date"));
                sale.setTotalSaleAmount(rs.getDouble("Total_Sale_Amount"));
                salesList.add(sale);
            }
        }
        return salesList;
    }
    
    // Get sales summary (total sales, monthly sales, etc.)
    public Map<String, Object> getSalesSummary() throws SQLException {
        Map<String, Object> summary = new HashMap<>();
        String sql = "SELECT " +
                    "COUNT(DISTINCT o.OrderID) as total_orders, " +
                    "SUM(b.Price) as total_sales, " +
                    "AVG(b.Price) as avg_order_value " +
                    "FROM `order` o " +
                    "JOIN orderdetail od ON o.OrderID = od.OrderID " +
                    "JOIN bike b ON od.BikeID = b.BikeID " +
                    "JOIN order_payment op ON o.OrderID = op.OrderID " +
                    "JOIN payment p ON op.PaymentID = p.PaymentID " +
                    "WHERE o.Status = 'DELIVERED'";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            if (rs.next()) {
                summary.put("totalOrders", rs.getInt("total_orders"));
                summary.put("totalSales", rs.getDouble("total_sales"));
                summary.put("avgOrderValue", rs.getDouble("avg_order_value"));
                
                // Get current month's sales
                sql = "SELECT SUM(b.Price) as monthly_sales " +
                      "FROM `order` o " +
                      "JOIN orderdetail od ON o.OrderID = od.OrderID " +
                      "JOIN bike b ON od.BikeID = b.BikeID " +
                      "JOIN order_payment op ON o.OrderID = op.OrderID " +
                      "JOIN payment p ON op.PaymentID = p.PaymentID " +
                      "WHERE o.Status = 'DELIVERED' " +
                      "AND MONTH(o.Order_Date) = MONTH(CURRENT_DATE()) " +
                      "AND YEAR(o.Order_Date) = YEAR(CURRENT_DATE())";
                
                try (PreparedStatement monthlyStmt = conn.prepareStatement(sql);
                     ResultSet monthlyRs = monthlyStmt.executeQuery()) {
                    
                    if (monthlyRs.next()) {
                        summary.put("monthlySales", monthlyRs.getDouble("monthly_sales"));
                    } else {
                        summary.put("monthlySales", 0.0);
                    }
                }
            } else {
                // Set default values if no data found
                summary.put("totalOrders", 0);
                summary.put("totalSales", 0.0);
                summary.put("avgOrderValue", 0.0);
                summary.put("monthlySales", 0.0);
            }
        }
        return summary;
    }
    
    // Get monthly sales data for chart
    public List<Map<String, Object>> getMonthlySales() throws SQLException {
        List<Map<String, Object>> monthlySales = new ArrayList<>();
        String sql = "SELECT MONTH(Sale_Date) as month, " +
                    "SUM(Total_Sale_Amount) as total " +
                    "FROM sale " +
                    "WHERE YEAR(Sale_Date) = YEAR(CURRENT_DATE()) " +
                    "GROUP BY MONTH(Sale_Date) " +
                    "ORDER BY month";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Map<String, Object> monthData = new HashMap<>();
                monthData.put("month", rs.getInt("month"));
                monthData.put("total", rs.getDouble("total"));
                monthlySales.add(monthData);
            }
        }
        return monthlySales;
    }
    
    // Get detailed sales records with customer and bike information
    public List<Map<String, Object>> getDetailedSalesRecords() throws SQLException {
        List<Map<String, Object>> salesRecords = new ArrayList<>();
        String sql = "SELECT o.OrderID, o.Order_Date, u.Name as customer_name, " +
                    "b.Model_Name as bike_model, b.Price as total_amount, " +
                    "p.Payment_Status, p.Payment_Method " +
                    "FROM `order` o " +
                    "JOIN user_order uo ON o.OrderID = uo.OrderID " +
                    "JOIN user u ON uo.UserID = u.UserID " +
                    "JOIN orderdetail od ON o.OrderID = od.OrderID " +
                    "JOIN bike b ON od.BikeID = b.BikeID " +
                    "JOIN order_payment op ON o.OrderID = op.OrderID " +
                    "JOIN payment p ON op.PaymentID = p.PaymentID " +
                    "WHERE o.Status = 'DELIVERED' " +
                    "ORDER BY o.Order_Date DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Map<String, Object> record = new HashMap<>();
                record.put("orderId", rs.getInt("OrderID"));
                record.put("deliveryDate", rs.getDate("Order_Date"));
                record.put("customerName", rs.getString("customer_name"));
                record.put("bikeModel", rs.getString("bike_model"));
                record.put("totalAmount", rs.getDouble("total_amount"));
                record.put("paymentStatus", rs.getString("Payment_Status"));
                record.put("paymentMethod", rs.getString("Payment_Method"));
                salesRecords.add(record);
            }
        }
        return salesRecords;
    }
    
    // Create a new sale record
    public int createSale(double totalAmount) throws SQLException {
        String sql = "INSERT INTO sale (Sale_Date, Total_Sale_Amount) VALUES (?, ?)";
        int saleId = -1;
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setDate(1, new java.sql.Date(new Date().getTime()));
            pstmt.setDouble(2, totalAmount);
            
            int affectedRows = pstmt.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        saleId = rs.getInt(1);
                    }
                }
            }
        }
        return saleId;
    }
    
    // Link an order to a sale
    public boolean linkOrderToSale(int orderId, int saleId) throws SQLException {
        String sql = "INSERT INTO order_sale (OrderID, SaleID) VALUES (?, ?)";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, orderId);
            pstmt.setInt(2, saleId);
            
            return pstmt.executeUpdate() > 0;
        }
    }
    
    // Check if a sale record exists for an order
    public boolean saleExistsForOrder(int orderId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM order_sale WHERE OrderID = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, orderId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }
} 