package dao;

import modal.OrderDetail;
import java.sql.SQLException;
import java.util.List;

public interface OrderDetailDAO {
    // Create a new order detail
    int addOrderDetail(OrderDetail orderDetail) throws SQLException;
    
    // Retrieve an order detail by ID
    OrderDetail getOrderDetailById(int orderDetailId) throws SQLException;
    
    // Retrieve all order details
    List<OrderDetail> getAllOrderDetails() throws SQLException;
    
    // Update an existing order detail
    boolean updateOrderDetail(OrderDetail orderDetail) throws SQLException;
    
    // Delete an order detail by ID
    boolean deleteOrderDetail(int orderDetailId) throws SQLException;
    
    // Get order details by order ID
    List<OrderDetail> getOrderDetailsByOrderId(int orderId) throws SQLException;
    
    // Get order details by bike ID
    List<OrderDetail> getOrderDetailsByBikeId(int bikeId) throws SQLException;
    
    // Get order details with bike information
    List<OrderDetail> getOrderDetailsWithBikeInfo(int orderId) throws SQLException;
    
    // Update order detail quantity
    boolean updateOrderDetailQuantity(int orderDetailId, int quantity) throws SQLException;
} 