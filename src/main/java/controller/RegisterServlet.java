package controller;

import java.io.IOException;

import java.io.InputStream;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import modal.User;
import modal.Address;
import dao.UserDAO;
import dao.AddressDAO;
import util.DatabaseUtil;
import util.PasswordUtil;

@WebServlet("/register")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1 MB threshold
    maxFileSize = 1024 * 1024 * 10,       // 10 MB max file size
    maxRequestSize = 1024 * 1024 * 50     // 50 MB max request size
)
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    private AddressDAO addressDAO;

    @Override
    public void init() throws ServletException {
        // Initialize DAOs lazily when needed, not in init method
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to registration page
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Initialize DAOs only when needed
            if (userDAO == null) {
                userDAO = new UserDAO();
            }
            if (addressDAO == null) {
                addressDAO = new AddressDAO();
            }
            
            // Get user form data
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");

            // Address information
            String street = request.getParameter("street");
            String city = request.getParameter("city");
            String state = request.getParameter("state");
            String zipCode = request.getParameter("zipCode");
            String country = request.getParameter("country");

            // Validate required fields
            if (name == null || name.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                confirmPassword == null || confirmPassword.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/index.jsp?error=missing_fields");
                return;
            }

            // Validate email format
            if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
                response.sendRedirect(request.getContextPath() + "/index.jsp?error=invalid_email");
                return;
            }

            // Validate password length and complexity
            if (password.length() < 8) {
                response.sendRedirect(request.getContextPath() + "/index.jsp?error=password_too_short");
                return;
            }

            // Validate password match
            if (!password.equals(confirmPassword)) {
                response.sendRedirect(request.getContextPath() + "/index.jsp?error=password_mismatch");
                return;
            }

            // Check if email exists
            User existingUser = userDAO.getUserByEmail(email);
            if (existingUser != null) {
                response.sendRedirect(request.getContextPath() + "/index.jsp?error=email_exists");
                return;
            }

            // Handle profile image (now supporting up to 10MB)
            Part profileImagePart = request.getPart("profileImage");
            byte[] profileImage = null;
            if (profileImagePart != null && profileImagePart.getSize() > 0) {
                // Debug output
                System.out.println("Image size: " + profileImagePart.getSize() + " bytes");
                System.out.println("Content type: " + profileImagePart.getContentType());
                
                // Validate image size (max 10MB)
                if (profileImagePart.getSize() > 10 * 1024 * 1024) {
                    response.sendRedirect(request.getContextPath() + "/index.jsp?error=image_too_large");
                    return;
                }
                // Validate image type
                String contentType = profileImagePart.getContentType();
                if (!contentType.startsWith("image/")) {
                    response.sendRedirect(request.getContextPath() + "/index.jsp?error=invalid_image_type");
                    return;
                }
                try (InputStream inputStream = profileImagePart.getInputStream()) {
                    profileImage = inputStream.readAllBytes();
                    System.out.println("Profile image read: " + profileImage.length + " bytes");
                }
            }

            // Create User object
            User user = new User();
            user.setName(name.trim());
            user.setEmail(email.trim().toLowerCase());
            user.setPhone(phone);
            user.setPassword(PasswordUtil.hashPassword(password)); // Hash the password before storing
            user.setProfileImage(profileImage);
            user.setRole("customer"); // Default role for new registrations

            // Create Address object
            Address address = new Address();
            address.setStreet(street);
            address.setCity(city);
            address.setState(state);
            address.setZipCode(zipCode);
            address.setCountry(country);

            // Transaction to create user and address
            int userId = 0;
            int addressId = 0;
            
            // Create user using UserDAO
            userId = userDAO.createUser(user);
            System.out.println("Created user with ID: " + userId);
            
            if (userId > 0) {
                // Create address using AddressDAO
                addressId = addressDAO.createAddress(address);
                System.out.println("Created address with ID: " + addressId);
                
                if (addressId > 0) {
                    // Link user and address in the user_address table
                    boolean linkSuccess = userDAO.addAddressToUser(userId, addressId);
                    
                    if (linkSuccess) {
                        // Registration successful - redirect to login page
                        response.sendRedirect(request.getContextPath() + "/login.jsp?success=registered");
                    } else {
                        // Failed to link user and address, but both were created
                        response.sendRedirect(request.getContextPath() + "/login.jsp?success=registered&warning=address_link_failed");
                    }
                } else {
                    // Address creation failed but user was created
                    response.sendRedirect(request.getContextPath() + "/login.jsp?success=registered&warning=address_failed");
                }
            } else {
                // Registration failed
                response.sendRedirect(request.getContextPath() + "/index.jsp?error=registration_failed");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/index.jsp?error=database");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/index.jsp?error=unexpected&message=" + e.getMessage());
        }
    }

    @Override
    public void destroy() {
        // No special cleanup needed as connections are closed after each DAO operation
    }
}