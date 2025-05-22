package controller;

import jakarta.servlet.ServletException;



import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modal.Bike;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import util.DatabaseUtil;

/**
 * Servlet implementation class BikeServlet
 */
@WebServlet("/bikes")
public class BikeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BikeServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Get filter parameters
		String brand = request.getParameter("brand");
		String type = request.getParameter("type");
		String priceRange = request.getParameter("price");
		String sortBy = request.getParameter("sort");
		String searchQuery = request.getParameter("search");

		// Pagination parameters
		int page = 1;
		int recordsPerPage = 12;
		
		if (request.getParameter("page") != null) {
			try {
				page = Integer.parseInt(request.getParameter("page"));
				if (page < 1) page = 1;
			} catch (NumberFormatException e) {
				// If invalid page number, default to 1
				page = 1;
			}
		}

		// Get connection
		try (Connection conn = DatabaseUtil.getConnection()) {
			// First, get all available brands and types for filter dropdowns
			Set<String> brands = getAllBrands(conn);
			Set<String> types = getAllTypes(conn);
			
			request.setAttribute("brandsList", brands);
			request.setAttribute("typesList", types);
			
			// Build SQL query with filters
			StringBuilder sql = new StringBuilder("SELECT * FROM bike WHERE 1=1");
			List<Object> params = new ArrayList<>();
			
			// Apply filters
			if (brand != null && !brand.isEmpty()) {
				sql.append(" AND Brand_Name = ?");
				params.add(brand);
			}
			
			if (type != null && !type.isEmpty()) {
				sql.append(" AND Type = ?");
				params.add(type);
			}
			
			if (priceRange != null && !priceRange.isEmpty()) {
				String[] range = priceRange.split("-");
				if (range.length == 2) {
					sql.append(" AND Price BETWEEN ? AND ?");
					params.add(Double.parseDouble(range[0]));
					params.add(Double.parseDouble(range[1]));
				}
			}
			
			if (searchQuery != null && !searchQuery.isEmpty()) {
				sql.append(" AND (Model_Name LIKE ? OR Brand_Name LIKE ? OR Type LIKE ?)");
				String searchPattern = "%" + searchQuery + "%";
				params.add(searchPattern);
				params.add(searchPattern);
				params.add(searchPattern);
			}
			
			// Apply sorting
			if (sortBy != null) {
				switch (sortBy) {
					case "price_low":
						sql.append(" ORDER BY Price ASC");
						break;
					case "price_high":
						sql.append(" ORDER BY Price DESC");
						break;
					case "newest":
						sql.append(" ORDER BY BikeID DESC");
						break;
					default:
						sql.append(" ORDER BY Stock_Quantity DESC, BikeID DESC"); // Default sort by popularity (stock)
				}
			} else {
				sql.append(" ORDER BY Stock_Quantity DESC, BikeID DESC"); // Default sort
			}
			
			// Count total records for pagination
			String countSql = "SELECT COUNT(*) AS total FROM (" + sql.toString() + ") AS filtered_bikes";
			PreparedStatement countStmt = conn.prepareStatement(countSql);
			
			// Set parameters for count query
			for (int i = 0; i < params.size(); i++) {
				countStmt.setObject(i + 1, params.get(i));
			}
			
			ResultSet countRs = countStmt.executeQuery();
			int totalRecords = 0;
			if (countRs.next()) {
				totalRecords = countRs.getInt("total");
			}
			
			// Calculate total pages
			int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
			
			// Adjust page if it exceeds total pages
			if (totalPages > 0 && page > totalPages) {
				page = totalPages;
			}
			
			// Apply pagination
			sql.append(" LIMIT ? OFFSET ?");
			params.add(recordsPerPage);
			params.add((page - 1) * recordsPerPage);
			
			// Execute query with all filters and pagination
			PreparedStatement stmt = conn.prepareStatement(sql.toString());
			
			// Set parameters
			for (int i = 0; i < params.size(); i++) {
				stmt.setObject(i + 1, params.get(i));
			}
			
			ResultSet rs = stmt.executeQuery();
			
			// Process results
			List<Bike> bikes = new ArrayList<>();
			while (rs.next()) {
				Bike bike = new Bike();
				bike.setBikeId(rs.getInt("BikeID"));
				bike.setBrandName(rs.getString("Brand_Name"));
				bike.setModelName(rs.getString("Model_Name"));
				bike.setType(rs.getString("Type"));
				bike.setPrice(rs.getDouble("Price"));
				bike.setEngineCapacity(rs.getString("Engine_Capacity"));
				bike.setFuelType(rs.getString("Fuel_Type"));
				bike.setTransmission(rs.getString("Transmission"));
				bike.setPower(rs.getString("Power"));
				bike.setStockQuantity(rs.getInt("Stock_Quantity"));
				bike.setBikeImage(rs.getBytes("Bike_Image"));
				
				bikes.add(bike);
			}
			
			// Build search params for pagination links
			StringBuilder searchParams = new StringBuilder();
			if (brand != null && !brand.isEmpty()) {
				searchParams.append("&brand=").append(brand);
			}
			if (type != null && !type.isEmpty()) {
				searchParams.append("&type=").append(type);
			}
			if (priceRange != null && !priceRange.isEmpty()) {
				searchParams.append("&price=").append(priceRange);
			}
			if (sortBy != null && !sortBy.isEmpty()) {
				searchParams.append("&sort=").append(sortBy);
			}
			if (searchQuery != null && !searchQuery.isEmpty()) {
				searchParams.append("&search=").append(searchQuery);
			}

			// Set attributes for JSP
			request.setAttribute("bikesList", bikes);
			request.setAttribute("currentPage", page);
			request.setAttribute("totalPages", totalPages);
			request.setAttribute("searchParams", searchParams.toString());
			
			// Forward to JSP
			request.getRequestDispatcher("/user/bikes.jsp").forward(request, response);
			
		} catch (SQLException e) {
			e.printStackTrace();
			// Handle error
			request.setAttribute("error", "Database error: " + e.getMessage());
			request.getRequestDispatcher("/error.jsp").forward(request, response);
		}
	}

	/**
	 * Get all unique bike brands from the database
	 */
	private Set<String> getAllBrands(Connection conn) throws SQLException {
		Set<String> brands = new HashSet<>();
		
		String sql = "SELECT DISTINCT Brand_Name FROM bike WHERE Brand_Name IS NOT NULL ORDER BY Brand_Name";
		try (PreparedStatement stmt = conn.prepareStatement(sql);
			 ResultSet rs = stmt.executeQuery()) {
			
			while (rs.next()) {
				brands.add(rs.getString("Brand_Name"));
			}
		}
		
		return brands;
	}
	
	/**
	 * Get all unique bike types from the database
	 */
	private Set<String> getAllTypes(Connection conn) throws SQLException {
		Set<String> types = new HashSet<>();
		
		String sql = "SELECT DISTINCT Type FROM bike WHERE Type IS NOT NULL ORDER BY Type";
		try (PreparedStatement stmt = conn.prepareStatement(sql);
			 ResultSet rs = stmt.executeQuery()) {
			
			while (rs.next()) {
				types.add(rs.getString("Type"));
			}
		}
		
		return types;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
