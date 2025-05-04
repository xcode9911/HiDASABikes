<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Sales History - HiDASA Bikes</title>
    <link rel="stylesheet" href="../assets/css/adminStyle.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                <li><a href="sales.jsp" class="active"><i class="fas fa-chart-line"></i> Sales History</a></li>
                <li><a href="add-bike.jsp"><i class="fas fa-plus-circle"></i> Add New Bike</a></li>
                <li><a href="manage-bikes.jsp"><i class="fas fa-bicycle"></i> Manage Bikes</a></li>
                <li><a href="inventory.jsp"><i class="fas fa-box"></i> Inventory</a></li>
                <li><a href="messages.jsp"><i class="fas fa-envelope"></i> Messages</a></li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <div class="welcome-header">
                <h1>Sales History</h1>
                <p>Track your business performance and sales analytics</p>
            </div>
            
            <!-- Sales Summary Cards -->
            <div class="dashboard-cards">
                <div class="card">
                    <h3>Total Sales</h3>
                    <div class="value">₹8,50,000</div>
                </div>
                <div class="card">
                    <h3>Monthly Sales</h3>
                    <div class="value">₹2,25,000</div>
                </div>
                <div class="card">
                    <h3>Total Orders</h3>
                    <div class="value">45</div>
                </div>
                <div class="card">
                    <h3>Average Order Value</h3>
                    <div class="value">₹18,889</div>
                </div>
            </div>

            <!-- Sales History Table -->
            <div class="table-container">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                    <h2>Sales Records</h2>
                    <div>
                        <input type="date" style="padding: 8px; margin-right: 10px; border: 1px solid var(--border-color); border-radius: 5px;">
                        <button>Filter</button>
                    </div>
                </div>

                <table>
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Date</th>
                            <th>Customer Name</th>
                            <th>Bike Model</th>
                            <th>Amount</th>
                            <th>Payment Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>#ORD-001</td>
                            <td>2024-03-15</td>
                            <td>John Doe</td>
                            <td>Mountain Pro X1</td>
                            <td>₹25,000</td>
                            <td><span class="status-badge status-completed">Paid</span></td>
                            <td>
                                <button style="padding: 5px 10px;"><i class="fas fa-eye"></i> View</button>
                            </td>
                        </tr>
                        <tr>
                            <td>#ORD-002</td>
                            <td>2024-03-14</td>
                            <td>Jane Smith</td>
                            <td>Road Master R2</td>
                            <td>₹35,000</td>
                            <td><span class="status-badge status-pending">Pending</span></td>
                            <td>
                                <button style="padding: 5px 10px;"><i class="fas fa-eye"></i> View</button>
                            </td>
                        </tr>
                        <tr>
                            <td>#ORD-003</td>
                            <td>2024-03-13</td>
                            <td>Mike Johnson</td>
                            <td>Hybrid Explorer</td>
                            <td>₹30,000</td>
                            <td><span class="status-badge status-completed">Paid</span></td>
                            <td>
                                <button style="padding: 5px 10px;"><i class="fas fa-eye"></i> View</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Monthly Sales Chart -->
            <div class="table-container">
                <h2>Monthly Sales Analysis</h2>
                <div style="height: 300px;">
                    <canvas id="salesChart"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!-- Chart.js Script -->
    <script>
        const ctx = document.getElementById('salesChart').getContext('2d');
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                datasets: [{
                    label: 'Sales Revenue',
                    data: [350000, 450000, 520000, 480000, 600000, 580000],
                    borderColor: '#ff0066',
                    backgroundColor: 'rgba(255, 0, 102, 0.1)',
                    fill: true,
                    tension: 0.4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: value => '₹' + value.toLocaleString()
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>
