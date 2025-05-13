package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;

import util.DatabaseUtil;
import modal.Bike;

/**
 * Servlet implementation class BikeDetails
 */
@WebServlet("/bike-details")
public class BikeDetails extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BikeDetails() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
            int bikeId = Integer.parseInt(request.getParameter("id"));
            Bike bike = getBikeDetails(bikeId, request);
            
            if (bike != null) {
                request.setAttribute("bike", bike);
                request.getRequestDispatcher("/user/bike-details.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/bikes");
            }
        } catch (NumberFormatException e) {
            // Invalid bike ID format
            response.sendRedirect(request.getContextPath() + "/bikes");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp");
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	/**
     * Fetch bike details from the database
     */
    private Bike getBikeDetails(int bikeId, HttpServletRequest request) throws SQLException {
        Bike bike = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseUtil.getConnection();
            
            String sql = "SELECT * FROM bike WHERE BikeID = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, bikeId);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                bike = new Bike();
                bike.setBikeId(rs.getInt("BikeID"));
                bike.setBrandName(rs.getString("Brand_Name"));
                bike.setModelName(rs.getString("Model_Name"));
                bike.setType(rs.getString("Type"));
                bike.setPrice(rs.getDouble("Price"));
                bike.setEngineCapacity(rs.getString("Engine_Capacity"));
                bike.setFuelType(rs.getString("Fuel_Type"));
                bike.setTransmission(rs.getString("Transmission"));
                bike.setMileage(rs.getString("Mileage"));
                bike.setPower(rs.getString("Power"));
                bike.setTorque(rs.getString("Torque"));
                bike.setCoolingSystem(rs.getString("Cooling_System"));
                bike.setBrakeType(rs.getString("Brake_Type"));
                bike.setSuspensionType(rs.getString("Suspension_Type"));
                bike.setKerbWeight(rs.getString("Kerb_Weight"));
                bike.setSeatHeight(rs.getString("Seat_Height"));
                bike.setFuelTankCapacity(rs.getString("Fuel_Tank_Capacity"));
                bike.setTopSpeed(rs.getString("Top_Speed"));
                bike.setWarrantyInfo(rs.getString("Warranty_Info"));
                bike.setStockQuantity(rs.getInt("Stock_Quantity"));
                bike.setDescription(rs.getString("Description"));
                bike.setColor(rs.getString("Color"));
                
                // Handle image
                byte[] imageData = rs.getBytes("Bike_Image");
                if (imageData != null) {
                    request.setAttribute("bikeImage", Base64.getEncoder().encodeToString(imageData));
                }
            }
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
        
        return bike;
    }
}
