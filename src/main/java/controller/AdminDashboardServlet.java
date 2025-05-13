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

/**
 * Servlet implementation class AdminDashboardServlet
 */
@WebServlet("/AdminDashboardServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 5,   // 5 MB
    maxFileSize = 1024 * 1024 * 50,        // 50 MB
    maxRequestSize = 1024 * 1024 * 100     // 100 MB
)
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BikeDAO bikeDAO;
    
    // Size constants
    private static final long MAX_IMAGE_SIZE = 1024 * 1024 * 50; // 50MB
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminDashboardServlet() {
        super();
        bikeDAO = new BikeDAO();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Check if user is logged in and is an admin
        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect("AdminLoginServlet");
            return;
        }
        
        String action = request.getParameter("action");
        
        try {
            if (action == null) {
                // Default action - show admin dashboard
                List<Bike> recentBikes = bikeDAO.getRecentBikes();
                List<Bike> lowStockBikes = bikeDAO.getLowStockBikes();
                
                request.setAttribute("recentBikes", recentBikes);
                request.setAttribute("lowStockBikes", lowStockBikes);
                request.getRequestDispatcher("user/adminDashboard.jsp").forward(request, response);
            } else if ("viewBikes".equals(action)) {
                // View all bikes
                List<Bike> allBikes = bikeDAO.getAllBikes();
                request.setAttribute("bikes", allBikes);
                request.getRequestDispatcher("view/adminBikes.jsp").forward(request, response);
            } else if ("editBike".equals(action)) {
                // Edit a specific bike
                int bikeId = Integer.parseInt(request.getParameter("bikeId"));
                Bike bike = bikeDAO.getBikeById(bikeId);
                request.setAttribute("bike", bike);
                request.getRequestDispatcher("view/editBike.jsp").forward(request, response);
            } else if ("deleteBike".equals(action)) {
                // Delete a bike
                int bikeId = Integer.parseInt(request.getParameter("bikeId"));
                boolean success = bikeDAO.deleteBike(bikeId);
                
                if (success) {
                    response.sendRedirect("AdminDashboardServlet?action=viewBikes&message=deleteSuccess");
                } else {
                    response.sendRedirect("AdminDashboardServlet?action=viewBikes&message=deleteFailed");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("AdminDashboardServlet?message=invalidId");
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Check if user is logged in and is an admin
        if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect("AdminLoginServlet");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("addBike".equals(action)) {
            // Add a new bike
            try {
                Bike bike = new Bike();
                
                // Set basic bike info
                bike.setBrandName(request.getParameter("brandName"));
                bike.setModelName(request.getParameter("modelName"));
                bike.setType(request.getParameter("type"));
                bike.setPrice(Double.parseDouble(request.getParameter("price")));
                
                // Set performance specs
                bike.setEngineCapacity(request.getParameter("engineCapacity"));
                bike.setFuelType(request.getParameter("fuelType"));
                bike.setTransmission(request.getParameter("transmission"));
                bike.setMileage(request.getParameter("mileage"));
                bike.setPower(request.getParameter("power"));
                bike.setTorque(request.getParameter("torque"));
                bike.setCoolingSystem(request.getParameter("coolingSystem"));
                
                // Set hardware & dimensions
                bike.setBrakeType(request.getParameter("brakeType"));
                bike.setSuspensionType(request.getParameter("suspensionType"));
                bike.setKerbWeight(request.getParameter("kerbWeight"));
                bike.setSeatHeight(request.getParameter("seatHeight"));
                bike.setFuelTankCapacity(request.getParameter("fuelTankCapacity"));
                bike.setTopSpeed(request.getParameter("topSpeed"));
                
                // Set other details
                bike.setWarrantyInfo(request.getParameter("warrantyInfo"));
                bike.setStockQuantity(Integer.parseInt(request.getParameter("stockQuantity")));
                bike.setDescription(request.getParameter("description"));
                bike.setColor(request.getParameter("color"));
                
                // Handle image upload
                Part filePart = request.getPart("bikeImage");
                if (filePart != null && filePart.getSize() > 0) {
                    // Check file size to prevent data truncation
                    if (filePart.getSize() > MAX_IMAGE_SIZE) { // 50MB limit
                        response.sendRedirect("user/addBike.jsp?message=imageTooLarge");
                        return;
                    }
                    
                    InputStream inputStream = filePart.getInputStream();
                    byte[] imageBytes = inputStream.readAllBytes();
                    bike.setBikeImage(imageBytes);
                }
                
                boolean success = bikeDAO.addBike(bike);
                
                if (success) {
                    response.sendRedirect("user/addBike.jsp?message=addSuccess");
                } else {
                    response.sendRedirect("user/addBike.jsp?message=addFailed");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("user/addBike.jsp?message=addFailed");
            }
        } else if ("updateBike".equals(action)) {
            // Update an existing bike
            try {
                int bikeId = Integer.parseInt(request.getParameter("bikeId"));
                Bike bike = bikeDAO.getBikeById(bikeId);
                
                if (bike != null) {
                    // Set basic bike info
                    bike.setBrandName(request.getParameter("brandName"));
                    bike.setModelName(request.getParameter("modelName"));
                    bike.setType(request.getParameter("type"));
                    bike.setPrice(Double.parseDouble(request.getParameter("price")));
                    
                    // Set performance specs
                    bike.setEngineCapacity(request.getParameter("engineCapacity"));
                    bike.setFuelType(request.getParameter("fuelType"));
                    bike.setTransmission(request.getParameter("transmission"));
                    bike.setMileage(request.getParameter("mileage"));
                    bike.setPower(request.getParameter("power"));
                    bike.setTorque(request.getParameter("torque"));
                    bike.setCoolingSystem(request.getParameter("coolingSystem"));
                    
                    // Set hardware & dimensions
                    bike.setBrakeType(request.getParameter("brakeType"));
                    bike.setSuspensionType(request.getParameter("suspensionType"));
                    bike.setKerbWeight(request.getParameter("kerbWeight"));
                    bike.setSeatHeight(request.getParameter("seatHeight"));
                    bike.setFuelTankCapacity(request.getParameter("fuelTankCapacity"));
                    bike.setTopSpeed(request.getParameter("topSpeed"));
                    
                    // Set other details
                    bike.setWarrantyInfo(request.getParameter("warrantyInfo"));
                    bike.setStockQuantity(Integer.parseInt(request.getParameter("stockQuantity")));
                    bike.setDescription(request.getParameter("description"));
                    bike.setColor(request.getParameter("color"));
                    
                    // Handle image upload
                    Part filePart = request.getPart("bikeImage");
                    if (filePart != null && filePart.getSize() > 0) {
                        InputStream inputStream = filePart.getInputStream();
                        byte[] imageBytes = inputStream.readAllBytes();
                        bike.setBikeImage(imageBytes);
                    }
                    
                    boolean success = bikeDAO.updateBike(bike);
                    
                    if (success) {
                        response.sendRedirect("AdminDashboardServlet?action=viewBikes&message=updateSuccess");
                    } else {
                        response.sendRedirect("AdminDashboardServlet?action=editBike&bikeId=" + bikeId + "&message=updateFailed");
                    }
                } else {
                    response.sendRedirect("AdminDashboardServlet?action=viewBikes&message=bikeNotFound");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("AdminDashboardServlet?action=viewBikes&message=updateFailed");
            }
        }
    }
} 