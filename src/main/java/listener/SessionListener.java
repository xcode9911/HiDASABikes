package listener;

import java.util.concurrent.ConcurrentHashMap;
import java.util.logging.Logger;

import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

/**
 * Application Lifecycle Listener implementation class SessionListener
 */
@WebListener
public class SessionListener implements HttpSessionListener {
    private static final Logger logger = Logger.getLogger(SessionListener.class.getName());
    
    // Concurrent map to track active sessions
    private static final ConcurrentHashMap<String, HttpSession> activeSessions = new ConcurrentHashMap<>();
    
    /**
     * Default constructor
     */
    public SessionListener() {
        // Default constructor
    }

    /**
     * @see HttpSessionListener#sessionCreated(HttpSessionEvent)
     */
    public void sessionCreated(HttpSessionEvent se) {
        HttpSession session = se.getSession();
        String sessionId = session.getId();
        
        // Add the session to active sessions map
        activeSessions.put(sessionId, session);
        
        logger.info("Session created: " + sessionId);
        logger.info("Total active sessions: " + activeSessions.size());
    }

    /**
     * @see HttpSessionListener#sessionDestroyed(HttpSessionEvent)
     */
    public void sessionDestroyed(HttpSessionEvent se) {
        HttpSession session = se.getSession();
        String sessionId = session.getId();
        
        // Log user logout/session timeout
        String userId = (String) session.getAttribute("userId");
        if (userId != null) {
            logger.info("User " + userId + " session ended: " + sessionId);
        }
        
        // Remove from active sessions
        activeSessions.remove(sessionId);
        
        logger.info("Session destroyed: " + sessionId);
        logger.info("Remaining active sessions: " + activeSessions.size());
    }
    
    /**
     * Get all active sessions
     * 
     * @return Map of active sessions by session ID
     */
    public static ConcurrentHashMap<String, HttpSession> getActiveSessions() {
        return activeSessions;
    }
    
    /**
     * Get count of active sessions
     * 
     * @return Number of active sessions
     */
    public static int getActiveSessionCount() {
        return activeSessions.size();
    }
    
    /**
     * Invalidate a specific session
     * 
     * @param sessionId Session ID to invalidate
     * @return true if session was found and invalidated, false otherwise
     */
    public static boolean invalidateSession(String sessionId) {
        HttpSession session = activeSessions.get(sessionId);
        if (session != null) {
            try {
                session.invalidate();
                return true;
            } catch (IllegalStateException e) {
                // Session already invalidated
                activeSessions.remove(sessionId);
            }
        }
        return false;
    }
    
    /**
     * Invalidate all sessions for a specific user
     * 
     * @param userId User ID to invalidate sessions for
     * @return Number of sessions invalidated
     */
    public static int invalidateUserSessions(String userId) {
        int count = 0;
        
        for (HttpSession session : activeSessions.values()) {
            try {
                String sessionUserId = (String) session.getAttribute("userId");
                if (userId.equals(sessionUserId)) {
                    session.invalidate();
                    count++;
                }
            } catch (IllegalStateException e) {
                // Session already invalidated, continue to next
            }
        }
        
        return count;
    }
} 