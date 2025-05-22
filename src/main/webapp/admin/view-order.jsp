<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="modal.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Details - Bike Showroom Admin</title>
    <link rel="stylesheet" href="../assets/css/adminStyle.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .order-details {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin: 20px 0;
        }
        
        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }
        
        .order-info {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .info-group {
            margin-bottom: 15px;
        }
        
        .info-label {
            font-weight: 500;
            color: #666;
            margin-bottom: 5px;
        }
        
        .info-value {
            font-size: 1.1em;
            color: #333;
        }
        
        .bike-details {
            margin-top: 20px;
        }
        
        .bike-card {
            display: flex;
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 15px;
        }
        
        .bike-image {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 8px;
            margin-right: 20px;
        }
        
        .bike-info {
            flex: 1;
        }
        
        .bike-name {
            font-size: 1.2em;
            font-weight: 600;
            margin-bottom: 10px;
        }
        
        .bike-specs {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
        }
        
        .back-button {
            background-color: #6c757d;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin-bottom: 20px;
        }
        
        .back-button:hover {
            background-color: #5a6268;
        }
        
        .status-badge {
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: 500;
            text-transform: uppercase;
            font-size: 0.9em;
        }
        
        .status-pending {
            background-color: #ffeeba;
            color: #856404;
        }
        
        .status-delivered {
            background-color: #d4edda;
            color: #155724;
        }
        
        .status-cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }
    </style>
</head>
<body>
    <jsp:include page="adminsidebar.jsp" />

    <div class="container">
        <!-- Main Content -->
        <div class="main-content">
            <a href="orders.jsp" class="back-button">
                <i class="fas fa-arrow-left"></i> Back to Orders
            </a>
            
            <%
            String orderIdStr = request.getParameter("id");
            if (orderIdStr != null && !orderIdStr.trim().isEmpty()) {
                try {
                    int orderId = Integer.parseInt(orderIdStr);
                    OrderDAO orderDAO = new OrderDAO();
                    UserDAO userDAO = new UserDAO();
                    
                    Order order = orderDAO.getOrderById(orderId);
                    if (order != null) {
                        User user = userDAO.getUserByOrderId(orderId);
            %>
                        <div class="order-details">
                            <div class="order-header">
                                <h1>Order #<%= order.getOrderId() %></h1>
                                <span class="status-badge status-<%= order.getStatus().toLowerCase() %>">
                                    <%= order.getStatus() %>
                                </span>
                            </div>
                            
                            <div class="order-info">
                                <div class="info-group">
                                    <div class="info-label">Order Date</div>
                                    <div class="info-value"><%= order.getFormattedDate() %></div>
                                </div>
                                
                                <div class="info-group">
                                    <div class="info-label">Total Amount</div>
                                    <div class="info-value">₹<%= order.getFormattedTotal() %></div>
                                </div>
                                
                                <% if (user != null) { %>
                                <div class="info-group">
                                    <div class="info-label">Customer Name</div>
                                    <div class="info-value"><%= user.getName() %></div>
                                </div>
                                
                                <div class="info-group">
                                    <div class="info-label">Customer Email</div>
                                    <div class="info-value"><%= user.getEmail() %></div>
                                </div>
                                
                                <div class="info-group">
                                    <div class="info-label">Customer Phone</div>
                                    <div class="info-value"><%= user.getPhone() %></div>
                                </div>
                                <% } %>
                            </div>
                            
                            <div class="bike-details">
                                <h2>Ordered Bikes</h2>
                                <%
                                if (order.getOrderDetails() != null && !order.getOrderDetails().isEmpty()) {
                                    for (OrderDetail detail : order.getOrderDetails()) {
                                        Bike bike = detail.getBike();
                                        if (bike != null) {
                                %>
                                        <div class="bike-card">
                                            <% if (bike.getBikeImage() != null) { %>
                                                <img src="data:image/jpeg;base64,<%= java.util.Base64.getEncoder().encodeToString(bike.getBikeImage()) %>" 
                                                     alt="<%= bike.getModelName() %>" class="bike-image">
                                            <% } else { %>
                                                <img src="../assets/images/no-image.png" alt="No Image" class="bike-image">
                                            <% } %>
                                            
                                            <div class="bike-info">
                                                <div class="bike-name">
                                                    <%= bike.getBrandName() %> <%= bike.getModelName() %>
                                                </div>
                                                
                                                <div class="bike-specs">
                                                    <div class="info-group">
                                                        <div class="info-label">Engine Capacity</div>
                                                        <div class="info-value"><%= bike.getEngineCapacity() %></div>
                                                    </div>
                                                    
                                                    <div class="info-group">
                                                        <div class="info-label">Fuel Type</div>
                                                        <div class="info-value"><%= bike.getFuelType() %></div>
                                                    </div>
                                                    
                                                    <div class="info-group">
                                                        <div class="info-label">Transmission</div>
                                                        <div class="info-value"><%= bike.getTransmission() %></div>
                                                    </div>
                                                    
                                                    <div class="info-group">
                                                        <div class="info-label">Color</div>
                                                        <div class="info-value"><%= bike.getColor() %></div>
                                                    </div>
                                                    
                                                    <div class="info-group">
                                                        <div class="info-label">Quantity</div>
                                                        <div class="info-value"><%= detail.getQuantity() %></div>
                                                    </div>
                                                    
                                                    <div class="info-group">
                                                        <div class="info-label">Price</div>
                                                        <div class="info-value">₹<%= bike.getPrice() %></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                <%
                                        }
                                    }
                                }
                                %>
                            </div>
                        </div>
            <%
                    } else {
            %>
                        <div class="error-message">
                            <h2>Order Not Found</h2>
                            <p>The requested order could not be found.</p>
                        </div>
            <%
                    }
                } catch (NumberFormatException e) {
            %>
                    <div class="error-message">
                        <h2>Invalid Order ID</h2>
                        <p>The provided order ID is invalid.</p>
                    </div>
            <%
                } catch (SQLException e) {
            %>
                    <div class="error-message">
                        <h2>Database Error</h2>
                        <p>An error occurred while retrieving the order details.</p>
                    </div>
            <%
                }
            } else {
            %>
                <div class="error-message">
                    <h2>No Order ID Provided</h2>
                    <p>Please provide an order ID to view the details.</p>
                </div>
            <%
            }
            %>
        </div>
    </div>
</body>
</html> 