package controller;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import dao.UserDAO;
import modal.User;
import util.CookieUtil;
import dao.BikeDAO;
import modal.Bike;

/**
 * Servlet implementation class HomeServlet
 */
@WebServlet("/home")
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HomeServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Check if user is logged in
	    HttpSession session = request.getSession(false);
	    
	    // If no session, check for cookies to restore session
	    if (session == null || session.getAttribute("userId") == null) {
	        // Check for auth cookies
	        Cookie[] cookies = request.getCookies();
	        String authToken = CookieUtil.getCookieValue(cookies, "authToken");
	        String userEmail = CookieUtil.getCookieValue(cookies, "userEmail");
	        String userId = CookieUtil.getCookieValue(cookies, "userId");
	        
	        // If cookies exist, try to restore session
	        if (authToken != null && userEmail != null && userId != null) {
	            try {
	                // Initialize userDAO lazily
	                if (userDAO == null) {
	                    userDAO = new UserDAO();
	                }
	                
	                // Get user data
	                User user = userDAO.getUserByEmail(userEmail);
	                
	                // If user exists and ID matches, create a session
	                if (user != null && String.valueOf(user.getUserId()).equals(userId)) {
	                    // Create new session
	                    session = request.getSession(true);
	                    session.setAttribute("userId", user.getUserId());
	                    session.setAttribute("name", user.getName());
	                    session.setAttribute("email", user.getEmail());
	                    session.setAttribute("role", user.getRole());
	                    session.setMaxInactiveInterval(60 * 60); // 1 hour timeout
	                }
	            } catch (SQLException e) {
	                e.printStackTrace();
	                // Continue to homepage even if session restoration fails
	            }
	        }
	        
	        // No redirection to login page - allow access to homepage for everyone
	    }
	    
	    // Initialize BikeDAO
	    BikeDAO bikeDAO = null;
	    try {
	        bikeDAO = new BikeDAO();
	    } catch (Exception e) {
	        e.printStackTrace();
	        request.setAttribute("error", "Failed to connect to database: " + e.getMessage());
	        request.getRequestDispatcher("/user/home.jsp").forward(request, response);
	        return;
	    }
	    
	    try {
	        // Get featured bikes (latest 3)
	        List<Bike> featuredBikes = bikeDAO.getFeaturedBikes(3);
	        request.setAttribute("featuredBikes", featuredBikes);
	        
	        // Get all distinct bike types for categories
	        List<String> bikeTypes = bikeDAO.getDistinctBikeTypes();
	        request.setAttribute("bikeTypes", bikeTypes);
	        
	        // Create a map of bike counts by type
	        Map<String, Integer> bikeTypeCounts = new HashMap<>();
	        for (String type : bikeTypes) {
	            List<Bike> typeSpecificBikes = bikeDAO.getBikesByType(type);
	            bikeTypeCounts.put(type, typeSpecificBikes.size());
	        }
	        request.setAttribute("bikeTypeCounts", bikeTypeCounts);
	        
	        // Get total bike count
	        List<Bike> allBikes = bikeDAO.getAllBikes();
	        request.setAttribute("totalBikeCount", allBikes.size());
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	        request.setAttribute("error", "Failed to retrieve bike data: " + e.getMessage());
	    }
	    
		// Forward to home page
		request.getRequestDispatcher("/user/home.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
