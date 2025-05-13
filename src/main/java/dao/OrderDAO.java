package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import modal.Order;
import modal.OrderDetail;
import modal.Bike;
import util.DatabaseUtil;

public class OrderDAO {
    private BikeDAO bikeDAO;
    
    public OrderDAO() {
        this.bikeDAO = new BikeDAO();
    }
    
    // Get all orders for a specific user
    public List<Order> getOrdersByUserId(int userId) throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.* FROM `order` o " +
                     "JOIN user_order uo ON o.OrderID = uo.OrderID " +
                     "WHERE uo.UserID = ? " +
                     "ORDER BY o.Order_Date DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Order order = extractOrderFromResultSet(rs);
                    // Get order details for this order
                    order.setOrderDetails(getOrderDetailsByOrderId(order.getOrderId()));
                    orders.add(order);
                }
            }
        }
        
        return orders;
    }
    
    // Get a specific order by ID
    public Order getOrderById(int orderId) throws SQLException {
        String sql = "SELECT * FROM `order` WHERE OrderID = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, orderId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Order order = extractOrderFromResultSet(rs);
                    // Get order details
                    order.setOrderDetails(getOrderDetailsByOrderId(orderId));
                    return order;
                }
            }
        }
        
        return null;
    }
    
    // Get order details for a specific order
    public List<OrderDetail> getOrderDetailsByOrderId(int orderId) throws SQLException {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String sql = "SELECT * FROM orderdetail WHERE OrderID = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, orderId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    OrderDetail detail = new OrderDetail();
                    detail.setOrderDetailId(rs.getInt("OrderDetailID"));
                    detail.setOrderId(rs.getInt("OrderID"));
                    detail.setBikeId(rs.getInt("BikeID"));
                    detail.setQuantity(rs.getInt("Quantity"));
                    
                    // Get bike information
                    Bike bike = bikeDAO.getBikeById(detail.getBikeId());
                    detail.setBike(bike);
                    
                    orderDetails.add(detail);
                }
            }
        }
        
        return orderDetails;
    }
    
    // Create a new order
    public int createOrder(Order order, int userId) throws SQLException {
        Connection conn = null;
        PreparedStatement orderStmt = null;
        PreparedStatement userOrderStmt = null;
        PreparedStatement orderDetailStmt = null;
        ResultSet generatedKeys = null;
        
        try {
            System.out.println("Starting createOrder for user ID: " + userId);
            conn = DatabaseUtil.getConnection();
            conn.setAutoCommit(false); // Start transaction
            
            // Create order
            String orderSql = "INSERT INTO `order` (Order_Date, Status) VALUES (?, ?)";
            orderStmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
            orderStmt.setDate(1, new java.sql.Date(order.getOrderDate().getTime()));
            orderStmt.setString(2, order.getStatus());
            System.out.println("Executing order insert with Date: " + order.getOrderDate() + ", Status: " + order.getStatus());
            
            int affectedRows = orderStmt.executeUpdate();
            if (affectedRows == 0) {
                System.out.println("Creating order failed, no rows affected");
                throw new SQLException("Creating order failed, no rows affected.");
            }
            
            generatedKeys = orderStmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                int orderId = generatedKeys.getInt(1);
                order.setOrderId(orderId);
                System.out.println("New order created with ID: " + orderId);
                
                // Create user_order relationship
                String userOrderSql = "INSERT INTO user_order (UserID, OrderID) VALUES (?, ?)";
                userOrderStmt = conn.prepareStatement(userOrderSql);
                userOrderStmt.setInt(1, userId);
                userOrderStmt.setInt(2, orderId);
                System.out.println("Creating user_order relationship: User ID " + userId + ", Order ID " + orderId);
                userOrderStmt.executeUpdate();
    
                // Create order details
                if (order.getOrderDetails() != null && !order.getOrderDetails().isEmpty()) {
                    String orderDetailSql = "INSERT INTO orderdetail (OrderID, BikeID, Quantity) VALUES (?, ?, ?)";
                    orderDetailStmt = conn.prepareStatement(orderDetailSql);
                    System.out.println("Creating " + order.getOrderDetails().size() + " order details");
                    
                    for (OrderDetail detail : order.getOrderDetails()) {
                        orderDetailStmt.setInt(1, orderId);
                        orderDetailStmt.setInt(2, detail.getBikeId());
                        orderDetailStmt.setInt(3, detail.getQuantity());
                        orderDetailStmt.addBatch();
                        System.out.println("Added order detail: Bike ID " + detail.getBikeId() + ", Quantity " + detail.getQuantity());
                        
                        // Update stock quantity in bike table
                        updateBikeStock(conn, detail.getBikeId(), detail.getQuantity());
                    }
                    
                    orderDetailStmt.executeBatch();
                }
                
                System.out.println("Committing transaction for order ID: " + orderId);
                conn.commit(); // Commit transaction
                return orderId;
            }
            
            // If we get here, no ID was generated
            System.out.println("Creating order failed, no ID obtained");
            conn.rollback(); // Rollback transaction
            throw new SQLException("Creating order failed, no ID obtained.");
        } catch (SQLException e) {
            // Rollback transaction on error
            System.out.println("SQL error in createOrder: " + e.getMessage());
            e.printStackTrace();
            if (conn != null) {
                try {
                    System.out.println("Rolling back transaction due to error");
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            throw e;
        } finally {
            // Close resources and reset auto-commit
            if (generatedKeys != null) try { generatedKeys.close(); } catch (SQLException e) { }
            if (orderDetailStmt != null) try { orderDetailStmt.close(); } catch (SQLException e) { }
            if (userOrderStmt != null) try { userOrderStmt.close(); } catch (SQLException e) { }
            if (orderStmt != null) try { orderStmt.close(); } catch (SQLException e) { }
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) { }
            }
            System.out.println("createOrder method completed");
        }
    }
    
    // Update bike stock when order is placed
    private void updateBikeStock(Connection conn, int bikeId, int quantity) throws SQLException {
        String sql = "UPDATE bike SET Stock_Quantity = Stock_Quantity - ? WHERE BikeID = ?";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, quantity);
            stmt.setInt(2, bikeId);
            stmt.executeUpdate();
        }
    }
    
    // Update order status
    public boolean updateOrderStatus(int orderId, String status) throws SQLException {
        String sql = "UPDATE `order` SET Status = ? WHERE OrderID = ?";
        System.out.println("Executing SQL: " + sql + " with orderId=" + orderId + ", status=" + status);
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            
            int affectedRows = stmt.executeUpdate();
            System.out.println("Affected rows: " + affectedRows);
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("SQL Exception in updateOrderStatus: " + e.getMessage());
            throw e;
        }
    }
    
    // Cancel an order and restore stock quantities
    public boolean cancelOrder(int orderId) throws SQLException {
        Connection conn = null;
        PreparedStatement updateStatusStmt = null;
        
        try {
            conn = DatabaseUtil.getConnection();
            conn.setAutoCommit(false); // Start transaction
            
            // Get order details to restore stock
            List<OrderDetail> details = getOrderDetailsByOrderId(orderId);
            
            // Update order status to canceled
            String updateStatusSql = "UPDATE `order` SET Status = 'Cancelled' WHERE OrderID = ?";
            updateStatusStmt = conn.prepareStatement(updateStatusSql);
            updateStatusStmt.setInt(1, orderId);
            
            int affectedRows = updateStatusStmt.executeUpdate();
            if (affectedRows > 0) {
                // Restore stock quantities
                for (OrderDetail detail : details) {
                    restoreBikeStock(conn, detail.getBikeId(), detail.getQuantity());
                }
                
                conn.commit(); // Commit transaction
                return true;
            } else {
                conn.rollback(); // Rollback transaction
                return false;
            }
        } catch (SQLException e) {
            // Rollback transaction on error
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            throw e;
        } finally {
            // Close resources and reset auto-commit
            if (updateStatusStmt != null) try { updateStatusStmt.close(); } catch (SQLException e) { }
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) { }
            }
        }
    }
    
    // Restore bike stock when order is canceled
    private void restoreBikeStock(Connection conn, int bikeId, int quantity) throws SQLException {
        String sql = "UPDATE bike SET Stock_Quantity = Stock_Quantity + ? WHERE BikeID = ?";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, quantity);
            stmt.setInt(2, bikeId);
            stmt.executeUpdate();
        }
    }
    
    // Helper method to extract Order entity from ResultSet
    private Order extractOrderFromResultSet(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setOrderId(rs.getInt("OrderID"));
        order.setOrderDate(rs.getDate("Order_Date"));
        order.setStatus(rs.getString("Status"));
        return order;
    }
    
    // Get all orders
    public List<Order> getAllOrders() throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM `order` ORDER BY Order_Date DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Order order = extractOrderFromResultSet(rs);
                // Get order details for this order
                order.setOrderDetails(getOrderDetailsByOrderId(order.getOrderId()));
                orders.add(order);
            }
        }
        
        return orders;
    }
} 