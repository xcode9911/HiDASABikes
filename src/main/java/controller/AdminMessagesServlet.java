package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Calendar;

import dao.FeedbackDAO;
import dao.UserDAO;
import modal.Feedback;
import modal.User;

@WebServlet("/admin/messages")
public class AdminMessagesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private FeedbackDAO feedbackDAO;
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        feedbackDAO = new FeedbackDAO();
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("view".equals(action)) {
            handleViewMessage(request, response);
            return;
        }
        
        try {
            // Get all feedback messages with user information
            List<Map<String, Object>> messageList = new ArrayList<>();
            List<Feedback> feedbackList = feedbackDAO.getAllFeedback();
            
            // Get current date for reference
            Calendar cal = Calendar.getInstance();
            Date currentDate = cal.getTime();
            
            for (Feedback feedback : feedbackList) {
                Map<String, Object> messageData = new HashMap<>();
                messageData.put("feedback", feedback);
                
                // Generate a relative date based on feedback ID
                cal.setTime(currentDate);
                cal.add(Calendar.DAY_OF_MONTH, -feedback.getFeedbackId()); // Subtract days based on feedback ID
                Date messageDate = cal.getTime();
                messageData.put("messageDate", messageDate);
                
                // Get user information for this feedback
                List<User> users = userDAO.getUsersByFeedbackId(feedback.getFeedbackId());
                if (!users.isEmpty()) {
                    User user = users.get(0);
                    messageData.put("userName", user.getName());
                    messageData.put("userEmail", user.getEmail());
                } else {
                    messageData.put("userName", "Guest");
                    messageData.put("userEmail", "N/A");
                }
                
                messageList.add(messageData);
            }
            
            // Get message counts for dashboard cards
            int totalMessages = messageList.size();
            int unreadMessages = 0; // You might want to add a status field to feedback table later
            int pendingReplies = 0; // You might want to add a status field to feedback table later
            
            // Set attributes for the JSP
            request.setAttribute("messageList", messageList);
            request.setAttribute("totalMessages", totalMessages);
            request.setAttribute("unreadMessages", unreadMessages);
            request.setAttribute("pendingReplies", pendingReplies);
            
            // Forward to the messages JSP
            request.getRequestDispatcher("/admin/messages.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while fetching messages.");
            request.getRequestDispatcher("/admin/messages.jsp").forward(request, response);
        }
    }
    
    private void handleViewMessage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int feedbackId = Integer.parseInt(request.getParameter("id"));
            Feedback feedback = feedbackDAO.getFeedbackById(feedbackId);
            
            if (feedback != null) {
                List<User> users = userDAO.getUsersByFeedbackId(feedbackId);
                User user = !users.isEmpty() ? users.get(0) : null;
                
                // Generate a relative date based on feedback ID
                Calendar cal = Calendar.getInstance();
                cal.add(Calendar.DAY_OF_MONTH, -feedbackId);
                Date messageDate = cal.getTime();
                
                request.setAttribute("feedback", feedback);
                request.setAttribute("user", user);
                request.setAttribute("messageDate", messageDate);
                request.getRequestDispatcher("/admin/view-message.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/messages?error=message_not_found");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/messages?error=database_error");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Handle any POST requests (like filtering messages) here
        String filter = request.getParameter("filter");
        
        try {
            List<Map<String, Object>> messageList = new ArrayList<>();
            List<Feedback> feedbackList = feedbackDAO.getAllFeedback();
            
            for (Feedback feedback : feedbackList) {
                Map<String, Object> messageData = new HashMap<>();
                messageData.put("feedback", feedback);
                
                // Get user information for this feedback
                List<User> users = userDAO.getUsersByFeedbackId(feedback.getFeedbackId());
                if (!users.isEmpty()) {
                    User user = users.get(0);
                    messageData.put("userName", user.getName());
                    messageData.put("userEmail", user.getEmail());
                } else {
                    messageData.put("userName", "Guest");
                    messageData.put("userEmail", "N/A");
                }
                
                messageList.add(messageData);
            }
            
            // Apply filter if specified
            if (filter != null && !filter.isEmpty()) {
                request.setAttribute("selectedFilter", filter);
            }
            
            // Get message counts
            int totalMessages = messageList.size();
            int unreadMessages = 0;
            int pendingReplies = 0;
            
            // Set attributes
            request.setAttribute("messageList", messageList);
            request.setAttribute("totalMessages", totalMessages);
            request.setAttribute("unreadMessages", unreadMessages);
            request.setAttribute("pendingReplies", pendingReplies);
            
            // Forward to the messages JSP
            request.getRequestDispatcher("/admin/messages.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while processing your request.");
            request.getRequestDispatcher("/admin/messages.jsp").forward(request, response);
        }
    }
} 