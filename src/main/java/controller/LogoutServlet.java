package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.CookieUtil;

/**
 * Servlet implementation class LogoutServlet
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LogoutServlet() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get current session
        HttpSession session = request.getSession(false);
        
        // Invalidate session if exists
        if (session != null) {
            session.invalidate();
        }
        
        // Remove all authentication cookies
        Cookie emailCookie = CookieUtil.deleteCookie("userEmail", "/");
        Cookie authCookie = CookieUtil.deleteCookie("authToken", "/");
        Cookie userIdCookie = CookieUtil.deleteCookie("userId", "/");
        Cookie userNameCookie = CookieUtil.deleteCookie("userName", "/");
        
        response.addCookie(emailCookie);
        response.addCookie(authCookie);
        response.addCookie(userIdCookie);
        response.addCookie(userNameCookie);
        
        // Redirect to login page with success message
        response.sendRedirect(request.getContextPath() + "/login.jsp?logout=success");
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
} 