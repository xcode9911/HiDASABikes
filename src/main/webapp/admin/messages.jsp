<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Messages - Bike Showroom Admin</title>
    <link rel="stylesheet" href="../assets/css/adminStyle.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-header">
                <img src="../assets/images/logo.png" alt="HiDASA Bikes Logo">
            </div>
            <ul class="sidebar-menu">
                <li><a href="dashboard.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
                <li><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> Orders</a></li>
                <li><a href="sales.jsp"><i class="fas fa-chart-line"></i> Sales History</a></li>
                <li><a href="add-bike.jsp"><i class="fas fa-plus-circle"></i> Add New Bike</a></li>
                <li><a href="manage-bikes.jsp"><i class="fas fa-bicycle"></i> Manage Bikes</a></li>
                <li><a href="inventory.jsp"><i class="fas fa-box"></i> Inventory</a></li>
                <li><a href="messages.jsp" class="active"><i class="fas fa-envelope"></i> Messages</a></li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <h1>Customer Messages</h1>
            
            <!-- Message Summary Cards -->
            <div class="dashboard-cards">
                <div class="card">
                    <h3>Total Messages</h3>
                    <div class="value">25</div>
                </div>
                <div class="card">
                    <h3>Unread Messages</h3>
                    <div class="value">5</div>
                </div>
                <div class="card">
                    <h3>Pending Replies</h3>
                    <div class="value">8</div>
                </div>
            </div>

            <!-- Messages Table -->
            <div class="table-container">
                <div style="margin-bottom: 20px;">
                    <select style="width: 200px; margin-right: 10px;">
                        <option value="">All Messages</option>
                        <option value="unread">Unread</option>
                        <option value="pending">Pending Reply</option>
                        <option value="replied">Replied</option>
                    </select>
                    <button>Filter</button>
                </div>

                <table>
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Customer Name</th>
                            <th>Email</th>
                            <th>Subject</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>2024-03-15</td>
                            <td>John Doe</td>
                            <td>john@example.com</td>
                            <td>Bike Availability Inquiry</td>
                            <td><span class="status-badge status-pending">Unread</span></td>
                            <td>
                                <button style="padding: 5px 10px; margin-right: 5px;">View</button>
                                <button style="padding: 5px 10px;">Reply</button>
                            </td>
                        </tr>
                        <tr>
                            <td>2024-03-14</td>
                            <td>Jane Smith</td>
                            <td>jane@example.com</td>
                            <td>Service Appointment Request</td>
                            <td><span class="status-badge status-pending">Pending Reply</span></td>
                            <td>
                                <button style="padding: 5px 10px; margin-right: 5px;">View</button>
                                <button style="padding: 5px 10px;">Reply</button>
                            </td>
                        </tr>
                        <tr>
                            <td>2024-03-13</td>
                            <td>Mike Johnson</td>
                            <td>mike@example.com</td>
                            <td>Product Information Request</td>
                            <td><span class="status-badge status-completed">Replied</span></td>
                            <td>
                                <button style="padding: 5px 10px; margin-right: 5px;">View</button>
                                <button style="padding: 5px 10px;">Reply</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html> 