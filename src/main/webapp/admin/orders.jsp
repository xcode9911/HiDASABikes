<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="modal.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Orders - Bike Showroom Admin</title>
    <link rel="stylesheet" href="../assets/css/adminStyle.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }
        
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 30%;
            border-radius: 5px;
        }
        
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }
        
        .close:hover {
            color: black;
        }
        
        .status-options {
            margin: 20px 0;
        }
        
        .status-options select {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
        }
        
        .modal-buttons {
            text-align: right;
        }
        
        .modal-buttons button {
            padding: 8px 15px;
            margin-left: 10px;
            cursor: pointer;
        }
        
        .btn-cancel {
            background-color: #f44336;
            color: white;
            border: none;
            border-radius: 4px;
        }
        
        .btn-save {
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <jsp:include page="adminsidebar.jsp" />

    <div class="container">
        <!-- Main Content -->
        <div class="main-content">
            <h1>All Orders</h1>
            
            <!-- Filter Section -->
            <div class="table-container">
                <form action="orders.jsp" method="get" style="margin-bottom: 20px;">
                    <select name="status" style="width: 200px; margin-right: 10px;">
                        <option value="">All Status</option>
                        <option value="Pending" <%= request.getParameter("status") != null && request.getParameter("status").equals("Pending") ? "selected" : "" %>>Pending</option>
                        <option value="Delivered" <%= request.getParameter("status") != null && request.getParameter("status").equals("Delivered") ? "selected" : "" %>>Delivered</option>
                        <option value="Cancelled" <%= request.getParameter("status") != null && request.getParameter("status").equals("Cancelled") ? "selected" : "" %>>Cancelled</option>
                    </select>
                    <input type="date" name="date" value="<%= request.getParameter("date") != null ? request.getParameter("date") : "" %>" style="width: 200px; margin-right: 10px;">
                    <button type="submit">Filter</button>
                </form>

                <table>
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Date</th>
                            <th>Customer Name</th>
                            <th>Bike Model</th>
                            <th>Amount</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        OrderDAO orderDAO = new OrderDAO();
                        UserDAO userDAO = new UserDAO();
                        List<Order> orders = new ArrayList<>();
                        
                        try {
                            // Get filter parameters
                            String status = request.getParameter("status");
                            String date = request.getParameter("date");
                            
                            // Fetch all orders
                            orders = orderDAO.getAllOrders();
                            
                            // Apply filters if provided
                            if (status != null && !status.isEmpty()) {
                                orders.removeIf(order -> !order.getStatus().equals(status));
                            }
                            if (date != null && !date.isEmpty()) {
                                java.sql.Date filterDate = java.sql.Date.valueOf(date);
                                orders.removeIf(order -> !order.getOrderDate().equals(filterDate));
                            }
                            
                            // Display orders
                            for (Order order : orders) {
                                // Get user information
                                User user = userDAO.getUserByOrderId(order.getOrderId());
                                String userName = user != null ? user.getName() : "Unknown";
                                
                                // Get first bike from order details
                                String bikeModel = "N/A";
                                if (order.getOrderDetails() != null && !order.getOrderDetails().isEmpty()) {
                                    Bike bike = order.getOrderDetails().get(0).getBike();
                                    if (bike != null) {
                                        bikeModel = bike.getModelName();
                                    }
                                }
                        %>
                        <tr>
                            <td><%= order.getOrderId() %></td>
                            <td><%= order.getFormattedDate() %></td>
                            <td><%= userName %></td>
                            <td><%= bikeModel %></td>
                            <td>₹<%= order.getFormattedTotal() %></td>
                            <td><span class="status-badge status-<%= order.getStatus().toLowerCase() %>"><%= order.getStatus() %></span></td>
                            <td>
                                <button onclick="viewOrder(<%= order.getOrderId() %>)" style="padding: 5px 10px; margin-right: 5px;">View</button>
                                <% if (order.getStatus().equals("Pending")) { %>
                                    <button onclick="openUpdateModal('<%= order.getOrderId() %>')" style="padding: 5px 10px;">Update</button>
                                <% } %>
                            </td>
                        </tr>
                        <%
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Update Status Modal -->
    <div id="updateStatusModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeUpdateModal()">&times;</span>
            <h2>Update Order Status</h2>
            <div class="status-options">
                <select id="newStatus">
                    <option value="Delivered">Delivered</option>
                    <option value="Cancelled">Cancelled</option>
                </select>
            </div>
            <div class="modal-buttons">
                <button class="btn-cancel" onclick="closeUpdateModal()">Cancel</button>
                <button class="btn-save" onclick="updateOrderStatus()">Save Changes</button>
            </div>
        </div>
    </div>

    <script>
    let currentOrderId = null;
    const modal = document.getElementById('updateStatusModal');

    function viewOrder(orderId) {
        window.location.href = 'view-order.jsp?id=' + orderId;
    }

    function openUpdateModal(orderId) {
        console.log('Opening modal for order ID:', orderId); // Debug log
        currentOrderId = parseInt(orderId);
        console.log('Parsed order ID:', currentOrderId); // Debug log
        if (isNaN(currentOrderId)) {
            alert('Invalid order ID');
            return;
        }
        modal.style.display = "block";
    }

    function closeUpdateModal() {
        modal.style.display = "none";
        currentOrderId = null;
    }

    function updateOrderStatus() {
        console.log('Updating status for order ID:', currentOrderId);
        if (!currentOrderId || isNaN(currentOrderId)) {
            alert('Invalid order ID');
            return;
        }
        
        const newStatus = document.getElementById('newStatus').value;
        console.log('New status:', newStatus);
        
        // Create the request data
        const data = {
            orderId: currentOrderId,
            status: newStatus
        };
        
        // Send AJAX request
        fetch('${pageContext.request.contextPath}/admin/orders/update-status', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data)
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            console.log('Server response:', data);
            if (data.success) {
                alert('Order status updated successfully!');
                window.location.reload();
            } else {
                alert('Failed to update order status: ' + (data.message || 'Unknown error'));
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('An error occurred while updating the order status: ' + error.message);
        })
        .finally(() => {
            closeUpdateModal();
        });
    }

    // Close modal when clicking outside
    window.onclick = function(event) {
        if (event.target == modal) {
            closeUpdateModal();
        }
    }
    </script>
</body>
</html> 