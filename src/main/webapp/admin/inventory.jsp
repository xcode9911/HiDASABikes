<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Inventory - Bike Showroom Admin</title>
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
                <li><a href="inventory.jsp" class="active"><i class="fas fa-box"></i> Inventory</a></li>
                <li><a href="messages.jsp"><i class="fas fa-envelope"></i> Messages</a></li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <h1>Inventory Management</h1>
            
            <!-- Stock Summary Cards -->
            <div class="dashboard-cards">
                <div class="card">
                    <h3>Total Stock</h3>
                    <div class="value">150</div>
                </div>
                <div class="card">
                    <h3>Low Stock Items</h3>
                    <div class="value">5</div>
                </div>
                <div class="card">
                    <h3>Out of Stock</h3>
                    <div class="value">2</div>
                </div>
                <div class="card">
                    <h3>Total Value</h3>
                    <div class="value">₹45,00,000</div>
                </div>
            </div>

            <!-- Inventory Table -->
            <div class="table-container">
                <div style="margin-bottom: 20px;">
                    <select style="width: 200px; margin-right: 10px;">
                        <option value="">All Stock Status</option>
                        <option value="in-stock">In Stock</option>
                        <option value="low-stock">Low Stock</option>
                        <option value="out-of-stock">Out of Stock</option>
                    </select>
                    <button>Filter</button>
                </div>

                <table>
                    <thead>
                        <tr>
                            <th>Model</th>
                            <th>Category</th>
                            <th>Current Stock</th>
                            <th>Status</th>
                            <th>Last Updated</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Mountain Pro X1</td>
                            <td>Mountain Bike</td>
                            <td>15</td>
                            <td><span class="status-badge status-completed">In Stock</span></td>
                            <td>2024-03-15</td>
                            <td>
                                <button style="padding: 5px 10px;">Update Stock</button>
                            </td>
                        </tr>
                        <tr>
                            <td>Road Master R2</td>
                            <td>Road Bike</td>
                            <td>3</td>
                            <td><span class="status-badge status-pending">Low Stock</span></td>
                            <td>2024-03-14</td>
                            <td>
                                <button style="padding: 5px 10px;">Update Stock</button>
                            </td>
                        </tr>
                        <tr>
                            <td>Hybrid Explorer</td>
                            <td>Hybrid Bike</td>
                            <td>0</td>
                            <td><span class="status-badge status-cancelled">Out of Stock</span></td>
                            <td>2024-03-13</td>
                            <td>
                                <button style="padding: 5px 10px;">Update Stock</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html> 