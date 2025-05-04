package controller;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Date;
import java.util.Calendar;

import util.DatabaseUtil;
import modal.Bike;

/**
 * Servlet implementation class ProcessPayment
 */
@WebServlet("/process-payment")
public class ProcessPayment extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessPayment() {
        super();
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Get the user ID from session
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            // User not logged in, redirect to login page
            response.sendRedirect(request.getContextPath() + "/user/login.jsp");
            return;
        }
        
        try {
            // Get parameters from the form
            int bikeId = Integer.parseInt(request.getParameter("bikeId"));
            String paymentMethod = request.getParameter("paymentMethod");
            BigDecimal totalAmount = new BigDecimal(request.getParameter("totalAmount"));
            
            // Get quantity from the form (default to 1 if not provided)
            int quantity = 1;
            try {
                quantity = Integer.parseInt(request.getParameter("quantity"));
                if (quantity < 1) quantity = 1; // Ensure minimum quantity
            } catch (NumberFormatException e) {
                // Use default quantity of 1 if parsing fails
            }
            
            // Get current date
            java.sql.Date currentDate = new java.sql.Date(Calendar.getInstance().getTime().getTime());
            
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            
            try {
                conn = DatabaseUtil.getConnection();
                conn.setAutoCommit(false); // Start transaction
                
                // 1. Create new order
                int orderId = createOrder(conn, currentDate);
                
                // 2. Add order details
                addOrderDetail(conn, orderId, bikeId, quantity);
                
                // 3. Create payment record
                int paymentId = createPayment(conn, totalAmount, paymentMethod, currentDate);
                
                // 4. Link order and payment
                linkOrderPayment(conn, orderId, paymentId);
                
                // 5. Link user and order
                linkUserOrder(conn, userId, orderId);
                
                // 6. Update bike stock
                updateBikeStock(conn, bikeId, quantity);
                
                // Commit the transaction
                conn.commit();
                
                // Success - redirect to thank you page
                response.sendRedirect(request.getContextPath() + "/user/thankyou.jsp?orderId=" + orderId);
                
            } catch (SQLException e) {
                // Rollback the transaction if there's an error
                if (conn != null) {
                    try {
                        conn.rollback();
                    } catch (SQLException ex) {
                        ex.printStackTrace();
                    }
                }
                e.printStackTrace();
                
                // Error - redirect to error page or back to payment page with error
                response.sendRedirect(request.getContextPath() + "/user/payment.jsp?bikeId=" + bikeId + "&error=true");
            } finally {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) {
                    conn.setAutoCommit(true); // Reset auto-commit
                    conn.close();
                }
            }
            
        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
    }
    
    /**
     * Create a new order in the database
     */
    private int createOrder(Connection conn, Date orderDate) throws SQLException {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            String sql = "INSERT INTO `order` (Order_Date, Status) VALUES (?, 'Pending')";
            pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setDate(1, orderDate);
            pstmt.executeUpdate();
            
            rs = pstmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                throw new SQLException("Creating order failed, no ID obtained.");
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
        }
    }
    
    /**
     * Add order details
     */
    private void addOrderDetail(Connection conn, int orderId, int bikeId, int quantity) throws SQLException {
        PreparedStatement pstmt = null;
        
        try {
            String sql = "INSERT INTO orderdetail (OrderID, BikeID, Quantity) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, orderId);
            pstmt.setInt(2, bikeId);
            pstmt.setInt(3, quantity);
            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
        }
    }
    
    /**
     * Create a payment record
     */
    private int createPayment(Connection conn, BigDecimal amount, String paymentMethod, Date paymentDate) throws SQLException {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            String sql = "INSERT INTO payment (Amount, Payment_Method, Payment_Status, Payment_Date) VALUES (?, ?, 'Completed', ?)";
            pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setBigDecimal(1, amount);
            pstmt.setString(2, paymentMethod);
            pstmt.setDate(3, paymentDate);
            pstmt.executeUpdate();
            
            rs = pstmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                throw new SQLException("Creating payment record failed, no ID obtained.");
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
        }
    }
    
    /**
     * Link order and payment
     */
    private void linkOrderPayment(Connection conn, int orderId, int paymentId) throws SQLException {
        PreparedStatement pstmt = null;
        
        try {
            String sql = "INSERT INTO order_payment (OrderID, PaymentID) VALUES (?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, orderId);
            pstmt.setInt(2, paymentId);
            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
        }
    }
    
    /**
     * Link user and order
     */
    private void linkUserOrder(Connection conn, int userId, int orderId) throws SQLException {
        PreparedStatement pstmt = null;
        
        try {
            String sql = "INSERT INTO user_order (UserID, OrderID) VALUES (?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            pstmt.setInt(2, orderId);
            pstmt.executeUpdate();
        } finally {
            if (pstmt != null) pstmt.close();
        }
    }
    
    /**
     * Update bike stock
     */
    private void updateBikeStock(Connection conn, int bikeId, int quantity) throws SQLException {
        PreparedStatement pstmt = null;
        
        try {
            String sql = "UPDATE bike SET Stock_Quantity = Stock_Quantity - ? WHERE BikeID = ? AND Stock_Quantity >= ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, quantity);
            pstmt.setInt(2, bikeId);
            pstmt.setInt(3, quantity);
            int rowsUpdated = pstmt.executeUpdate();
            
            if (rowsUpdated == 0) {
                throw new SQLException("Failed to update bike stock. Insufficient stock available.");
            }
        } finally {
            if (pstmt != null) pstmt.close();
        }
    }
}