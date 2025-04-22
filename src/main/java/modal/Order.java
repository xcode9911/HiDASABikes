package modal;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Order {
    private int orderId;
    private Date orderDate;
    private String status;
    private List<OrderDetail> orderDetails;
    private List<Payment> payments;

    // Default constructor
    public Order() {
        this.orderDetails = new ArrayList<>();
        this.payments = new ArrayList<>();
    }

    // Constructor with all fields
    public Order(int orderId, Date orderDate, String status) {
        this.orderId = orderId;
        this.orderDate = orderDate;
        this.status = status;
        this.orderDetails = new ArrayList<>();
        this.payments = new ArrayList<>();
    }

    // Getters and Setters
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<OrderDetail> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }

    public List<Payment> getPayments() {
        return payments;
    }

    public void setPayments(List<Payment> payments) {
        this.payments = payments;
    }

    // Helper methods to add order details and payments
    public void addOrderDetail(OrderDetail orderDetail) {
        if (this.orderDetails == null) {
            this.orderDetails = new ArrayList<>();
        }
        this.orderDetails.add(orderDetail);
    }

    public void addPayment(Payment payment) {
        if (this.payments == null) {
            this.payments = new ArrayList<>();
        }
        this.payments.add(payment);
    }

    @Override
    public String toString() {
        return "Order{" +
                "orderId=" + orderId +
                ", orderDate=" + orderDate +
                ", status='" + status + '\'' +
                ", orderDetails=" + orderDetails +
                ", payments=" + payments +
                '}';
    }
} 