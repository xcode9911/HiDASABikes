package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import modal.Feedback;
import util.DatabaseUtil;

public class FeedbackDAO {
    // Create a new feedback entry
    public int createFeedback(Feedback feedback) throws SQLException {
        String sql = "INSERT INTO feedback (Subject, Message) VALUES (?, ?)";
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet generatedKeys = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            preparedStatement.setString(1, feedback.getSubject());
            preparedStatement.setString(2, feedback.getMessage());
            
            int affectedRows = preparedStatement.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Creating feedback failed, no rows affected.");
            }
            
            generatedKeys = preparedStatement.getGeneratedKeys();
            if (generatedKeys.next()) {
                return generatedKeys.getInt(1);
            } else {
                throw new SQLException("Creating feedback failed, no ID obtained.");
            }
        } finally {
            if (generatedKeys != null) try { generatedKeys.close(); } catch (SQLException e) { }
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { }
            if (connection != null) try { connection.close(); } catch (SQLException e) { }
        }
    }
    
    // Associate feedback with a user
    public boolean associateFeedbackWithUser(int userId, int feedbackId) throws SQLException {
        String sql = "INSERT INTO user_feedback (UserID, FeedbackID) VALUES (?, ?)";
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, feedbackId);
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { }
            if (connection != null) try { connection.close(); } catch (SQLException e) { }
        }
    }
    
    // Get all feedback entries
    public List<Feedback> getAllFeedback() throws SQLException {
        String sql = "SELECT * FROM feedback";
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
            
            List<Feedback> feedbackList = new ArrayList<>();
            while (resultSet.next()) {
                feedbackList.add(extractFeedbackFromResultSet(resultSet));
            }
            
            return feedbackList;
        } finally {
            if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { }
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { }
            if (connection != null) try { connection.close(); } catch (SQLException e) { }
        }
    }
    
    // Get feedback by user ID
    public List<Feedback> getFeedbackByUserId(int userId) throws SQLException {
        String sql = "SELECT f.* FROM feedback f " +
                     "JOIN user_feedback uf ON f.FeedbackID = uf.FeedbackID " +
                     "WHERE uf.UserID = ?";
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DatabaseUtil.getConnection();
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, userId);
            
            resultSet = preparedStatement.executeQuery();
            
            List<Feedback> feedbackList = new ArrayList<>();
            while (resultSet.next()) {
                feedbackList.add(extractFeedbackFromResultSet(resultSet));
            }
            
            return feedbackList;
        } finally {
            if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { }
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException e) { }
            if (connection != null) try { connection.close(); } catch (SQLException e) { }
        }
    }
    
    // Helper method to extract feedback from result set
    private Feedback extractFeedbackFromResultSet(ResultSet resultSet) throws SQLException {
        Feedback feedback = new Feedback();
        feedback.setFeedbackId(resultSet.getInt("FeedbackID"));
        feedback.setSubject(resultSet.getString("Subject"));
        feedback.setMessage(resultSet.getString("Message"));
        return feedback;
    }
} 