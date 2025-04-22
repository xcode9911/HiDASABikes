package modal;

import java.math.BigDecimal;
import java.sql.Blob;

public class Bike {
    private int bikeId;
    private String brandName;
    private String modelName;
    private String type;
    private BigDecimal price;
    private String engineCapacity;
    private String fuelType;
    private String transmission;
    private String mileage;
    private String power;
    private String torque;
    private String coolingSystem;
    private String brakeType;
    private String suspensionType;
    private String kerbWeight;
    private String seatHeight;
    private String fuelTankCapacity;
    private String topSpeed;
    private String warrantyInfo;
    private int stockQuantity;
    private String description;
    private String color;
    private Blob bikeImage;

    // Default constructor
    public Bike() {
    }

    // Constructor with all fields
    public Bike(int bikeId, String brandName, String modelName, String type, BigDecimal price,
                String engineCapacity, String fuelType, String transmission, String mileage,
                String power, String torque, String coolingSystem, String brakeType,
                String suspensionType, String kerbWeight, String seatHeight, String fuelTankCapacity,
                String topSpeed, String warrantyInfo, int stockQuantity, String description,
                String color, Blob bikeImage) {
        this.bikeId = bikeId;
        this.brandName = brandName;
        this.modelName = modelName;
        this.type = type;
        this.price = price;
        this.engineCapacity = engineCapacity;
        this.fuelType = fuelType;
        this.transmission = transmission;
        this.mileage = mileage;
        this.power = power;
        this.torque = torque;
        this.coolingSystem = coolingSystem;
        this.brakeType = brakeType;
        this.suspensionType = suspensionType;
        this.kerbWeight = kerbWeight;
        this.seatHeight = seatHeight;
        this.fuelTankCapacity = fuelTankCapacity;
        this.topSpeed = topSpeed;
        this.warrantyInfo = warrantyInfo;
        this.stockQuantity = stockQuantity;
        this.description = description;
        this.color = color;
        this.bikeImage = bikeImage;
    }

    // Getters and Setters
    public int getBikeId() {
        return bikeId;
    }

    public void setBikeId(int bikeId) {
        this.bikeId = bikeId;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getModelName() {
        return modelName;
    }

    public void setModelName(String modelName) {
        this.modelName = modelName;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getEngineCapacity() {
        return engineCapacity;
    }

    public void setEngineCapacity(String engineCapacity) {
        this.engineCapacity = engineCapacity;
    }

    public String getFuelType() {
        return fuelType;
    }

    public void setFuelType(String fuelType) {
        this.fuelType = fuelType;
    }

    public String getTransmission() {
        return transmission;
    }

    public void setTransmission(String transmission) {
        this.transmission = transmission;
    }

    public String getMileage() {
        return mileage;
    }

    public void setMileage(String mileage) {
        this.mileage = mileage;
    }

    public String getPower() {
        return power;
    }

    public void setPower(String power) {
        this.power = power;
    }

    public String getTorque() {
        return torque;
    }

    public void setTorque(String torque) {
        this.torque = torque;
    }

    public String getCoolingSystem() {
        return coolingSystem;
    }

    public void setCoolingSystem(String coolingSystem) {
        this.coolingSystem = coolingSystem;
    }

    public String getBrakeType() {
        return brakeType;
    }

    public void setBrakeType(String brakeType) {
        this.brakeType = brakeType;
    }

    public String getSuspensionType() {
        return suspensionType;
    }

    public void setSuspensionType(String suspensionType) {
        this.suspensionType = suspensionType;
    }

    public String getKerbWeight() {
        return kerbWeight;
    }

    public void setKerbWeight(String kerbWeight) {
        this.kerbWeight = kerbWeight;
    }

    public String getSeatHeight() {
        return seatHeight;
    }

    public void setSeatHeight(String seatHeight) {
        this.seatHeight = seatHeight;
    }

    public String getFuelTankCapacity() {
        return fuelTankCapacity;
    }

    public void setFuelTankCapacity(String fuelTankCapacity) {
        this.fuelTankCapacity = fuelTankCapacity;
    }

    public String getTopSpeed() {
        return topSpeed;
    }

    public void setTopSpeed(String topSpeed) {
        this.topSpeed = topSpeed;
    }

    public String getWarrantyInfo() {
        return warrantyInfo;
    }

    public void setWarrantyInfo(String warrantyInfo) {
        this.warrantyInfo = warrantyInfo;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public Blob getBikeImage() {
        return bikeImage;
    }

    public void setBikeImage(Blob bikeImage) {
        this.bikeImage = bikeImage;
    }

    @Override
    public String toString() {
        return "Bike{" +
                "bikeId=" + bikeId +
                ", brandName='" + brandName + '\'' +
                ", modelName='" + modelName + '\'' +
                ", type='" + type + '\'' +
                ", price=" + price +
                ", engineCapacity='" + engineCapacity + '\'' +
                ", fuelType='" + fuelType + '\'' +
                ", transmission='" + transmission + '\'' +
                ", mileage='" + mileage + '\'' +
                ", power='" + power + '\'' +
                ", torque='" + torque + '\'' +
                ", coolingSystem='" + coolingSystem + '\'' +
                ", brakeType='" + brakeType + '\'' +
                ", suspensionType='" + suspensionType + '\'' +
                ", kerbWeight='" + kerbWeight + '\'' +
                ", seatHeight='" + seatHeight + '\'' +
                ", fuelTankCapacity='" + fuelTankCapacity + '\'' +
                ", topSpeed='" + topSpeed + '\'' +
                ", warrantyInfo='" + warrantyInfo + '\'' +
                ", stockQuantity=" + stockQuantity +
                ", description='" + description + '\'' +
                ", color='" + color + '\'' +
                '}';
    }
} 