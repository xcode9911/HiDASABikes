<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HIDASA Bikes - Admin Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary: #FF0B55;
            --primary-dark: #CF0F47;
            --secondary: #1A1A1A;
            --accent: #FFD700;
            --text-light: #FFFFFF;
            --text-dark: #1A1A1A;
            --background: #F5F5F5;
            --card-bg: #FFFFFF;
            --gradient-primary: linear-gradient(135deg, #FF0B55, #CF0F47);
            --gradient-dark: linear-gradient(135deg, #1A1A1A, #333333);
            --shadow-sm: 0 2px 4px rgba(0,0,0,0.1);
            --shadow-md: 0 4px 8px rgba(0,0,0,0.12);
            --shadow-lg: 0 8px 16px rgba(0,0,0,0.15);
            --radius-sm: 4px;
            --radius-md: 8px;
            --radius-lg: 16px;
            --header-height: 80px;
            --sidebar-width: 250px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: var(--background);
            color: var(--text-dark);
            line-height: 1.6;
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Styles */
        .sidebar {
            width: var(--sidebar-width);
            background: var(--secondary);
            color: var(--text-light);
            height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            overflow-y: auto;
            transition: all 0.3s ease;
            z-index: 1000;
        }

        .sidebar-header {
            padding: 20px;
            text-align: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar-header img {
            max-width: 120px;
            margin-bottom: 10px;
        }

        .sidebar-menu {
            padding: 20px 0;
        }

        .menu-item {
            padding: 12px 20px;
            display: flex;
            align-items: center;
            color: var(--text-light);
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .menu-item:hover, .menu-item.active {
            background: var(--primary);
            color: var(--text-light);
        }

        .menu-item i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }

        /* Main Content Styles */
        .main-content {
            flex: 1;
            margin-left: var(--sidebar-width);
            padding: 20px;
            transition: all 0.3s ease;
        }

        /* Header Styles */
        .header {
            background: var(--card-bg);
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: var(--shadow-sm);
            border-radius: var(--radius-md);
            margin-bottom: 30px;
        }

        .header-left {
            display: flex;
            align-items: center;
        }

        .search-bar {
            position: relative;
            margin-right: 20px;
        }

        .search-bar input {
            padding: 10px 15px 10px 40px;
            border: 1px solid #ddd;
            border-radius: var(--radius-sm);
            width: 300px;
            font-size: 14px;
        }

        .search-bar i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #777;
        }

        .welcome-message {
            font-weight: 600;
        }

        .header-right {
            display: flex;
            align-items: center;
        }

        .header-icon {
            margin-left: 20px;
            position: relative;
            cursor: pointer;
        }

        .notification-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: var(--primary);
            color: white;
            border-radius: 50%;
            width: 18px;
            height: 18px;
            font-size: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .profile-dropdown {
            position: relative;
            margin-left: 20px;
        }

        .profile-img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            cursor: pointer;
        }

        .dropdown-menu {
            position: absolute;
            top: 100%;
            right: 0;
            background: var(--card-bg);
            box-shadow: var(--shadow-md);
            border-radius: var(--radius-sm);
            width: 200px;
            display: none;
            z-index: 100;
        }

        .profile-dropdown:hover .dropdown-menu {
            display: block;
        }

        .dropdown-item {
            padding: 12px 20px;
            display: flex;
            align-items: center;
            color: var(--text-dark);
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .dropdown-item:hover {
            background: #f5f5f5;
        }

        .dropdown-item i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }

        /* Dashboard Cards */
        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .card {
            background: var(--card-bg);
            border-radius: var(--radius-md);
            padding: 20px;
            box-shadow: var(--shadow-sm);
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .card-title {
            font-weight: 600;
            font-size: 18px;
        }

        .card-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }

        .card-icon.primary {
            background: var(--primary);
        }

        .card-icon.secondary {
            background: var(--secondary);
        }

        .card-icon.accent {
            background: var(--accent);
        }

        .card-value {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .card-subtitle {
            color: #777;
            font-size: 14px;
        }

        /* Recent Bikes Table */
        .recent-bikes {
            background: var(--card-bg);
            border-radius: var(--radius-md);
            padding: 20px;
            box-shadow: var(--shadow-sm);
            margin-bottom: 30px;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
        }

        .table th, .table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        .table th {
            font-weight: 600;
            color: #777;
        }

        .table tr:last-child td {
            border-bottom: none;
        }

        .table tr:hover {
            background: #f9f9f9;
        }

        .status-badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .status-badge.success {
            background: #e6f7e6;
            color: #2e7d32;
        }

        .status-badge.warning {
            background: #fff3e0;
            color: #f57c00;
        }

        .status-badge.danger {
            background: #ffebee;
            color: #c62828;
        }

        /* Low Stock Alerts */
        .low-stock-alerts {
            background: var(--card-bg);
            border-radius: var(--radius-md);
            padding: 20px;
            box-shadow: var(--shadow-sm);
        }

        .alert-item {
            display: flex;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid #eee;
        }

        .alert-item:last-child {
            border-bottom: none;
        }

        .alert-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #ffebee;
            color: #c62828;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
        }

        .alert-content {
            flex: 1;
        }

        .alert-title {
            font-weight: 600;
            margin-bottom: 5px;
        }

        .alert-subtitle {
            color: #777;
            font-size: 14px;
        }

        .alert-action {
            margin-left: 15px;
        }

        .btn {
            padding: 8px 15px;
            border-radius: var(--radius-sm);
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            font-size: 14px;
        }

        .btn-primary {
            background: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background: var(--primary-dark);
        }

        .btn-secondary {
            background: var(--secondary);
            color: white;
        }

        .btn-secondary:hover {
            background: #333;
        }

        .btn-outline {
            background: transparent;
            border: 1px solid var(--primary);
            color: var(--primary);
        }

        .btn-outline:hover {
            background: var(--primary);
            color: white;
        }

        /* Responsive Styles */
        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
            }
            
            .sidebar.active {
                transform: translateX(0);
            }
            
            .main-content {
                margin-left: 0;
            }
            
            .search-bar input {
                width: 200px;
            }
        }

        @media (max-width: 768px) {
            .dashboard-cards {
                grid-template-columns: 1fr;
            }
            
            .header {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .header-left, .header-right {
                width: 100%;
                margin-bottom: 10px;
            }
            
            .search-bar {
                width: 100%;
                margin-right: 0;
                margin-bottom: 10px;
            }
            
            .search-bar input {
                width: 100%;
            }
        }

        /* Action Container */
        .action-container {
            margin-bottom: 20px;
            display: flex;
            justify-content: flex-end;
        }
        
        .action-container .btn {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 12px 20px;
            font-size: 16px;
        }
        
        .action-container .btn i {
            font-size: 18px;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <img src="../images/hidasalogo.png" alt="HIDASA Bikes Logo">
            <h3>Admin Panel</h3>
        </div>
        <div class="sidebar-menu">
            <a href="../AdminDashboardServlet" class="menu-item active">
                <i class="fas fa-home"></i> Dashboard Home
            </a>
            <a href="../AdminDashboardServlet?action=viewBikes" class="menu-item">
                <i class="fas fa-motorcycle"></i> Manage Bikes
            </a>
            <a href="addBike.jsp" class="menu-item">
                <i class="fas fa-plus-circle"></i> Add New Bike
            </a>
            <a href="#" class="menu-item">
                <i class="fas fa-box"></i> Inventory Overview
            </a>
            <a href="#" class="menu-item">
                <i class="fas fa-chart-bar"></i> Reports & Analytics
            </a>
            <a href="#" class="menu-item">
                <i class="fas fa-envelope"></i> Inquiries & Feedback
            </a>
            <a href="#" class="menu-item">
                <i class="fas fa-users"></i> Manage Users
            </a>
            <a href="#" class="menu-item">
                <i class="fas fa-cog"></i> Settings
            </a>
            <a href="../LogoutServlet" class="menu-item">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Header -->
        <div class="header">
            <div class="header-left">
                <div class="search-bar">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Search...">
                </div>
                <div class="welcome-message">
                    Hello, Admin!
                </div>
            </div>
            <div class="header-right">
                <div class="header-icon">
                    <i class="fas fa-clock"></i>
                    <span id="current-time"></span>
                </div>
                <div class="header-icon">
                    <i class="fas fa-bell"></i>
                    <span class="notification-badge">3</span>
                </div>
                <div class="profile-dropdown">
                    <img src="../images/userimg.png" alt="Admin Profile" class="profile-img">
                    <div class="dropdown-menu">
                        <a href="#" class="dropdown-item">
                            <i class="fas fa-user"></i> View Profile
                        </a>
                        <a href="#" class="dropdown-item">
                            <i class="fas fa-key"></i> Change Password
                        </a>
                        <a href="../LogoutServlet" class="dropdown-item">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Dashboard Content -->
        <div class="dashboard-cards">
            <div class="card">
                <div class="card-header">
                    <div class="card-title">Total Bikes</div>
                    <div class="card-icon primary">
                        <i class="fas fa-motorcycle"></i>
                    </div>
                </div>
                <div class="card-value">24</div>
                <div class="card-subtitle">Active inventory</div>
            </div>
            <div class="card">
                <div class="card-header">
                    <div class="card-title">Low Stock</div>
                    <div class="card-icon accent">
                        <i class="fas fa-exclamation-triangle"></i>
                    </div>
                </div>
                <div class="card-value">5</div>
                <div class="card-subtitle">Bikes with stock < 5</div>
            </div>
            <div class="card">
                <div class="card-header">
                    <div class="card-title">Total Sales</div>
                    <div class="card-icon secondary">
                        <i class="fas fa-chart-line"></i>
                    </div>
                </div>
                <div class="card-value">NPR 2.5M</div>
                <div class="card-subtitle">This month</div>
            </div>
        </div>

        <!-- Add New Bike Button -->
        <div class="action-container">
            <a href="../view/addBike.jsp" class="btn btn-primary">
                <i class="fas fa-plus"></i> Add New Bike
            </a>
        </div>

        <!-- Recent Bikes -->
        <div class="recent-bikes">
            <div class="card-header">
                <div class="card-title">Recent Bikes Added</div>
                <a href="../AdminDashboardServlet?action=viewBikes" class="btn btn-outline">View All</a>
            </div>
            <table class="table">
                <thead>
                    <tr>
                        <th>Bike ID</th>
                        <th>Brand</th>
                        <th>Model</th>
                        <th>Price</th>
                        <th>Stock</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="bike" items="${recentBikes}">
                        <tr>
                            <td>${bike.bikeId}</td>
                            <td>${bike.brandName}</td>
                            <td>${bike.modelName}</td>
                            <td>NPR ${bike.price}</td>
                            <td>${bike.stockQuantity}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${bike.stockQuantity > 10}">
                                        <span class="status-badge success">In Stock</span>
                                    </c:when>
                                    <c:when test="${bike.stockQuantity > 0}">
                                        <span class="status-badge warning">Low Stock</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge danger">Out of Stock</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="../AdminDashboardServlet?action=editBike&bikeId=${bike.bikeId}" class="btn btn-primary">Edit</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Low Stock Alerts -->
        <div class="low-stock-alerts">
            <div class="card-header">
                <div class="card-title">Low Stock Alerts</div>
                <a href="../AdminDashboardServlet?action=viewBikes" class="btn btn-outline">Manage Stock</a>
            </div>
            <c:forEach var="bike" items="${lowStockBikes}">
                <div class="alert-item">
                    <div class="alert-icon">
                        <i class="fas fa-exclamation-triangle"></i>
                    </div>
                    <div class="alert-content">
                        <div class="alert-title">${bike.brandName} ${bike.modelName}</div>
                        <div class="alert-subtitle">Only ${bike.stockQuantity} units remaining</div>
                    </div>
                    <div class="alert-action">
                        <a href="../AdminDashboardServlet?action=editBike&bikeId=${bike.bikeId}" class="btn btn-primary">Update</a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <script>
        // Update current time
        function updateTime() {
            const now = new Date();
            const timeString = now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
            document.getElementById('current-time').textContent = timeString;
        }
        
        // Update time every second
        updateTime();
        setInterval(updateTime, 1000);
    </script>
</body>
</html>