package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

import dao.OrderDAO;
import dao.BikeDAO;
import modal.Order;

/**
 * Servlet implementation class OrderDetailsServlet
 */
@WebServlet("/order-details")
public class OderDetailsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private OrderDAO orderDAO;
	private BikeDAO bikeDAO;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OderDetailsServlet() {
        super();
        orderDAO = new OrderDAO();
        bikeDAO = new BikeDAO();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Get the order ID from request parameter
		String orderId = request.getParameter("id");
		
		// Check if user is logged in
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("userId") == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}
		
		// Get message parameter if available
		String message = request.getParameter("message");
		if (message != null && !message.isEmpty()) {
			request.setAttribute("message", message);
		}
		
		if (orderId != null && !orderId.isEmpty()) {
			try {
				int orderIdInt = Integer.parseInt(orderId);
				
				// Get order details
				Order order = orderDAO.getOrderById(orderIdInt);
				
				if (order != null) {
					// Add order to request
					request.setAttribute("order", order);
					
					// Forward to order details page
					request.getRequestDispatcher("/user/order-details.jsp").forward(request, response);
				} else {
					// Order not found
					request.setAttribute("error", "Order not found");
					request.getRequestDispatcher("/user/myorders").forward(request, response);
				}
			} catch (NumberFormatException e) {
				request.setAttribute("error", "Invalid order ID format");
				request.getRequestDispatcher("/user/myorders").forward(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
				request.setAttribute("error", "Error retrieving order details: " + e.getMessage());
				request.getRequestDispatcher("/user/myorders").forward(request, response);
			}
		} else {
			// No order ID provided
			response.sendRedirect(request.getContextPath() + "/myorders");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Get action parameter
        String action = request.getParameter("action");
        
        if ("updateStatus".equals(action)) {
            // Only for admin use - update order status
            String orderId = request.getParameter("orderId");
            String newStatus = request.getParameter("status");
            
            if (orderId != null && newStatus != null) {
                try {
                    int orderIdInt = Integer.parseInt(orderId);
                    boolean updated = orderDAO.updateOrderStatus(orderIdInt, newStatus);
                    
                    if (updated) {
                        request.setAttribute("message", "Order status updated successfully");
                    } else {
                        request.setAttribute("error", "Failed to update order status");
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid order ID");
                } catch (SQLException e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Database error: " + e.getMessage());
                }
            }
            
            // Redirect back to order details
            response.sendRedirect(request.getContextPath() + "/order-details?id=" + orderId);
        } else {
            doGet(request, response);
        }
	}
}
