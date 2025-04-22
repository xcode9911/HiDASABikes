package filter;

import java.io.IOException;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import java.util.logging.Logger;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modal.User;
import dao.UserDAO;
import util.CookieUtil;

/**
 * Authentication filter to protect secure resources
 */
@WebFilter(urlPatterns = {"/home", "/user/*", "/profile", "/orders", "/settings"})
public class AuthFilter implements Filter {
    private static final Logger logger = Logger.getLogger(AuthFilter.class.getName());
    private UserDAO userDAO;
    
    // Public resources that don't require authentication
    private static final Set<String> PUBLIC_PATHS = new HashSet<>(
        Arrays.asList("/login", "/register", "/index.jsp", "/login.jsp", "/assets/", "/js/", "/css/", "/images/")
    );
    
    // File extensions that should be accessible without authentication
    private static final Set<String> PUBLIC_EXTENSIONS = new HashSet<>(
        Arrays.asList(".css", ".js", ".png", ".jpg", ".jpeg", ".gif", ".svg", ".ico", ".woff", ".woff2", ".ttf")
    );

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        logger.info("AuthFilter initialized");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // Get context path and request URI
        String contextPath = httpRequest.getContextPath();
        String requestURI = httpRequest.getRequestURI();
        String path = requestURI.substring(contextPath.length());
        
        // Check if this is a public resource
        if (isPublicResource(path)) {
            chain.doFilter(request, response);
            return;
        }
        
        // Get existing session (don't create a new one)
        HttpSession session = httpRequest.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("userId") != null);
        
        if (isLoggedIn) {
            // Check if session has been active too long (optional security measure)
            long creationTime = session.getCreationTime();
            long maxSessionTime = 12 * 60 * 60 * 1000; // 12 hours in milliseconds
            
            if (System.currentTimeMillis() - creationTime > maxSessionTime) {
                // Session has been active too long, invalidate and redirect to login
                logger.info("Session exceeded max lifetime, invalidating: " + session.getId());
                session.invalidate();
                httpResponse.sendRedirect(contextPath + "/login.jsp?error=session_expired");
                return;
            }
            
            // Update last accessed time by accessing the session
            session.getLastAccessedTime();
            
            // Add user information to request attributes for easier access in JSP
            httpRequest.setAttribute("currentUser", session.getAttribute("name"));
            httpRequest.setAttribute("userRole", session.getAttribute("role"));
            
            // User is logged in, proceed
            chain.doFilter(request, response);
        } else {
            // Check if we have cookies to attempt auto-login
            Cookie[] cookies = httpRequest.getCookies();
            String authToken = CookieUtil.getCookieValue(cookies, "authToken");
            String encodedEmail = CookieUtil.getCookieValue(cookies, "userEmail");
            String encodedUserId = CookieUtil.getCookieValue(cookies, "userId");
            
            if (authToken != null && encodedEmail != null && encodedUserId != null) {
                try {
                    // Decode URL-encoded values
                    String userEmail = URLDecoder.decode(encodedEmail, StandardCharsets.UTF_8.toString());
                    String userId = URLDecoder.decode(encodedUserId, StandardCharsets.UTF_8.toString());
                    
                    // Try to auto-login using cookie data
                    if (userDAO == null) {
                        userDAO = new UserDAO();
                    }
                    
                    User user = userDAO.getUserByEmail(userEmail);
                    if (user != null && String.valueOf(user.getUserId()).equals(userId)) {
                        // Redirect to login which will auto-authenticate with these cookies
                        logger.info("Auto-login attempt for user: " + userEmail);
                        httpResponse.sendRedirect(contextPath + "/login");
                        return;
                    }
                } catch (SQLException e) {
                    logger.warning("Error during cookie-based auth: " + e.getMessage());
                    // Continue to standard auth failure
                } catch (IllegalArgumentException e) {
                    logger.warning("Error decoding cookie values: " + e.getMessage());
                    // Continue to standard auth failure
                }
            }
            
            // No valid session or cookies, redirect to login
            logger.info("Unauthorized access attempt to: " + requestURI);
            httpResponse.sendRedirect(contextPath + "/login.jsp");
        }
    }

    @Override
    public void destroy() {
        logger.info("AuthFilter destroyed");
    }
    
    /**
     * Check if the requested resource is public (doesn't require authentication)
     * 
     * @param path The request path to check
     * @return true if public, false if authentication required
     */
    private boolean isPublicResource(String path) {
        // Check if path starts with any public path
        for (String publicPath : PUBLIC_PATHS) {
            if (path.startsWith(publicPath)) {
                return true;
            }
        }
        
        // Check file extensions
        for (String extension : PUBLIC_EXTENSIONS) {
            if (path.endsWith(extension)) {
                return true;
            }
        }
        
        return false;
    }
} 