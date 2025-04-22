package modal;

public class OrderDetail {
    private int orderDetailId;
    private int orderId;
    private int bikeId;
    private int quantity;
    private Bike bike; // Reference to the Bike object

    // Default constructor
    public OrderDetail() {
    }

    // Constructor with all fields
    public OrderDetail(int orderDetailId, int orderId, int bikeId, int quantity) {
        this.orderDetailId = orderDetailId;
        this.orderId = orderId;
        this.bikeId = bikeId;
        this.quantity = quantity;
    }

    // Constructor with Bike object
    public OrderDetail(int orderDetailId, int orderId, Bike bike, int quantity) {
        this.orderDetailId = orderDetailId;
        this.orderId = orderId;
        this.bikeId = bike.getBikeId();
        this.bike = bike;
        this.quantity = quantity;
    }

    // Getters and Setters
    public int getOrderDetailId() {
        return orderDetailId;
    }

    public void setOrderDetailId(int orderDetailId) {
        this.orderDetailId = orderDetailId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getBikeId() {
        return bikeId;
    }

    public void setBikeId(int bikeId) {
        this.bikeId = bikeId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Bike getBike() {
        return bike;
    }

    public void setBike(Bike bike) {
        this.bike = bike;
        if (bike != null) {
            this.bikeId = bike.getBikeId();
        }
    }

    @Override
    public String toString() {
        return "OrderDetail{" +
                "orderDetailId=" + orderDetailId +
                ", orderId=" + orderId +
                ", bikeId=" + bikeId +
                ", quantity=" + quantity +
                ", bike=" + bike +
                '}';
    }
} 