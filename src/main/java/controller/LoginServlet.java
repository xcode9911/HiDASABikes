package controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.Base64;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modal.User;
import dao.UserDAO;
import util.CookieUtil;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    private static final int REMEMBER_ME_EXPIRY = 30 * 24 * 60 * 60; // 30 days in seconds
    private static final int DEFAULT_COOKIE_EXPIRY = 24 * 60 * 60; // 1 day in seconds

    public LoginServlet() {
        super();
        // Initialize userDAO lazily when needed, not in constructor
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // First check if user is already logged in via session
        HttpSession existingSession = request.getSession(false);
        if (existingSession != null && existingSession.getAttribute("userId") != null) {
            // User is already logged in, redirect to home page
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        // Check if user has user data cookies for auto-login
        Cookie[] cookies = request.getCookies();
        String authToken = CookieUtil.getCookieValue(cookies, "authToken");
        String userEmail = CookieUtil.getCookieValue(cookies, "userEmail");
        String userId = CookieUtil.getCookieValue(cookies, "userId");
        
        // If auth cookies exist, try auto-login
        if (authToken != null && userEmail != null && userId != null) {
            try {
                // Initialize userDAO only when needed
                if (userDAO == null) {
                    userDAO = new UserDAO();
                }
                
                User user = userDAO.getUserByEmail(userEmail);
                
                // If user exists and userId matches, auto-login
                if (user != null && String.valueOf(user.getUserId()).equals(userId)) {
                    // Create session and add user info
                    createUserSession(request, user);
                    
                    // Redirect to home page
                    response.sendRedirect(request.getContextPath() + "/home");
                    return;
                }
            } catch (SQLException e) {
                // Log error but continue to login page
                e.printStackTrace();
            }
        }
        
        // Forward to the login page if no auto-login or session
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    // Login functionality
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("remember");

        // Validate fields
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/login?error=missing_fields");
            return;
        }

        try {
            // Initialize userDAO only when needed
            if (userDAO == null) {
                userDAO = new UserDAO();
            }
            
            User user = userDAO.getUserByEmail(email);

            if (user != null && password.equals(user.getPassword())) {  // Password should be hashed in production!
                // Create session and add user info
                HttpSession session = createUserSession(request, user);
                
                // Generate an authentication token
                String authToken = UUID.randomUUID().toString();
                
                // Always set auth cookies for auto-login, but with different expiry times
                int cookieExpiry = (rememberMe != null && rememberMe.equals("on")) 
                                 ? REMEMBER_ME_EXPIRY 
                                 : DEFAULT_COOKIE_EXPIRY;
                
                // Encode values to prevent cookie issues with special characters
                String encodedEmail = URLEncoder.encode(user.getEmail(), StandardCharsets.UTF_8.toString());
                String encodedName = URLEncoder.encode(user.getName(), StandardCharsets.UTF_8.toString());
                String encodedUserId = String.valueOf(user.getUserId());
                
                // Create and add cookies with encoded values
                Cookie emailCookie = CookieUtil.createCookie("userEmail", encodedEmail, cookieExpiry, "/", true);
                Cookie authCookie = CookieUtil.createCookie("authToken", authToken, cookieExpiry, "/", true);
                Cookie userIdCookie = CookieUtil.createCookie("userId", encodedUserId, cookieExpiry, "/", true);
                Cookie userNameCookie = CookieUtil.createCookie("userName", encodedName, cookieExpiry, "/", false);
                
                response.addCookie(emailCookie);
                response.addCookie(authCookie);
                response.addCookie(userIdCookie);
                response.addCookie(userNameCookie);
                
                // Store the auth token in session for validation
                session.setAttribute("authToken", authToken);

                // Redirect to home page
                response.sendRedirect(request.getContextPath() + "/home");
            } else {
                // Invalid credentials
                response.sendRedirect(request.getContextPath() + "/login?error=invalid_credentials");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/login?error=database");
        } catch (RuntimeException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/login?error=database_connection");
        }
    }
    
    // Helper method to create user session
    private HttpSession createUserSession(HttpServletRequest request, User user) {
        HttpSession session = request.getSession(true);
        session.setAttribute("userId", user.getUserId());
        session.setAttribute("name", user.getName());
        session.setAttribute("email", user.getEmail());
        session.setAttribute("role", user.getRole());
        session.setMaxInactiveInterval(60 * 60); // Session timeout: 1 hour
        
        // Convert profile image to base64 and store in session
        if (user.getProfileImage() != null) {
            String base64Image = Base64.getEncoder().encodeToString(user.getProfileImage());
            session.setAttribute("Profile_Image", base64Image);
        }
        
        return session;
    }
}
