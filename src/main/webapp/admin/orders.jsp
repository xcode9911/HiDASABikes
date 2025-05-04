<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Orders - Bike Showroom Admin</title>
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
                <li><a href="orders.jsp" class="active"><i class="fas fa-shopping-cart"></i> Orders</a></li>
                <li><a href="sales.jsp"><i class="fas fa-chart-line"></i> Sales History</a></li>
                <li><a href="add-bike.jsp"><i class="fas fa-plus-circle"></i> Add New Bike</a></li>
                <li><a href="manage-bikes.jsp"><i class="fas fa-bicycle"></i> Manage Bikes</a></li>
                <li><a href="inventory.jsp"><i class="fas fa-box"></i> Inventory</a></li>
                <li><a href="messages.jsp"><i class="fas fa-envelope"></i> Messages</a></li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <h1>All Orders</h1>
            
            <!-- Filter Section -->
            <div class="table-container">
                <div style="margin-bottom: 20px;">
                    <select style="width: 200px; margin-right: 10px;">
                        <option value="">All Status</option>
                        <option value="pending">Pending</option>
                        <option value="completed">Completed</option>
                        <option value="cancelled">Cancelled</option>
                    </select>
                    <input type="date" style="width: 200px; margin-right: 10px;">
                    <button>Filter</button>
                </div>

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
                        <tr>
                            <td>ORD-001</td>
                            <td>2024-03-15</td>
                            <td>John Doe</td>
                            <td>Mountain Pro X1</td>
                            <td>₹25,000</td>
                            <td><span class="status-badge status-pending">Pending</span></td>
                            <td>
                                <button style="padding: 5px 10px; margin-right: 5px;">View</button>
                                <button style="padding: 5px 10px;">Update</button>
                            </td>
                        </tr>
                        <tr>
                            <td>ORD-002</td>
                            <td>2024-03-14</td>
                            <td>Jane Smith</td>
                            <td>Road Master R2</td>
                            <td>₹35,000</td>
                            <td><span class="status-badge status-completed">Completed</span></td>
                            <td>
                                <button style="padding: 5px 10px; margin-right: 5px;">View</button>
                                <button style="padding: 5px 10px;">Update</button>
                            </td>
                        </tr>
                        <tr>
                            <td>ORD-003</td>
                            <td>2024-03-13</td>
                            <td>Mike Johnson</td>
                            <td>Hybrid Explorer</td>
                            <td>₹30,000</td>
                            <td><span class="status-badge status-cancelled">Cancelled</span></td>
                            <td>
                                <button style="padding: 5px 10px; margin-right: 5px;">View</button>
                                <button style="padding: 5px 10px;">Update</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html> 