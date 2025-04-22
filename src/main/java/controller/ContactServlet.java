package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

import dao.FeedbackDAO;
import modal.Feedback;

/**
 * Servlet implementation class ContactServlet
 */
@WebServlet("/contact")
public class ContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private FeedbackDAO feedbackDAO;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ContactServlet() {
        super();
        this.feedbackDAO = new FeedbackDAO();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward to the contact page
        request.getRequestDispatcher("/user/contactus.jsp").forward(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");
        String email = request.getParameter("email"); // Optional, only for non-logged in users
        String termsAgreed = request.getParameter("terms");
        
        // Get session to check if user is logged in
        HttpSession session = request.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("userId") != null);
        
        // Validate form data
        if (subject == null || subject.trim().isEmpty() || 
            message == null || message.trim().isEmpty() || 
            termsAgreed == null ||
            (!isLoggedIn && (email == null || email.trim().isEmpty()))) {
            
            // Send back to form with error message
            request.setAttribute("error", "Please fill in all required fields and agree to the terms.");
            request.getRequestDispatcher("/user/contactus.jsp").forward(request, response);
            return;
        }
        
        try {
            // Create a new feedback object
            Feedback feedback = new Feedback(subject, message);
            
            // Add email to subject for non-logged-in users to track who sent it
            if (!isLoggedIn && email != null && !email.trim().isEmpty()) {
                feedback.setSubject("[" + email + "] " + subject);
            }
            
            // Save feedback to database
            int feedbackId = feedbackDAO.createFeedback(feedback);
            
            // If user is logged in, associate the feedback with the user
            if (isLoggedIn) {
                Integer userId = (Integer) session.getAttribute("userId");
                feedbackDAO.associateFeedbackWithUser(userId, feedbackId);
            }
            
            // Redirect to thank you page
            response.sendRedirect(request.getContextPath() + "/thank-you?type=contact&name=" + 
                    (isLoggedIn ? session.getAttribute("name") : 
                        (email != null ? java.net.URLEncoder.encode(email, "UTF-8") : "Guest")));
            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while saving your message. Please try again later.");
            request.getRequestDispatcher("/user/contactus.jsp").forward(request, response);
        }
    }
} 