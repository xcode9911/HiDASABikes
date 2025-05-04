<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Bikes - Bike Showroom Admin</title>
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
                <li><a href="manage-bikes.jsp" class="active"><i class="fas fa-bicycle"></i> Manage Bikes</a></li>
                <li><a href="inventory.jsp"><i class="fas fa-box"></i> Inventory</a></li>
                <li><a href="messages.jsp"><i class="fas fa-envelope"></i> Messages</a></li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <h1>Manage Bikes</h1>
            
            <!-- Search and Filter Section -->
            <div class="table-container">
                <div style="margin-bottom: 20px;">
                    <input type="text" placeholder="Search by model name..." style="width: 300px; margin-right: 10px;">
                    <select style="width: 200px; margin-right: 10px;">
                        <option value="">All Categories</option>
                        <option value="mountain">Mountain Bike</option>
                        <option value="road">Road Bike</option>
                        <option value="hybrid">Hybrid Bike</option>
                        <option value="electric">Electric Bike</option>
                    </select>
                    <button>Search</button>
                </div>

                <table>
                    <thead>
                        <tr>
                            <th>Model</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Mountain Pro X1</td>
                            <td>Mountain Bike</td>
                            <td>₹25,000</td>
                            <td>15</td>
                            <td><span class="status-badge status-completed">In Stock</span></td>
                            <td>
                                <button style="padding: 5px 10px; margin-right: 5px;">Edit</button>
                                <button style="padding: 5px 10px; background-color: var(--accent-color);">Delete</button>
                            </td>
                        </tr>
                        <tr>
                            <td>Road Master R2</td>
                            <td>Road Bike</td>
                            <td>₹35,000</td>
                            <td>8</td>
                            <td><span class="status-badge status-pending">Low Stock</span></td>
                            <td>
                                <button style="padding: 5px 10px; margin-right: 5px;">Edit</button>
                                <button style="padding: 5px 10px; background-color: var(--accent-color);">Delete</button>
                            </td>
                        </tr>
                        <tr>
                            <td>Hybrid Explorer</td>
                            <td>Hybrid Bike</td>
                            <td>₹30,000</td>
                            <td>0</td>
                            <td><span class="status-badge status-cancelled">Out of Stock</span></td>
                            <td>
                                <button style="padding: 5px 10px; margin-right: 5px;">Edit</button>
                                <button style="padding: 5px 10px; background-color: var(--accent-color);">Delete</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html> 