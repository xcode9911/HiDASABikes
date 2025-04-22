package dao;

import modal.Address;
import util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AddressDAO {
    // Create a new address
    public int createAddress(Address address) throws SQLException {
        String sql = "INSERT INTO address (Street, City, State, ZipCode, Country) VALUES (?, ?, ?, ?, ?)";
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet generatedKeys = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            preparedStatement.setString(1, address.getStreet());
            preparedStatement.setString(2, address.getCity());
            preparedStatement.setString(3, address.getState());
            preparedStatement.setString(4, address.getZipCode());
            preparedStatement.setString(5, address.getCountry());
            
            int affectedRows = preparedStatement.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Creating address failed, no rows affected.");
            }
            
            generatedKeys = preparedStatement.getGeneratedKeys();
            if (generatedKeys.next()) {
                return generatedKeys.getInt(1);
            } else {
                throw new SQLException("Creating address failed, no ID obtained.");
            }
        } finally {
            if (generatedKeys != null) try { generatedKeys.close(); } catch (SQLException e) { }
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { }
            if (connection != null) try { connection.close(); } catch (SQLException e) { }
        }
    }
    
    // Get address by ID
    public Address getAddressById(int addressId) throws SQLException {
        String sql = "SELECT * FROM address WHERE AddressID = ?";
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, addressId);
            
            resultSet = preparedStatement.executeQuery();
            
            if (resultSet.next()) {
                return extractAddressFromResultSet(resultSet);
            } else {
                return null;
            }
        } finally {
            if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { }
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { }
            if (connection != null) try { connection.close(); } catch (SQLException e) { }
        }
    }
    
    // Get all addresses
    public List<Address> getAllAddresses() throws SQLException {
        String sql = "SELECT * FROM address";
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            
            List<Address> addresses = new ArrayList<>();
            while (resultSet.next()) {
                addresses.add(extractAddressFromResultSet(resultSet));
            }
            
            return addresses;
        } finally {
            if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { }
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { }
            if (connection != null) try { connection.close(); } catch (SQLException e) { }
        }
    }
    
    // Update address
    public boolean updateAddress(Address address) throws SQLException {
        String sql = "UPDATE address SET Street = ?, City = ?, State = ?, ZipCode = ?, Country = ? WHERE AddressID = ?";
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            
            preparedStatement.setString(1, address.getStreet());
            preparedStatement.setString(2, address.getCity());
            preparedStatement.setString(3, address.getState());
            preparedStatement.setString(4, address.getZipCode());
            preparedStatement.setString(5, address.getCountry());
            preparedStatement.setInt(6, address.getAddressId());
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { }
            if (connection != null) try { connection.close(); } catch (SQLException e) { }
        }
    }
    
    // Delete address
    public boolean deleteAddress(int addressId) throws SQLException {
        String sql = "DELETE FROM address WHERE AddressID = ?";
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, addressId);
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { }
            if (connection != null) try { connection.close(); } catch (SQLException e) { }
        }
    }
    
    // Get all users for an address
    public List<Integer> getUsersForAddress(int addressId) throws SQLException {
        String sql = "SELECT UserID FROM user_address WHERE AddressID = ?";
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, addressId);
            
            resultSet = preparedStatement.executeQuery();
            
            List<Integer> userIds = new ArrayList<>();
            while (resultSet.next()) {
                userIds.add(resultSet.getInt("UserID"));
            }
            
            return userIds;
        } finally {
            if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { }
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { }
            if (connection != null) try { connection.close(); } catch (SQLException e) { }
        }
    }
    
    private Address extractAddressFromResultSet(ResultSet rs) throws SQLException {
        Address address = new Address();
        address.setAddressId(rs.getInt("AddressID"));
        address.setStreet(rs.getString("Street"));
        address.setCity(rs.getString("City"));
        address.setState(rs.getString("State"));
        address.setZipCode(rs.getString("ZipCode"));
        address.setCountry(rs.getString("Country"));
        return address;
    }
} 