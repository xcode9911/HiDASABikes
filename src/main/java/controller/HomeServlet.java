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

import dao.UserDAO;
import modal.User;
import util.CookieUtil;

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
        // TODO Auto-generated constructor stub
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
	                // If error occurs during session restoration, redirect to login
	                response.sendRedirect(request.getContextPath() + "/login?error=session_restore");
	                return;
	            }
	        }
	        
	        // If still no session after cookie check, redirect to login
	        if (session == null || session.getAttribute("userId") == null) {
	            response.sendRedirect(request.getContextPath() + "/login");
	            return;
	        }
	    }
	    
		// Forward to home page
		request.getRequestDispatcher("/user/home.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
