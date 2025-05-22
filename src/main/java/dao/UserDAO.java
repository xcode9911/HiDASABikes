package dao;

import modal.User;
import util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    // Create a new user
    public int createUser(User user) throws SQLException {
        String sql = "INSERT INTO user (Name, Email, Phone, Password, Profile_Image, Role) VALUES (?, ?, ?, ?, ?, ?)";
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet generatedKeys = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getEmail());
            preparedStatement.setString(3, user.getPhone());
            preparedStatement.setString(4, user.getPassword());
            preparedStatement.setBytes(5, user.getProfileImage());
            preparedStatement.setString(6, user.getRole());
            
            int affectedRows = preparedStatement.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Creating user failed, no rows affected.");
            }
            
            generatedKeys = preparedStatement.getGeneratedKeys();
            if (generatedKeys.next()) {
                return generatedKeys.getInt(1);
            } else {
                throw new SQLException("Creating user failed, no ID obtained.");
            }
        } finally {
            if (generatedKeys != null) try { generatedKeys.close(); } catch (SQLException e) { }
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { }
            if (connection != null) try { connection.close(); } catch (SQLException e) { }
        }
    }
    
    // Get user by ID
    public User getUserById(int userId) throws SQLException {
        String sql = "SELECT * FROM user WHERE UserID = ?";
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, userId);
            
            resultSet = preparedStatement.executeQuery();
            
            if (resultSet.next()) {
                return extractUserFromResultSet(resultSet);
            } else {
                return null;
            }
        } finally {
            if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { }
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { }
            if (connection != null) try { connection.close(); } catch (SQLException e) { }
        }
    }
    
    // Get user by email
    public User getUserByEmail(String email) throws SQLException {
        String sql = "SELECT * FROM user WHERE Email = ?";
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, email);
            
            resultSet = preparedStatement.executeQuery();
            
            if (resultSet.next()) {
                return extractUserFromResultSet(resultSet);
            } else {
                return null;
            }
        } finally {
            if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { }
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { }
            if (connection != null) try { connection.close(); } catch (SQLException e) { }
        }
    }
    
    // Get all users
    public List<User> getAllUsers() throws SQLException {
        String sql = "SELECT * FROM user";
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            
            List<User> users = new ArrayList<>();
            while (resultSet.next()) {
                users.add(extractUserFromResultSet(resultSet));
            }
            
            return users;
        } finally {
            if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { }
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { }
            if (connection != null) try { connection.close(); } catch (SQLException e) { }
        }
    }
    
    // Update user
    public boolean updateUser(User user) throws SQLException {
        String sql = "UPDATE user SET Name = ?, Email = ?, Phone = ?, Password = ?, Profile_Image = ?, Role = ? WHERE UserID = ?";
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getEmail());
            preparedStatement.setString(3, user.getPhone());
            preparedStatement.setString(4, user.getPassword());
            preparedStatement.setBytes(5, user.getProfileImage());
            preparedStatement.setString(6, user.getRole());
            preparedStatement.setInt(7, user.getUserId());
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { }
            if (connection != null) try { connection.close(); } catch (SQLException e) { }
        }
    }
    
    // Delete user
    public boolean deleteUser(int userId) throws SQLException {
        String sql = "DELETE FROM user WHERE UserID = ?";
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, userId);
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { }
            if (connection != null) try { connection.close(); } catch (SQLException e) { }
        }
    }
    
    // Add address to user
    public boolean addAddressToUser(int userId, int addressId) throws SQLException {
        String sql = "INSERT INTO user_address (UserID, AddressID) VALUES (?, ?)";
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, addressId);
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { }
            if (connection != null) try { connection.close(); } catch (SQLException e) { }
        }
    }
    
    // Remove address from user
    public boolean removeAddressFromUser(int userId, int addressId) throws SQLException {
        String sql = "DELETE FROM user_address WHERE UserID = ? AND AddressID = ?";
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, addressId);
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { }
            if (connection != null) try { connection.close(); } catch (SQLException e) { }
        }
    }
    
    // Get all addresses for a user
    public List<Integer> getUserAddressIds(int userId) throws SQLException {
        String sql = "SELECT AddressID FROM user_address WHERE UserID = ?";
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, userId);
            
            resultSet = preparedStatement.executeQuery();
            
            List<Integer> addressIds = new ArrayList<>();
            while (resultSet.next()) {
                addressIds.add(resultSet.getInt("AddressID"));
            }
            
            return addressIds;
        } finally {
            if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { }
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { }
            if (connection != null) try { connection.close(); } catch (SQLException e) { }
        }
    }
    
    // Authenticate user
    public User authenticateUser(String email, String password) throws SQLException {
        String sql = "SELECT * FROM user WHERE Email = ? AND Password = ?";
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);
            
            resultSet = preparedStatement.executeQuery();
            
            if (resultSet.next()) {
                return extractUserFromResultSet(resultSet);
            } else {
                return null;
            }
        } finally {
            if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { }
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { }
            if (connection != null) try { connection.close(); } catch (SQLException e) { }
        }
    }
    
    // Update user profile image only
    public boolean updateProfileImage(int userId, byte[] imageData) throws SQLException {
        String sql = "UPDATE user SET Profile_Image = ? WHERE UserID = ?";
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            
            preparedStatement.setBytes(1, imageData);
            preparedStatement.setInt(2, userId);
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { }
            if (connection != null) try { connection.close(); } catch (SQLException e) { }
        }
    }
    
    // Get user by order ID
    public User getUserByOrderId(int orderId) throws SQLException {
        String sql = "SELECT u.* FROM user u " +
                    "JOIN user_order uo ON u.UserID = uo.UserID " +
                    "WHERE uo.OrderID = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, orderId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("UserID"));
                    user.setName(rs.getString("Name"));
                    user.setEmail(rs.getString("Email"));
                    user.setPhone(rs.getString("Phone"));
                    user.setRole(rs.getString("Role"));
                    return user;
                }
            }
        }
        
        return null;
    }
    
    public List<User> getUsersByFeedbackId(int feedbackId) throws SQLException {
        String sql = "SELECT u.* FROM user u " +
                    "JOIN user_feedback uf ON u.UserID = uf.UserID " +
                    "WHERE uf.FeedbackID = ?";
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, feedbackId);
            
            resultSet = preparedStatement.executeQuery();
            
            List<User> users = new ArrayList<>();
            while (resultSet.next()) {
                users.add(extractUserFromResultSet(resultSet));
            }
            
            return users;
        } finally {
            if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { }
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { }
            if (connection != null) try { connection.close(); } catch (SQLException e) { }
        }
    }
    
    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("UserID"));
        user.setName(rs.getString("Name"));
        user.setEmail(rs.getString("Email"));
        user.setPhone(rs.getString("Phone"));
        user.setPassword(rs.getString("Password"));
        
        // Fix: Convert Blob to byte array
        Blob profileImageBlob = rs.getBlob("Profile_Image");
        if (profileImageBlob != null) {
            user.setProfileImage(profileImageBlob.getBytes(1, (int) profileImageBlob.length()));
        } else {
            user.setProfileImage(null);
        }
        
        user.setRole(rs.getString("Role"));
        return user;
    }
} 