package dao;

import modal.Order;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

public interface OrderDAO {
    // Create a new order
    int addOrder(Order order) throws SQLException;
    
    // Retrieve an order by ID
    Order getOrderById(int orderId) throws SQLException;
    
    // Retrieve all orders
    List<Order> getAllOrders() throws SQLException;
    
    // Update an existing order
    boolean updateOrder(Order order) throws SQLException;
    
    // Delete an order by ID
    boolean deleteOrder(int orderId) throws SQLException;
    
    // Get orders by user ID
    List<Order> getOrdersByUserId(int userId) throws SQLException;
    
    // Get orders by status
    List<Order> getOrdersByStatus(String status) throws SQLException;
    
    // Get orders by date range
    List<Order> getOrdersByDateRange(Date startDate, Date endDate) throws SQLException;
    
    // Get orders with their details and payments
    Order getOrderWithDetailsAndPayments(int orderId) throws SQLException;
    
    // Update order status
    boolean updateOrderStatus(int orderId, String status) throws SQLException;
} 