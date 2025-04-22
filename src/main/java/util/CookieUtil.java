package util;

import jakarta.servlet.http.Cookie;

/**
 * Utility class for working with cookies
 */
public class CookieUtil {
    
    /**
     * Finds a cookie by name and returns its value
     * 
     * @param cookies Array of cookies from request
     * @param name Name of the cookie to find
     * @return Value of the cookie, or null if not found
     */
    public static String getCookieValue(Cookie[] cookies, String name) {
        if (cookies == null) {
            return null;
        }
        
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals(name)) {
                return cookie.getValue();
            }
        }
        
        return null;
    }
    
    /**
     * Creates a new cookie with the specified properties
     * 
     * @param name Name of the cookie
     * @param value Value to store in the cookie
     * @param maxAge Max age in seconds, -1 for session cookie
     * @param path Cookie path, use "/" for entire site
     * @param isHttpOnly Whether cookie should be HTTP only (not accessible via JavaScript)
     * @return The created cookie
     */
    public static Cookie createCookie(String name, String value, int maxAge, String path, boolean isHttpOnly) {
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(maxAge);
        cookie.setPath(path);
        cookie.setHttpOnly(isHttpOnly);
        return cookie;
    }
    
    /**
     * Deletes a cookie by setting its max age to 0
     * 
     * @param name Name of the cookie to delete
     * @param path Cookie path
     * @return Cookie with expiry set to 0
     */
    public static Cookie deleteCookie(String name, String path) {
        Cookie cookie = new Cookie(name, "");
        cookie.setMaxAge(0);
        cookie.setPath(path);
        return cookie;
    }
} 