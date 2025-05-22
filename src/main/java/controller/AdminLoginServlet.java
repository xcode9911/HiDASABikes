package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import modal.User;

/**
 * Servlet implementation class AdminLoginServlet
 */
@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	// For demo purposes, hardcoded admin credentials
	// In a production environment, these would be stored securely in a database
	private static final String ADMIN_USERNAME = "admin";
	private static final String ADMIN_PASSWORD = "admin123";
       
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminLoginServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Check if already logged in
		HttpSession session = request.getSession(false);
		if (session != null && session.getAttribute("adminLoggedIn") != null && 
			(Boolean)session.getAttribute("adminLoggedIn")) {
			// Already logged in, redirect to dashboard
			response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
			return;
		}
		
		// Not logged in, show login page
		request.getRequestDispatcher("/admin/adminLogin.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Get form parameters
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String remember = request.getParameter("remember");
		
		// Validate credentials
		if (isValidAdmin(username, password)) {
			// Create session
			HttpSession session = request.getSession();
			
			// Create and store a User object with admin role
			User adminUser = new User();
			adminUser.setName(username);
			adminUser.setEmail(username);
			adminUser.setRole("admin");
			
			session.setAttribute("user", adminUser);
			session.setAttribute("adminLoggedIn", true);
			
			// Set session timeout (30 minutes)
			session.setMaxInactiveInterval(30 * 60);
			
			// If "Remember Me" is checked, set a cookie
			if (remember != null) {
				// In a real application, you would set a secure cookie with a token
				// For this demo, we'll just extend the session timeout
				session.setMaxInactiveInterval(7 * 24 * 60 * 60); // 7 days
			}
			
			// Log the successful login (in a real app, you would log to a database)
			System.out.println("Admin login successful: " + username);
			
			// Redirect to admin dashboard
			response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
		} else {
			// Set error message
			request.setAttribute("error", "Invalid username or password. Please try again.");
			
			// Log the failed attempt (in a real app, you would log to a database)
			System.out.println("Failed admin login attempt: " + username);
			
			// Forward back to login page with error
			request.getRequestDispatcher("/admin/adminLogin.jsp").forward(request, response);
		}
	}
	
	/**
	 * Validate admin credentials
	 * In a real application, this would check against a database
	 */
	private boolean isValidAdmin(String username, String password) {
		// For demo purposes, check against hardcoded credentials
		// In a production environment, this would use a secure password hash comparison
		return ADMIN_USERNAME.equals(username) && ADMIN_PASSWORD.equals(password);
	}
}
