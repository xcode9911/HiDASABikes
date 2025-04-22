package dao;

import modal.Payment;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

public interface PaymentDAO {
    // Create a new payment
    int addPayment(Payment payment) throws SQLException;
    
    // Retrieve a payment by ID
    Payment getPaymentById(int paymentId) throws SQLException;
    
    // Retrieve all payments
    List<Payment> getAllPayments() throws SQLException;
    
    // Update an existing payment
    boolean updatePayment(Payment payment) throws SQLException;
    
    // Delete a payment by ID
    boolean deletePayment(int paymentId) throws SQLException;
    
    // Get payments by order ID
    List<Payment> getPaymentsByOrderId(int orderId) throws SQLException;
    
    // Get payments by status
    List<Payment> getPaymentsByStatus(String status) throws SQLException;
    
    // Get payments by date range
    List<Payment> getPaymentsByDateRange(Date startDate, Date endDate) throws SQLException;
    
    // Get payments by payment method
    List<Payment> getPaymentsByMethod(String paymentMethod) throws SQLException;
    
    // Update payment status
    boolean updatePaymentStatus(int paymentId, String status) throws SQLException;
    
    // Link payment to order
    boolean linkPaymentToOrder(int paymentId, int orderId) throws SQLException;
} 