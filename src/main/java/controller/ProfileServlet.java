package controller;

import java.io.IOException;


import java.sql.SQLException;
import java.util.Base64;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import modal.User;
import modal.Address;
import dao.UserDAO;
import dao.AddressDAO;
import util.CookieUtil;
import util.PasswordUtil;

@WebServlet("/profile")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class ProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    private AddressDAO addressDAO;
       
    public ProfileServlet() {
        super();
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        int userId = -1;
        
        // Try to get user ID from session first
        if (session != null && session.getAttribute("userId") != null) {
            userId = (int) session.getAttribute("userId");
        } 
        // If not in session, try to get from cookies
        else {
            Cookie[] cookies = request.getCookies();
            String userIdFromCookie = CookieUtil.getCookieValue(cookies, "userId");
            
            if (userIdFromCookie != null && !userIdFromCookie.isEmpty()) {
                try {
                    userId = Integer.parseInt(userIdFromCookie);
                    
                    // Create or get session to store the data
                    session = request.getSession(true);
                    
                    // We don't know other user data yet, we'll fetch it from the database
                } catch (NumberFormatException e) {
                    // Invalid userId in cookie
                    response.sendRedirect(request.getContextPath() + "/login?error=invalid_cookie");
                    return;
                }
            } else {
                // No user data in cookies either
                response.sendRedirect(request.getContextPath() + "/login?error=not_logged_in");
                return;
            }
        }
        
        // At this point, we should have a valid userId
        if (userId <= 0) {
            response.sendRedirect(request.getContextPath() + "/login?error=invalid_user");
			return;
		}
		
        try {
            // Initialize DAOs only when needed
            if (userDAO == null) {
                userDAO = new UserDAO();
            }
            
            if (addressDAO == null) {
                addressDAO = new AddressDAO();
            }
            
            // Get complete user details
            User user = userDAO.getUserById(userId);
            
            if (user != null) {
                // If we got user data from cookies but not session, populate session
                if (session.getAttribute("name") == null) {
                    session.setAttribute("userId", user.getUserId());
                    session.setAttribute("name", user.getName());
                    session.setAttribute("email", user.getEmail());
                    session.setAttribute("phone", user.getPhone());
                    session.setAttribute("role", user.getRole());
                    
                    if (user.getProfileImage() != null) {
                        String base64Image = Base64.getEncoder().encodeToString(user.getProfileImage());
                        session.setAttribute("Profile_Image", base64Image);
                    }
                }
                
                // Set user data as request attributes for displaying in profile.jsp
                request.setAttribute("user", user);
                
                // Convert profile image to base64 if it exists
                if (user.getProfileImage() != null) {
                    String base64Image = Base64.getEncoder().encodeToString(user.getProfileImage());
                    request.setAttribute("profileImage", base64Image);
                }
                
                // Get user's addresses
                List<Integer> addressIds = userDAO.getUserAddressIds(userId);
                if (!addressIds.isEmpty()) {
                    // Get the first address (assuming primary address)
                    Address address = addressDAO.getAddressById(addressIds.get(0));
                    if (address != null) {
                        request.setAttribute("address", address);
                    }
                }
                
                // Forward to profile page
                request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
            } else {
                // User not found (should not happen but handle anyway)
                response.sendRedirect(request.getContextPath() + "/login?error=invalid_session");
            }
            
		} catch (SQLException e) {
			e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/home?error=database");
		}
	}

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        int userId = -1;
        
        // Try to get user ID from session first
        if (session != null && session.getAttribute("userId") != null) {
            userId = (int) session.getAttribute("userId");
        } 
        // If not in session, try to get from cookies
        else {
            Cookie[] cookies = request.getCookies();
            String userIdFromCookie = CookieUtil.getCookieValue(cookies, "userId");
            
            if (userIdFromCookie != null && !userIdFromCookie.isEmpty()) {
                try {
                    userId = Integer.parseInt(userIdFromCookie);
                    
                    // Create session to store updated data
                    session = request.getSession(true);
                    session.setAttribute("userId", userId);
                } catch (NumberFormatException e) {
                    // Invalid userId in cookie
                    response.sendRedirect(request.getContextPath() + "/login?error=invalid_cookie");
                    return;
                }
            } else {
                // No user data in cookies either
                response.sendRedirect(request.getContextPath() + "/login?error=not_logged_in");
                return;
            }
        }
        
        // At this point, we should have a valid userId and session
        if (userId <= 0 || session == null) {
            response.sendRedirect(request.getContextPath() + "/login?error=invalid_user");
            return;
        }
        
        String action = request.getParameter("action");
        
        try {
            // Initialize DAOs only when needed
            if (userDAO == null) {
                userDAO = new UserDAO();
            }
            
            if (addressDAO == null) {
                addressDAO = new AddressDAO();
            }
            
            // Check which action is being performed
            if ("updateProfile".equals(action)) {
                // Get form parameters
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                
                // Validate fields
                if (name == null || name.trim().isEmpty() || 
                    email == null || email.trim().isEmpty()) {
                    response.sendRedirect(request.getContextPath() + "/profile?error=missing_fields");
                    return;
                }
                
                // Get current user
                User user = userDAO.getUserById(userId);
                
                // Track what was changed
                StringBuilder changedFields = new StringBuilder();
                if (!name.equals(user.getName())) {
                    changedFields.append("name,");
                }
                if (!email.equals(user.getEmail())) {
                    changedFields.append("email,");
                }
                if ((phone == null && user.getPhone() != null) || 
                    (phone != null && !phone.equals(user.getPhone()))) {
                    changedFields.append("phone,");
                }
                
                // Update user info
                user.setName(name);
                user.setEmail(email);
                user.setPhone(phone);
                
                // Update in database
                boolean updated = userDAO.updateUser(user);
                
                // Now handle address information
                String street = request.getParameter("street");
                String city = request.getParameter("city");
                String state = request.getParameter("state");
                String zipCode = request.getParameter("zipCode");
                String country = request.getParameter("country");
                
                // Check if we have address info to update
                if (street != null && !street.trim().isEmpty()) {
                    List<Integer> addressIds = userDAO.getUserAddressIds(userId);
                    Address address;
                    boolean addressUpdated = false;
                    boolean isNewAddress = false;
                    
                    try {
                        if (!addressIds.isEmpty()) {
                            // Update existing address
                            address = addressDAO.getAddressById(addressIds.get(0));
                            if (address != null) {
                                // Track address changes
                                if (!street.equals(address.getStreet())) changedFields.append("street,");
                                if ((city == null && address.getCity() != null) || 
                                    (city != null && !city.equals(address.getCity()))) changedFields.append("city,");
                                if ((state == null && address.getState() != null) || 
                                    (state != null && !state.equals(address.getState()))) changedFields.append("state,");
                                if ((zipCode == null && address.getZipCode() != null) || 
                                    (zipCode != null && !zipCode.equals(address.getZipCode()))) changedFields.append("zipCode,");
                                if ((country == null && address.getCountry() != null) || 
                                    (country != null && !country.equals(address.getCountry()))) changedFields.append("country,");
                                
                                address.setStreet(street);
                                address.setCity(city);
                                address.setState(state);
                                address.setZipCode(zipCode);
                                address.setCountry(country);
                                addressUpdated = addressDAO.updateAddress(address);
                            }
                        } else {
                            // Create new address
                            isNewAddress = true;
                            changedFields.append("newAddress,");
                            
                            address = new Address();
                            address.setStreet(street);
                            address.setCity(city);
                            address.setState(state);
                            address.setZipCode(zipCode);
                            address.setCountry(country);
                            
                            int addressId = addressDAO.createAddress(address);
                            if (addressId > 0) {
                                addressUpdated = userDAO.addAddressToUser(userId, addressId);
                            }
                        }
                    } catch (SQLException ex) {
                        // Log the error but continue with the user update
                        ex.printStackTrace();
                        // Don't fail the whole update just because address failed
                        addressUpdated = true;
                    }
                    
                    // If the main user update succeeded but address failed, still show success
                    // but with a note that address might not be fully updated
                    if (updated && !addressUpdated) {
                        response.sendRedirect(request.getContextPath() + "/profile?success=profile_partial&note=address_failed");
                        return;
                    }
                    
                    // If address was newly created and it was successful
                    if (isNewAddress && addressUpdated) {
                        changedFields.append("addressAdded,");
                    }
                }
                
                if (updated) {
                    // Update session data
                    session.setAttribute("name", name);
                    session.setAttribute("email", email);
                    session.setAttribute("phone", phone);
                    
                    // Update cookies if needed
                    Cookie nameCookie = new Cookie("userName", name);
                    nameCookie.setMaxAge(30 * 24 * 60 * 60); // 30 days
                    nameCookie.setPath("/");
                    response.addCookie(nameCookie);
                    
                    Cookie emailCookie = new Cookie("userEmail", email);
                    emailCookie.setMaxAge(30 * 24 * 60 * 60);
                    emailCookie.setPath("/");
                    response.addCookie(emailCookie);
                    
                    // Redirect back to profile with success message that indicates changed fields
                    if (changedFields.length() > 0) {
                        response.sendRedirect(request.getContextPath() + "/profile?success=profile_updated&changes=" + changedFields.toString());
                    } else {
                        response.sendRedirect(request.getContextPath() + "/profile?success=profile_unchanged");
                    }
                } else {
                    response.sendRedirect(request.getContextPath() + "/profile?error=update_failed");
                }
            } 
            else if ("updatePassword".equals(action)) {
                // Get form parameters
                String currentPassword = request.getParameter("currentPassword");
                String newPassword = request.getParameter("newPassword");
                String confirmPassword = request.getParameter("confirmPassword");
                
                // Validate fields
                if (currentPassword == null || currentPassword.trim().isEmpty() ||
                    newPassword == null || newPassword.trim().isEmpty() ||
                    confirmPassword == null || confirmPassword.trim().isEmpty()) {
                    response.sendRedirect(request.getContextPath() + "/profile?error=missing_fields&tab=password");
                    return;
                }
                
                // Validate password match
                if (!newPassword.equals(confirmPassword)) {
                    response.sendRedirect(request.getContextPath() + "/profile?error=password_mismatch&tab=password");
                    return;
                }
                
                // Get current user
                User user = userDAO.getUserById(userId);
                
                // Validate current password
                if (!PasswordUtil.verifyPassword(currentPassword, user.getPassword())) {
                    response.sendRedirect(request.getContextPath() + "/profile?error=wrong_password&tab=password");
                    return;
                }
                
                // Update password
                user.setPassword(PasswordUtil.hashPassword(newPassword));
                boolean updated = userDAO.updateUser(user);
                
                if (updated) {
                    response.sendRedirect(request.getContextPath() + "/profile?success=password_updated&tab=password");
                } else {
                    response.sendRedirect(request.getContextPath() + "/profile?error=update_failed&tab=password");
                }
            }
            else if ("uploadImage".equals(action)) {
                // Handle profile image upload
                Part filePart = request.getPart("profileImage");
                
                if (filePart != null && filePart.getSize() > 0) {
                    // Read image data
                    byte[] imageData = new byte[(int) filePart.getSize()];
                    filePart.getInputStream().read(imageData);
                    
                    // Update user's profile image
                    boolean updated = userDAO.updateProfileImage(userId, imageData);
                    
                    if (updated) {
                        // Update session attribute for profile image
                        String base64Image = Base64.getEncoder().encodeToString(imageData);
                        session.setAttribute("Profile_Image", base64Image);
                        
                        response.sendRedirect(request.getContextPath() + "/profile?success=image_updated");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/profile?error=image_update_failed");
                    }
                } else {
                    response.sendRedirect(request.getContextPath() + "/profile?error=no_image_selected");
                }
            }
            else {
                // Unknown action
                response.sendRedirect(request.getContextPath() + "/profile?error=invalid_action");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/profile?error=database");
        }
    }
}
