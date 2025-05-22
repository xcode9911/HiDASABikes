package servlet;

import java.io.BufferedReader;

import java.io.IOException;
import java.io.PrintWriter;
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

import org.json.JSONObject;
import dao.OrderDAO;
import util.DatabaseUtil;

@WebServlet("/admin/orders/update-status")
public class UpdateOrderStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDAO orderDAO;

    public void init() {
        orderDAO = new OrderDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JSONObject jsonResponse = new JSONObject();
        Connection conn = null;

        try {
            // Read request body
            BufferedReader reader = request.getReader();
            StringBuilder json = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                json.append(line);
            }

            // Parse JSON request
            JSONObject jsonRequest = new JSONObject(json.toString());
            int orderId = jsonRequest.getInt("orderId");
            String newStatus = jsonRequest.getString("status");

            // Validate status
            if (!isValidStatus(newStatus)) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Invalid status value. Must be either 'Delivered' or 'Cancelled'");
                out.print(jsonResponse.toString());
                return;
            }

            // Check if order exists
            if (orderDAO.getOrderById(orderId) == null) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Order not found with ID: " + orderId);
                out.print(jsonResponse.toString());
                return;
            }

            conn = DatabaseUtil.getConnection();
            conn.setAutoCommit(false); // Start transaction

            try {
                // Update order status
                boolean success = orderDAO.updateOrderStatus(orderId, newStatus);
                System.out.println("Update status result: " + success);

                if (success) {
                    // If status is changed to Delivered, generate sale record
                    if ("Delivered".equals(newStatus)) {
                        // Get order details and payment information
                        String sql = "SELECT p.Payment_Status, " +
                                   "SUM(od.Quantity * b.Price) as Total_Amount " +
                                   "FROM `order` o " +
                                   "JOIN order_payment op ON o.OrderID = op.OrderID " +
                                   "JOIN payment p ON op.PaymentID = p.PaymentID " +
                                   "JOIN orderdetail od ON o.OrderID = od.OrderID " +
                                   "JOIN bike b ON od.BikeID = b.BikeID " +
                                   "WHERE o.OrderID = ? " +
                                   "GROUP BY o.OrderID, p.Payment_Status";
                        
                        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                            pstmt.setInt(1, orderId);
                            ResultSet rs = pstmt.executeQuery();
                            
                            if (rs.next()) {
                                double amount = rs.getDouble("Total_Amount");
                                String paymentStatus = rs.getString("Payment_Status");
                                
                                // Only generate sale if payment is successful
                                if ("SUCCESS".equalsIgnoreCase(paymentStatus)) {
                                    // Check if sale record already exists
                                    sql = "SELECT COUNT(*) FROM order_sale WHERE OrderID = ?";
                                    try (PreparedStatement checkStmt = conn.prepareStatement(sql)) {
                                        checkStmt.setInt(1, orderId);
                                        ResultSet checkRs = checkStmt.executeQuery();
                                        if (checkRs.next() && checkRs.getInt(1) > 0) {
                                            System.out.println("Sale record already exists for order: " + orderId);
                                        } else {
                                            // Insert into sale table
                                            sql = "INSERT INTO sale (Sale_Date, Total_Sale_Amount) VALUES (?, ?)";
                                            try (PreparedStatement saleStmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                                                saleStmt.setDate(1, new java.sql.Date(new Date().getTime()));
                                                saleStmt.setDouble(2, amount);
                                                saleStmt.executeUpdate();
                                                
                                                // Get the generated SaleID
                                                ResultSet generatedKeys = saleStmt.getGeneratedKeys();
                                                if (generatedKeys.next()) {
                                                    int saleId = generatedKeys.getInt(1);
                                                    
                                                    // Insert into order_sale table
                                                    sql = "INSERT INTO order_sale (OrderID, SaleID) VALUES (?, ?)";
                                                    try (PreparedStatement orderSaleStmt = conn.prepareStatement(sql)) {
                                                        orderSaleStmt.setInt(1, orderId);
                                                        orderSaleStmt.setInt(2, saleId);
                                                        orderSaleStmt.executeUpdate();
                                                    }
                                                }
                                            }
                                        }
                                    }
                                } else {
                                    System.out.println("Cannot generate sale: Payment not successful for order: " + orderId);
                                }
                            }
                        }
                    }
                    
                    conn.commit(); // Commit transaction
                    jsonResponse.put("success", true);
                    jsonResponse.put("message", "Order status updated successfully");
                } else {
                    conn.rollback(); // Rollback transaction
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "Failed to update order status");
                }
            } catch (SQLException e) {
                if (conn != null) {
                    try {
                        conn.rollback(); // Rollback transaction on error
                    } catch (SQLException ex) {
                        ex.printStackTrace();
                    }
                }
                throw e;
            }
        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Error: " + e.getMessage());
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            out.print(jsonResponse.toString());
        }
    }

    private boolean isValidStatus(String status) {
        return status != null && (status.equals("Delivered") || status.equals("Cancelled"));
    }
} 