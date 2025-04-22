package dao;

import modal.Bike;

import java.sql.SQLException;
import java.util.List;

public interface BikeDAO {
    // Create a new bike
    int addBike(Bike bike) throws SQLException;
    
    // Retrieve a bike by ID
    Bike getBikeById(int bikeId) throws SQLException;
    
    // Retrieve all bikes
    List<Bike> getAllBikes() throws SQLException;
    
    // Update an existing bike
    boolean updateBike(Bike bike) throws SQLException;
    
    // Delete a bike by ID
    boolean deleteBike(int bikeId) throws SQLException;
    
    // Search bikes by brand name
    List<Bike> searchBikesByBrand(String brandName) throws SQLException;
    
    // Search bikes by model name
    List<Bike> searchBikesByModel(String modelName) throws SQLException;
    
    // Search bikes by type
    List<Bike> searchBikesByType(String type) throws SQLException;
    
    // Get bikes with low stock (below a certain threshold)
    List<Bike> getBikesWithLowStock(int threshold) throws SQLException;
    
    // Update bike stock quantity
    boolean updateBikeStock(int bikeId, int newQuantity) throws SQLException;
} 