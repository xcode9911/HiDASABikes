package modal;

import java.util.Date;

import java.util.List;

public class Order {
    private int orderId;
    private Date orderDate;
    private String status;
    private List<OrderDetail> orderDetails;

    // Default constructor
    public Order() {
    }

    // Constructor with fields
    public Order(int orderId, Date orderDate, String status) {
        this.orderId = orderId;
        this.orderDate = orderDate;
        this.status = status;
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

    // Calculate total amount of the order
    public double calculateTotal() {
        if (orderDetails == null || orderDetails.isEmpty()) {
            return 0.0;
    }

        double total = 0.0;
        for (OrderDetail detail : orderDetails) {
            if (detail.getBike() != null) {
                total += detail.getBike().getPrice() * detail.getQuantity();
    }
        }
        
        return total;
    }
    
    // Format total as string with commas
    public String getFormattedTotal() {
        java.text.NumberFormat formatter = java.text.NumberFormat.getNumberInstance(new java.util.Locale("en", "IN"));
        formatter.setMinimumFractionDigits(2);
        formatter.setMaximumFractionDigits(2);
        return formatter.format(calculateTotal());
    }

    // Format order date as string
    public String getFormattedDate() {
        if (orderDate == null) {
            return "";
        }
        java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("MMM dd, yyyy");
        return formatter.format(orderDate);
    }

    @Override
    public String toString() {
        return "Order [orderId=" + orderId + ", orderDate=" + orderDate + ", status=" + status + "]";
    }
} 