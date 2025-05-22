<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - HiDASA Bikes</title>
    <link rel="stylesheet" href="../assets/css/adminStyle.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <jsp:include page="adminsidebar.jsp" />

        <!-- Main Content -->
        <div class="main-content">
            <div class="welcome-header">
                <h1>Good morning</h1>
                <p>Here's what's happening with your store today</p>
            
            
            <!-- Summary Cards -->
            <div class="dashboard-cards">
                <div class="card">
                    <h3>Total Sales</h3>
                    <div class="value">₹8.5L</div>
                </div>
                <div class="card">
                    <h3>New Orders</h3>
                    <div class="value">12</div>
                </div>
                <div class="card">
                    <h3>Low Stock Items</h3>
                    <div class="value">5</div>
                </div>
                <div class="card">
                    <h3>Total Customers</h3>
                    <div class="value">156</div>
                </div>
            </div>
           </div>

            <!-- Quick Actions -->
            <div class="quick-actions">
                <a href="add-bike.jsp" class="quick-action-card">
                    <i class="fas fa-plus-circle"></i>
                    <h3>Add New Bike</h3>
                </a>
                <a href="inventory.jsp" class="quick-action-card">
                    <i class="fas fa-box"></i>
                    <h3>Update Stock</h3>
                </a>
                <a href="sales" class="quick-action-card">
                    <i class="fas fa-chart-bar"></i>
                    <h3>View Reports</h3>
                </a>
                <div class="quick-action-card">
                    <i class="fas fa-cog"></i>
                    <h3>Settings</h3>
                </div>
            </div>
           

            <!-- Recent Activity -->
            <div class="table-container">
                <h2>Activity</h2>
                <table>
                    <tbody>
                        <tr>
                            <td>
                                <i class="fas fa-shopping-cart" style="color: var(--primary-color); margin-right: 10px;"></i>
                                New Order Received
                            </td>
                            <td>Mountain Pro X1</td>
                            <td>₹25,000</td>
                        </tr>
                        <tr>
                            <td>
                                <i class="fas fa-box" style="color: var(--primary-color); margin-right: 10px;"></i>
                                Low Stock Alert
                            </td>
                            <td>Road Master R2</td>
                            <td>2 units left</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Success notification -->
    <script>
        function showSuccessMessage(message) {
            // Implementation of showing a success message
            console.log("Success: " + message);
        }
    </script>

    <!-- Error notification -->
    <script>
        function showErrorMessage(message) {
            // Implementation of showing an error message
            console.log("Error: " + message);
        }
    </script>

    <!-- Warning notification -->
    <script>
        function showWarningMessage(message) {
            // Implementation of showing a warning message
            console.log("Warning: " + message);
        }
    </script>

    <!-- Info notification -->
    <script>
        function showInfoMessage(message) {
            // Implementation of showing an info message
            console.log("Info: " + message);
        }
    </script>
</body>
</html> 