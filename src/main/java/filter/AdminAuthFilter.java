package filter;

import java.io.IOException;
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
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Authentication filter to protect admin resources
 */
@WebFilter(urlPatterns = {
    "/admin/*",           // All admin pages
    "/add-bike",         // Add bike functionality
    "/manage-bikes",     // Manage bikes functionality
    "/inventory",        // Inventory management
    "/messages",         // Admin messages
    "/orders",           // Order management
    "/sales"            // Sales history
})
public class AdminAuthFilter implements Filter {
    private static final Logger logger = Logger.getLogger(AdminAuthFilter.class.getName());
    
    // Public resources that don't require authentication
    private static final Set<String> PUBLIC_PATHS = new HashSet<>(
        Arrays.asList("/admin/adminLogin.jsp", "/AdminLoginServlet", "/assets/", "/js/", "/css/", "/images/")
    );
    
    // File extensions that should be accessible without authentication
    private static final Set<String> PUBLIC_EXTENSIONS = new HashSet<>(
        Arrays.asList(".css", ".js", ".png", ".jpg", ".jpeg", ".gif", ".svg", ".ico", ".woff", ".woff2", ".ttf")
    );

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        logger.info("AdminAuthFilter initialized");
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
        boolean isAdminLoggedIn = (session != null && 
                                 session.getAttribute("adminLoggedIn") != null && 
                                 (Boolean)session.getAttribute("adminLoggedIn"));
        
        if (isAdminLoggedIn) {
            // Check if session has been active too long (optional security measure)
            long creationTime = session.getCreationTime();
            long maxSessionTime = 12 * 60 * 60 * 1000; // 12 hours in milliseconds
            
            if (System.currentTimeMillis() - creationTime > maxSessionTime) {
                // Session has been active too long, invalidate and redirect to login
                logger.info("Admin session exceeded max lifetime, invalidating: " + session.getId());
                session.invalidate();
                httpResponse.sendRedirect(contextPath + "/admin/adminLogin.jsp?error=session_expired");
                return;
            }
            
            // Update last accessed time by accessing the session
            session.getLastAccessedTime();
            
            // Admin is logged in, proceed
            chain.doFilter(request, response);
        } else {
            // No valid admin session, redirect to admin login
            logger.info("Unauthorized admin access attempt to: " + requestURI);
            httpResponse.sendRedirect(contextPath + "/admin/adminLogin.jsp");
        }
    }

    @Override
    public void destroy() {
        logger.info("AdminAuthFilter destroyed");
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