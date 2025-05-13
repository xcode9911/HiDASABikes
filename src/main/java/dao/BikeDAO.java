package dao;

import java.sql.*;

import java.util.ArrayList;
import java.util.List;

import modal.Bike;
import util.DatabaseUtil;

public class BikeDAO {
    
    // Get all bikes
    public List<Bike> getAllBikes() throws SQLException {
        String sql = "SELECT * FROM bike";
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            
            List<Bike> bikes = new ArrayList<>();
            while (resultSet.next()) {
                bikes.add(extractBikeFromResultSet(resultSet));
            }
            
            return bikes;
        } finally {
            if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { }
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { }
            if (connection != null) try { connection.close(); } catch (SQLException e) { }
        }
    }
    
    // Get featured bikes (limit to a specific number)
    public List<Bike> getFeaturedBikes(int limit) throws SQLException {
        String sql = "SELECT * FROM bike ORDER BY BikeID DESC LIMIT ?";
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, limit);
            resultSet = preparedStatement.executeQuery();
            
            List<Bike> bikes = new ArrayList<>();
            while (resultSet.next()) {
                bikes.add(extractBikeFromResultSet(resultSet));
            }
            
            return bikes;
        } finally {
            if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { }
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { }
            if (connection != null) try { connection.close(); } catch (SQLException e) { }
        }
    }
    
    // Get bike by ID
    public Bike getBikeById(int bikeId) throws SQLException {
        String sql = "SELECT * FROM bike WHERE BikeID = ?";
        System.out.println("Executing SQL query: " + sql + " with bikeId: " + bikeId);
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            System.out.println("Database connection established");
            
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, bikeId);
            System.out.println("Prepared statement created with bikeId: " + bikeId);
            
            resultSet = preparedStatement.executeQuery();
            System.out.println("Query executed");
            
            if (resultSet.next()) {
                System.out.println("Bike found in database");
                Bike bike = extractBikeFromResultSet(resultSet);
                System.out.println("Bike data extracted: " + bike.getBrandName() + " " + bike.getModelName());
                return bike;
            } else {
                System.out.println("No bike found with ID: " + bikeId);
                return null;
            }
        } catch (SQLException e) {
            System.out.println("SQL Exception in getBikeById: " + e.getMessage());
            e.printStackTrace();
            throw e;
        } finally {
            if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { }
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { }
            if (connection != null) try { connection.close(); } catch (SQLException e) { }
            System.out.println("Database resources closed");
        }
    }
    
    // Search bikes by brand, model, or type
    public List<Bike> searchBikes(String keyword) throws SQLException {
        String sql = "SELECT * FROM bike WHERE Brand_Name LIKE ? OR Model_Name LIKE ? OR Type LIKE ?";
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            String searchTerm = "%" + keyword + "%";
            preparedStatement.setString(1, searchTerm);
            preparedStatement.setString(2, searchTerm);
            preparedStatement.setString(3, searchTerm);
            
            resultSet = preparedStatement.executeQuery();
            
            List<Bike> bikes = new ArrayList<>();
            while (resultSet.next()) {
                bikes.add(extractBikeFromResultSet(resultSet));
            }
            
            return bikes;
        } finally {
            if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { }
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { }
            if (connection != null) try { connection.close(); } catch (SQLException e) { }
        }
    }
    
    // Get bikes by type
    public List<Bike> getBikesByType(String type) throws SQLException {
        String sql = "SELECT * FROM bike WHERE Type = ?";
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, type);
            
            resultSet = preparedStatement.executeQuery();
            
            List<Bike> bikes = new ArrayList<>();
            while (resultSet.next()) {
                bikes.add(extractBikeFromResultSet(resultSet));
            }
            
            return bikes;
        } finally {
            if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { }
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { }
            if (connection != null) try { connection.close(); } catch (SQLException e) { }
        }
    }
    
    // Helper method to extract bike from ResultSet
    private Bike extractBikeFromResultSet(ResultSet rs) throws SQLException {
        Bike bike = new Bike();
        bike.setBikeId(rs.getInt("BikeID"));
        bike.setBrandName(rs.getString("Brand_Name"));
        bike.setModelName(rs.getString("Model_Name"));
        bike.setType(rs.getString("Type"));
        bike.setPrice(rs.getDouble("Price"));
        bike.setEngineCapacity(rs.getString("Engine_Capacity"));
        bike.setFuelType(rs.getString("Fuel_Type"));
        bike.setTransmission(rs.getString("Transmission"));
        bike.setMileage(rs.getString("Mileage"));
        bike.setPower(rs.getString("Power"));
        bike.setTorque(rs.getString("Torque"));
        bike.setCoolingSystem(rs.getString("Cooling_System"));
        bike.setBrakeType(rs.getString("Brake_Type"));
        bike.setSuspensionType(rs.getString("Suspension_Type"));
        bike.setKerbWeight(rs.getString("Kerb_Weight"));
        bike.setSeatHeight(rs.getString("Seat_Height"));
        bike.setFuelTankCapacity(rs.getString("Fuel_Tank_Capacity"));
        bike.setTopSpeed(rs.getString("Top_Speed"));
        bike.setWarrantyInfo(rs.getString("Warranty_Info"));
        bike.setStockQuantity(rs.getInt("Stock_Quantity"));
        bike.setDescription(rs.getString("Description"));
        bike.setColor(rs.getString("Color"));
        
        // Handle bike image (might be BLOB or null)
        Blob imageBlob = rs.getBlob("Bike_Image");
        if (imageBlob != null) {
            bike.setBikeImage(imageBlob.getBytes(1, (int) imageBlob.length()));
        }
        
        return bike;
    }

    
    // Update a bike in the database
    public boolean updateBike(Bike bike) {
        String sql = "UPDATE bike SET Brand_Name = ?, Model_Name = ?, Type = ?, Price = ?, Engine_Capacity = ?, " +
                     "Fuel_Type = ?, Transmission = ?, Mileage = ?, Power = ?, Torque = ?, Cooling_System = ?, " +
                     "Brake_Type = ?, Suspension_Type = ?, Kerb_Weight = ?, Seat_Height = ?, Fuel_Tank_Capacity = ?, " +
                     "Top_Speed = ?, Warranty_Info = ?, Stock_Quantity = ?, Description = ?, Color = ?, Bike_Image = ? " +
                     "WHERE BikeID = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, bike.getBrandName());
            pstmt.setString(2, bike.getModelName());
            pstmt.setString(3, bike.getType());
            pstmt.setDouble(4, bike.getPrice());
            pstmt.setString(5, bike.getEngineCapacity());
            pstmt.setString(6, bike.getFuelType());
            pstmt.setString(7, bike.getTransmission());
            pstmt.setString(8, bike.getMileage());
            pstmt.setString(9, bike.getPower());
            pstmt.setString(10, bike.getTorque());
            pstmt.setString(11, bike.getCoolingSystem());
            pstmt.setString(12, bike.getBrakeType());
            pstmt.setString(13, bike.getSuspensionType());
            pstmt.setString(14, bike.getKerbWeight());
            pstmt.setString(15, bike.getSeatHeight());
            pstmt.setString(16, bike.getFuelTankCapacity());
            pstmt.setString(17, bike.getTopSpeed());
            pstmt.setString(18, bike.getWarrantyInfo());
            pstmt.setInt(19, bike.getStockQuantity());
            pstmt.setString(20, bike.getDescription());
            pstmt.setString(21, bike.getColor());
            
            // Handle bike image
            if (bike.getBikeImage() != null) {
                pstmt.setBytes(22, bike.getBikeImage());
            } else {
                pstmt.setNull(22, java.sql.Types.BLOB);
            }
            
            pstmt.setInt(23, bike.getBikeId());
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Delete a bike from the database
    public boolean deleteBike(int bikeId) {
        String sql = "DELETE FROM bike WHERE BikeID = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, bikeId);
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Add a new bike to the database
    public boolean addBike(Bike bike) {
        String sql = "INSERT INTO bike (Brand_Name, Model_Name, Type, Price, Engine_Capacity, " +
                     "Fuel_Type, Transmission, Mileage, Power, Torque, Cooling_System, " +
                     "Brake_Type, Suspension_Type, Kerb_Weight, Seat_Height, Fuel_Tank_Capacity, " +
                     "Top_Speed, Warranty_Info, Stock_Quantity, Description, Color, Bike_Image) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setString(1, bike.getBrandName());
            pstmt.setString(2, bike.getModelName());
            pstmt.setString(3, bike.getType());
            pstmt.setDouble(4, bike.getPrice());
            pstmt.setString(5, bike.getEngineCapacity());
            pstmt.setString(6, bike.getFuelType());
            pstmt.setString(7, bike.getTransmission());
            pstmt.setString(8, bike.getMileage());
            pstmt.setString(9, bike.getPower());
            pstmt.setString(10, bike.getTorque());
            pstmt.setString(11, bike.getCoolingSystem());
            pstmt.setString(12, bike.getBrakeType());
            pstmt.setString(13, bike.getSuspensionType());
            pstmt.setString(14, bike.getKerbWeight());
            pstmt.setString(15, bike.getSeatHeight());
            pstmt.setString(16, bike.getFuelTankCapacity());
            pstmt.setString(17, bike.getTopSpeed());
            pstmt.setString(18, bike.getWarrantyInfo());
            pstmt.setInt(19, bike.getStockQuantity());
            pstmt.setString(20, bike.getDescription());
            pstmt.setString(21, bike.getColor());
            
            // Handle bike image
            if (bike.getBikeImage() != null) {
                pstmt.setBytes(22, bike.getBikeImage());
            } else {
                pstmt.setNull(22, java.sql.Types.BLOB);
            }
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        bike.setBikeId(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Get bikes with low stock (less than 5)
    public List<Bike> getLowStockBikes() {
        List<Bike> bikes = new ArrayList<>();
        String sql = "SELECT * FROM bike WHERE Stock_Quantity < 5";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                bikes.add(extractBikeFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return bikes;
    }
    
    // Get the 5 most recently added bikes
    public List<Bike> getRecentBikes() {
        List<Bike> bikes = new ArrayList<>();
        String sql = "SELECT * FROM bike ORDER BY BikeID DESC LIMIT 5";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                bikes.add(extractBikeFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return bikes;
    }
    
    // Get distinct bike types for categories
    public List<String> getDistinctBikeTypes() {
        List<String> types = new ArrayList<>();
        String sql = "SELECT DISTINCT Type FROM bike WHERE Type IS NOT NULL ORDER BY Type";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                types.add(rs.getString("Type"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return types;
    }
} 