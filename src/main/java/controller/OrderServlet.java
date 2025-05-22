package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;

import dao.OrderDAO;
import dao.BikeDAO;
import modal.Order;
import modal.OrderDetail;
import modal.Bike;

/**
 * Servlet implementation class OrderServlet
 */
@WebServlet("/myorders")
public class OrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private OrderDAO orderDAO;
	private BikeDAO bikeDAO;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrderServlet() {
        super();
        orderDAO = new OrderDAO();
        bikeDAO = new BikeDAO();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Get user session to check if user is logged in
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("userId") == null) {
			// If not logged in, redirect to login page
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		// Get user ID from session
		int userId = (int) session.getAttribute("userId");
		
		try {
			// Get orders for the user
			List<Order> orders = orderDAO.getOrdersByUserId(userId);
			request.setAttribute("orders", orders);
			
			// Forward to myorders page
			request.getRequestDispatcher("/user/myorders.jsp").forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
			request.setAttribute("error", "Failed to retrieve orders: " + e.getMessage());
			request.getRequestDispatcher("/user/myorders.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Get the action parameter
		String action = request.getParameter("action");
		
		if ("cancel".equals(action)) {
			// Handle order cancellation
			String orderId = request.getParameter("orderId");
			boolean restoreStock = Boolean.parseBoolean(request.getParameter("restoreStock"));
			
			if (orderId != null && !orderId.isEmpty()) {
				try {
					int orderIdInt = Integer.parseInt(orderId);
					
					// If restoreStock is true, we need to update the bike inventory
					if (restoreStock) {
						try {
							// Get all order details for this order
							List<OrderDetail> orderDetails = orderDAO.getOrderDetailsByOrderId(orderIdInt);
							
							// For each order detail, restore the stock quantity
							for (OrderDetail detail : orderDetails) {
								// Get the current bike
								Bike bike = bikeDAO.getBikeById(detail.getBikeId());
								if (bike != null) {
									// Increase stock quantity
									bike.setStockQuantity(bike.getStockQuantity() + detail.getQuantity());
									// Update bike in database
									bikeDAO.updateBike(bike);
									
									// Log the stock restoration
									System.out.println("Restored " + detail.getQuantity() + " units to bike ID: " + detail.getBikeId());
								}
							}
							
							// Log success message
							System.out.println("Stock restored for order ID: " + orderIdInt);
						} catch (Exception e) {
							e.printStackTrace();
							request.setAttribute("error", "Failed to restore stock: " + e.getMessage());
						}
					}
					
					// Update order status to canceled
					boolean success = orderDAO.updateOrderStatus(orderIdInt, "Cancelled");
					if (success) {
						request.setAttribute("message", "Order cancelled successfully");
					} else {
						request.setAttribute("error", "Failed to cancel order");
					}
				} catch (SQLException e) {
					e.printStackTrace();
					request.setAttribute("error", "Failed to cancel order: " + e.getMessage());
				}
			} else {
				request.setAttribute("error", "Invalid order ID");
			}
		} else if ("reorder".equals(action)) {
			// Handle order reordering
			String orderId = request.getParameter("orderId");
			System.out.println("Reorder request received for order ID: " + orderId);
			
			if (orderId != null && !orderId.isEmpty()) {
				try {
					int orderIdInt = Integer.parseInt(orderId);
					HttpSession session = request.getSession(false);
					if (session == null || session.getAttribute("userId") == null) {
						System.out.println("User not logged in, redirecting to login");
						response.sendRedirect(request.getContextPath() + "/login");
						return;
					}
					
					int userId = (int) session.getAttribute("userId");
					System.out.println("Processing reorder for user ID: " + userId);
					
					// Get the original order 
					Order originalOrder = orderDAO.getOrderById(orderIdInt);
					
					if (originalOrder == null) {
						System.out.println("Original order not found: " + orderIdInt);
						request.setAttribute("error", "Original order not found");
						doGet(request, response);
						return;
					}
					
					System.out.println("Original order found with status: " + originalOrder.getStatus());
					
					List<OrderDetail> originalOrderDetails = originalOrder.getOrderDetails();
					System.out.println("Original order has " + originalOrderDetails.size() + " items");
					
					// Check if all bikes are still in stock with sufficient quantity
					boolean allBikesAvailable = true;
					StringBuilder unavailableBikes = new StringBuilder();
					
					for (OrderDetail detail : originalOrderDetails) {
						Bike bike = bikeDAO.getBikeById(detail.getBikeId());
						System.out.println("Checking bike ID: " + detail.getBikeId() + 
							", Quantity needed: " + detail.getQuantity() + 
							", Available: " + (bike != null ? bike.getStockQuantity() : "N/A"));
						
						if (bike == null || bike.getStockQuantity() < detail.getQuantity()) {
							allBikesAvailable = false;
							String bikeName = bike != null ? bike.getBrandName() + " " + bike.getModelName() : "Unknown bike";
							unavailableBikes.append(bikeName)
								.append(" (requested: ").append(detail.getQuantity())
								.append(", available: ").append(bike != null ? bike.getStockQuantity() : 0)
								.append(")<br>");
						}
					}
					
					if (!allBikesAvailable) {
						System.out.println("Some bikes are unavailable: " + unavailableBikes.toString());
						request.setAttribute("error", "Cannot reorder. The following bikes are not available in the requested quantity:<br>" + unavailableBikes.toString());
					} else {
						try {
							System.out.println("All bikes available, creating new order");
							// Create a new order
							Order newOrder = new Order();
							newOrder.setOrderDate(new java.util.Date());
							newOrder.setStatus("Pending");
							
							// Copy order details from original order
							List<OrderDetail> newOrderDetails = new ArrayList<>();
							for (OrderDetail originalDetail : originalOrderDetails) {
								OrderDetail newDetail = new OrderDetail();
								newDetail.setBikeId(originalDetail.getBikeId());
								newDetail.setQuantity(originalDetail.getQuantity());
								newDetail.setBike(originalDetail.getBike()); // Copy bike info
								newOrderDetails.add(newDetail);
								System.out.println("Added bike ID: " + originalDetail.getBikeId() + 
									" with quantity: " + originalDetail.getQuantity());
							}
							
							newOrder.setOrderDetails(newOrderDetails);
							
							// Save the new order
							System.out.println("Calling orderDAO.createOrder...");
							int newOrderId = orderDAO.createOrder(newOrder, userId);
							System.out.println("createOrder returned order ID: " + newOrderId);
							
							if (newOrderId > 0) {
								System.out.println("New order created successfully with ID: " + newOrderId);
								request.setAttribute("message", "Reorder placed successfully. Your new order ID is: #ORD" + newOrderId);
								// Don't redirect, just continue to doGet to show the updated orders list
							} else {
								System.out.println("Failed to create reorder, newOrderId <= 0");
								request.setAttribute("error", "Failed to create reorder");
							}
						} catch (Exception e) {
							System.out.println("Exception while creating new order: " + e.getMessage());
							e.printStackTrace();
							request.setAttribute("error", "Failed to create reorder: " + e.getMessage());
						}
					}
				} catch (Exception e) {
					System.out.println("Exception in reorder process: " + e.getMessage());
					e.printStackTrace();
					request.setAttribute("error", "Failed to reorder: " + e.getMessage());
				}
			} else {
				System.out.println("Invalid order ID for reorder");
				request.setAttribute("error", "Invalid order ID");
			}
		} else if ("bulkDelete".equals(action)) {
			// Handle bulk deletion of cancelled orders
			HttpSession session = request.getSession(false);
			if (session == null || session.getAttribute("userId") == null) {
				response.sendRedirect(request.getContextPath() + "/login");
				return;
			}
			
			int userId = (int) session.getAttribute("userId");
			
			try {
				// Get all orders for the user
				List<Order> orders = orderDAO.getOrdersByUserId(userId);
				int deletedCount = 0;
				
				// Filter cancelled orders and delete them
				for (Order order : orders) {
					if ("Cancelled".equals(order.getStatus())) {
						// Delete the order
						boolean deleted = deleteOrder(order.getOrderId());
						if (deleted) {
							deletedCount++;
						}
					}
				}
				
				if (deletedCount > 0) {
					request.setAttribute("message", deletedCount + " cancelled order(s) deleted successfully");
				} else {
					request.setAttribute("message", "No cancelled orders to delete");
				}
			} catch (SQLException e) {
				e.printStackTrace();
				request.setAttribute("error", "Failed to delete orders: " + e.getMessage());
			}
		}
		
		// Redirect to GET method to refresh the order list
		doGet(request, response);
	}
	
	/**
	 * Helper method to delete an order and its related data
	 */
	private boolean deleteOrder(int orderId) {
		try {
			// Delete order details first (foreign key constraint)
			boolean detailsDeleted = deleteOrderDetails(orderId);
			
			// Delete payment records (foreign key constraint)
			boolean paymentsDeleted = deleteOrderPayments(orderId);
			
			// If details and payments successfully deleted, proceed with order deletion
			if (detailsDeleted && paymentsDeleted) {
				// Delete the user_order relationship (foreign key constraint)
				boolean userOrderDeleted = deleteUserOrder(orderId);
				
				if (userOrderDeleted) {
					// Finally delete the order itself
					String sql = "DELETE FROM `order` WHERE OrderID = ?";
					try (java.sql.Connection conn = util.DatabaseUtil.getConnection();
						java.sql.PreparedStatement stmt = conn.prepareStatement(sql)) {
						
						stmt.setInt(1, orderId);
						int rows = stmt.executeUpdate();
						
						return rows > 0;
					}
				}
			}
			
			return false;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}
	
	/**
	 * Helper method to delete order details for an order
	 */
	private boolean deleteOrderDetails(int orderId) throws SQLException {
		String sql = "DELETE FROM orderdetail WHERE OrderID = ?";
		try (java.sql.Connection conn = util.DatabaseUtil.getConnection();
			java.sql.PreparedStatement stmt = conn.prepareStatement(sql)) {
			
			stmt.setInt(1, orderId);
			stmt.executeUpdate();
			
			// Even if no rows were affected (no order details), we consider it a success
			return true;
		}
	}
	
	/**
	 * Helper method to delete payment records for an order
	 */
	private boolean deleteOrderPayments(int orderId) throws SQLException {
		// First check if payment records exist
		boolean paymentsExist = false;
		String checkSql = "SELECT COUNT(*) FROM order_payment WHERE OrderID = ?";
		
		try (java.sql.Connection conn = util.DatabaseUtil.getConnection();
			java.sql.PreparedStatement stmt = conn.prepareStatement(checkSql)) {
			
			stmt.setInt(1, orderId);
			try (java.sql.ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					paymentsExist = rs.getInt(1) > 0;
				}
			}
		}
		
		// If payments exist, delete them
		if (paymentsExist) {
			String sql = "DELETE FROM order_payment WHERE OrderID = ?";
			try (java.sql.Connection conn = util.DatabaseUtil.getConnection();
				java.sql.PreparedStatement stmt = conn.prepareStatement(sql)) {
				
				stmt.setInt(1, orderId);
				stmt.executeUpdate();
			}
		}
		
		return true;
	}
	
	/**
	 * Helper method to delete user_order relationship for an order
	 */
	private boolean deleteUserOrder(int orderId) throws SQLException {
		String sql = "DELETE FROM user_order WHERE OrderID = ?";
		try (java.sql.Connection conn = util.DatabaseUtil.getConnection();
			java.sql.PreparedStatement stmt = conn.prepareStatement(sql)) {
			
			stmt.setInt(1, orderId);
			stmt.executeUpdate();
			
			// Even if no rows were affected, we consider it a success
			return true;
		}
	}
}
