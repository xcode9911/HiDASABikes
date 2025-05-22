package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.DatabaseUtil;

@WebServlet("/admin/generate-sale")
public class GenerateSaleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseUtil.getConnection();
            conn.setAutoCommit(false); // Start transaction
            
            // 1. Get order details and payment information
            String sql = "SELECT o.OrderID, p.Amount, p.Payment_Status, p.Payment_Method " +
                        "FROM `order` o " +
                        "JOIN order_payment op ON o.OrderID = op.OrderID " +
                        "JOIN payment p ON op.PaymentID = p.PaymentID " +
                        "WHERE o.OrderID = ? AND o.Status = 'DELIVERED'";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, orderId);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                double amount = rs.getDouble("Amount");
                String paymentStatus = rs.getString("Payment_Status");
                
                // Only generate sale if payment is successful
                if ("SUCCESS".equalsIgnoreCase(paymentStatus)) {
                    // 2. Insert into sale table
                    sql = "INSERT INTO sale (Sale_Date, Total_Sale_Amount) VALUES (?, ?)";
                    pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                    pstmt.setDate(1, new java.sql.Date(new Date().getTime())); // Current date as sale date
                    pstmt.setDouble(2, amount);
                    pstmt.executeUpdate();
                    
                    // Get the generated SaleID
                    rs = pstmt.getGeneratedKeys();
                    if (rs.next()) {
                        int saleId = rs.getInt(1);
                        
                        // 3. Insert into order_sale table
                        sql = "INSERT INTO order_sale (OrderID, SaleID) VALUES (?, ?)";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setInt(1, orderId);
                        pstmt.setInt(2, saleId);
                        pstmt.executeUpdate();
                        
                        conn.commit(); // Commit transaction
                        response.setStatus(HttpServletResponse.SC_OK);
                        response.getWriter().write("Sale generated successfully");
                    }
                } else {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("Cannot generate sale: Payment not successful");
                }
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("Order not found or not delivered");
            }
            
        } catch (SQLException e) {
            try {
                if (conn != null) {
                    conn.rollback(); // Rollback transaction on error
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Database error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) {
                    conn.setAutoCommit(true); // Reset auto-commit
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
} 