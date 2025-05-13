package modal;

import java.util.Date;


import java.util.List;

/**
 * Represents a sale in the system
 */
public class Sales {
    private int saleId;
    private Date saleDate;
    private double totalSaleAmount;
    private List<Order> orders; // Related orders
    private List<Payment> payments; // Related payments

    // Default constructor
    public Sales() {
    }

    // Constructor with basic fields
    public Sales(int saleId, Date saleDate, double totalSaleAmount) {
        this.saleId = saleId;
        this.saleDate = saleDate;
        this.totalSaleAmount = totalSaleAmount;
    }

    // Getters and Setters
    public int getSaleId() {
        return saleId;
    }

    public void setSaleId(int saleId) {
        this.saleId = saleId;
    }

    public Date getSaleDate() {
        return saleDate;
    }

    public void setSaleDate(Date saleDate) {
        this.saleDate = saleDate;
    }

    public double getTotalSaleAmount() {
        return totalSaleAmount;
    }

    public void setTotalSaleAmount(double totalSaleAmount) {
        this.totalSaleAmount = totalSaleAmount;
    }

    public List<Order> getOrders() {
        return orders;
    }

    public void setOrders(List<Order> orders) {
        this.orders = orders;
    }

    public List<Payment> getPayments() {
        return payments;
    }

    public void setPayments(List<Payment> payments) {
        this.payments = payments;
    }

    // Helper method to format price as string with commas
    public String getFormattedTotalAmount() {
        return String.format("%,.2f", totalSaleAmount);
    }

    // Helper method to get month name from sale date
    public String getMonthName() {
        if (saleDate == null) return "";
        String[] months = {"January", "February", "March", "April", "May", "June",
                          "July", "August", "September", "October", "November", "December"};
        return months[saleDate.getMonth()];
    }

    // Helper method to get year from sale date
    public int getYear() {
        return saleDate != null ? saleDate.getYear() + 1900 : 0;
    }

    @Override
    public String toString() {
        return "Sales{" +
                "saleId=" + saleId +
                ", saleDate=" + saleDate +
                ", totalSaleAmount=" + totalSaleAmount +
                ", orders=" + (orders != null ? orders.size() : 0) +
                ", payments=" + (payments != null ? payments.size() : 0) +
                '}';
    }
} 