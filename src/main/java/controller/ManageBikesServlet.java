package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import modal.Bike;
import dao.BikeDAO;
import modal.User;

import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/ManageBikesServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 5,   // 5 MB
    maxFileSize = 1024 * 1024 * 50,        // 50 MB
    maxRequestSize = 1024 * 1024 * 100     // 100 MB
)
public class ManageBikesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BikeDAO bikeDAO;
    
    // Size constants
    private static final long MAX_IMAGE_SIZE = 1024 * 1024 * 50; // 50MB
    
    public ManageBikesServlet() {
        super();
        bikeDAO = new BikeDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Check if user is logged in and is an admin
        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            System.out.println("User not logged in or not admin. User: " + (user != null ? user.getEmail() : "null"));
            response.sendRedirect("admin/adminLogin.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        System.out.println("Action received: " + action); // Debug log
        
        try {
            if ("getBike".equals(action)) {
                // Get bike details for JSON response
                String bikeIdParam = request.getParameter("bikeId");
                System.out.println("Received bikeId parameter: " + bikeIdParam);
                
                if (bikeIdParam == null || bikeIdParam.trim().isEmpty()) {
                    System.out.println("Error: bikeId parameter is null or empty");
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("{\"error\":\"Bike ID is required\"}");
                    return;
                }
                
                int bikeId = Integer.parseInt(bikeIdParam);
                System.out.println("Fetching bike with ID: " + bikeId); // Debug log
                
                try {
                    Bike bike = bikeDAO.getBikeById(bikeId);
                    System.out.println("Bike found: " + (bike != null)); // Debug log
                    
                    if (bike != null) {
                        // Convert bike object to JSON
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");
                        
                        try {
                            // Create JSON string manually
                            String jsonResponse = String.format(
                                "{\"bikeId\":%d,\"brandName\":\"%s\",\"modelName\":\"%s\",\"type\":\"%s\"," +
                                "\"price\":%.2f,\"engineCapacity\":\"%s\",\"fuelType\":\"%s\",\"transmission\":\"%s\"," +
                                "\"mileage\":\"%s\",\"power\":\"%s\",\"torque\":\"%s\",\"coolingSystem\":\"%s\"," +
                                "\"brakeType\":\"%s\",\"suspensionType\":\"%s\",\"kerbWeight\":\"%s\",\"seatHeight\":\"%s\"," +
                                "\"fuelTankCapacity\":\"%s\",\"topSpeed\":\"%s\",\"warrantyInfo\":\"%s\"," +
                                "\"stockQuantity\":%d,\"description\":\"%s\",\"color\":\"%s\"}",
                                bike.getBikeId(),
                                escapeJson(bike.getBrandName()),
                                escapeJson(bike.getModelName()),
                                escapeJson(bike.getType()),
                                bike.getPrice(),
                                escapeJson(bike.getEngineCapacity()),
                                escapeJson(bike.getFuelType()),
                                escapeJson(bike.getTransmission()),
                                escapeJson(bike.getMileage()),
                                escapeJson(bike.getPower()),
                                escapeJson(bike.getTorque()),
                                escapeJson(bike.getCoolingSystem()),
                                escapeJson(bike.getBrakeType()),
                                escapeJson(bike.getSuspensionType()),
                                escapeJson(bike.getKerbWeight()),
                                escapeJson(bike.getSeatHeight()),
                                escapeJson(bike.getFuelTankCapacity()),
                                escapeJson(bike.getTopSpeed()),
                                escapeJson(bike.getWarrantyInfo()),
                                bike.getStockQuantity(),
                                escapeJson(bike.getDescription()),
                                escapeJson(bike.getColor())
                            );
                            
                            System.out.println("JSON Response: " + jsonResponse); // Debug log
                            response.getWriter().write(jsonResponse);
                        } catch (Exception e) {
                            System.out.println("Error creating JSON response: " + e.getMessage()); // Debug log
                            e.printStackTrace();
                            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                            response.getWriter().write("{\"error\":\"Error creating JSON response: " + e.getMessage() + "\"}");
                        }
                    } else {
                        System.out.println("Bike not found with ID: " + bikeId); // Debug log
                        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                        response.getWriter().write("{\"error\":\"Bike not found with ID: " + bikeId + "\"}");
                    }
                } catch (SQLException e) {
                    System.out.println("SQL Exception while fetching bike: " + e.getMessage()); // Debug log
                    e.printStackTrace();
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("{\"error\":\"Database error: " + e.getMessage() + "\"}");
                } catch (Exception e) {
                    System.out.println("Unexpected error while fetching bike: " + e.getMessage()); // Debug log
                    e.printStackTrace();
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("{\"error\":\"Unexpected error: " + e.getMessage() + "\"}");
                }
            } else if ("editBike".equals(action)) {
                // Get bike details for editing
                int bikeId = Integer.parseInt(request.getParameter("bikeId"));
                Bike bike = bikeDAO.getBikeById(bikeId);
                
                if (bike != null) {
                    request.setAttribute("bike", bike);
                    request.getRequestDispatcher("admin/edit-bike.jsp").forward(request, response);
                } else {
                    response.sendRedirect("admin/manage-bikes.jsp?message=bikeNotFound");
                }
            } else if ("deleteBike".equals(action)) {
                // Delete bike
                int bikeId = Integer.parseInt(request.getParameter("bikeId"));
                boolean success = bikeDAO.deleteBike(bikeId);
                
                if (success) {
                    response.sendRedirect("admin/manage-bikes.jsp?message=deleteSuccess");
                } else {
                    response.sendRedirect("admin/manage-bikes.jsp?message=deleteFailed");
                }
            } else if ("searchBikes".equals(action)) {
                // Search bikes
                String searchQuery = request.getParameter("searchQuery");
                String type = request.getParameter("type");
                
                List<Bike> bikes;
                if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                    // If there's a search query, use it to search across all fields
                    bikes = bikeDAO.searchBikes(searchQuery);
                    
                    // If type is also specified, filter the results
                    if (type != null && !type.trim().isEmpty()) {
                        bikes.removeIf(bike -> !type.equals(bike.getType()));
                    }
                } else if (type != null && !type.trim().isEmpty()) {
                    // If only type is specified, get bikes by type
                    bikes = bikeDAO.getBikesByType(type);
                } else {
                    // If no search criteria, get all bikes
                    bikes = bikeDAO.getAllBikes();
                }
                
                request.setAttribute("bikes", bikes);
                request.getRequestDispatcher("admin/manage-bikes.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            System.out.println("SQL Exception: " + e.getMessage()); // Debug log
            e.printStackTrace();
            response.sendRedirect("admin/manage-bikes.jsp?message=error");
        } catch (NumberFormatException e) {
            System.out.println("Number Format Exception: " + e.getMessage()); // Debug log
            e.printStackTrace();
            response.sendRedirect("admin/manage-bikes.jsp?message=invalidId");
        } catch (Exception e) {
            System.out.println("Unexpected Exception: " + e.getMessage()); // Debug log
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Unexpected error occurred\"}");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Check if user is logged in and is an admin
        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect("admin/adminLogin.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("updateBike".equals(action)) {
            try {
                int bikeId = Integer.parseInt(request.getParameter("bikeId"));
                Bike bike = bikeDAO.getBikeById(bikeId);
                
                if (bike != null) {
                    // Update basic bike info
                    bike.setBrandName(request.getParameter("brandName"));
                    bike.setModelName(request.getParameter("modelName"));
                    bike.setType(request.getParameter("type"));
                    bike.setPrice(Double.parseDouble(request.getParameter("price")));
                    
                    // Update performance specs
                    bike.setEngineCapacity(request.getParameter("engineCapacity"));
                    bike.setFuelType(request.getParameter("fuelType"));
                    bike.setTransmission(request.getParameter("transmission"));
                    bike.setMileage(request.getParameter("mileage"));
                    bike.setPower(request.getParameter("power"));
                    bike.setTorque(request.getParameter("torque"));
                    bike.setCoolingSystem(request.getParameter("coolingSystem"));
                    
                    // Update hardware & dimensions
                    bike.setBrakeType(request.getParameter("brakeType"));
                    bike.setSuspensionType(request.getParameter("suspensionType"));
                    bike.setKerbWeight(request.getParameter("kerbWeight"));
                    bike.setSeatHeight(request.getParameter("seatHeight"));
                    bike.setFuelTankCapacity(request.getParameter("fuelTankCapacity"));
                    bike.setTopSpeed(request.getParameter("topSpeed"));
                    
                    // Update other details
                    bike.setWarrantyInfo(request.getParameter("warrantyInfo"));
                    bike.setStockQuantity(Integer.parseInt(request.getParameter("stockQuantity")));
                    bike.setDescription(request.getParameter("description"));
                    bike.setColor(request.getParameter("color"));
                    
                    // Handle image upload
                    Part filePart = request.getPart("bikeImage");
                    if (filePart != null && filePart.getSize() > 0) {
                        if (filePart.getSize() > MAX_IMAGE_SIZE) {
                            response.sendRedirect("admin/edit-bike.jsp?bikeId=" + bikeId + "&message=imageTooLarge");
                            return;
                        }
                        
                        InputStream inputStream = filePart.getInputStream();
                        byte[] imageBytes = inputStream.readAllBytes();
                        bike.setBikeImage(imageBytes);
                    }
                    
                    boolean success = bikeDAO.updateBike(bike);
                    
                    if (success) {
                        response.sendRedirect("admin/manage-bikes.jsp?message=updateSuccess");
                    } else {
                        response.sendRedirect("admin/edit-bike.jsp?bikeId=" + bikeId + "&message=updateFailed");
                    }
                } else {
                    response.sendRedirect("admin/manage-bikes.jsp?message=bikeNotFound");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("admin/manage-bikes.jsp?message=updateFailed");
            }
        }
    }

    // Helper method to escape JSON strings
    private String escapeJson(String input) {
        if (input == null) return "";
        return input.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\t", "\\t");
    }
} 