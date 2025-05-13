<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HIDASA Bikes - Add New Bike</title>
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
            --success: #4CAF50;
            --error: #F44336;
            --warning: #FF9800;
            --info: #2196F3;
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

        /* Form Styles */
        .form-container {
            background: var(--card-bg);
            border-radius: var(--radius-md);
            padding: 30px;
            box-shadow: var(--shadow-sm);
            margin-bottom: 30px;
        }

        .form-title {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 30px;
            color: var(--secondary);
            border-bottom: 2px solid var(--primary);
            padding-bottom: 10px;
        }

        .form-section {
            margin-bottom: 30px;
        }

        .section-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 20px;
            color: var(--secondary);
        }

        .form-row {
            display: flex;
            flex-wrap: wrap;
            margin: 0 -15px 20px;
        }

        .form-group {
            flex: 1;
            min-width: 250px;
            padding: 0 15px;
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .form-control {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: var(--radius-sm);
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--primary);
            outline: none;
            box-shadow: 0 0 0 3px rgba(255, 11, 85, 0.1);
        }

        .form-text {
            font-size: 12px;
            color: #777;
            margin-top: 5px;
        }

        .form-help {
            display: inline-block;
            width: 16px;
            height: 16px;
            line-height: 16px;
            text-align: center;
            background: #f0f0f0;
            border-radius: 50%;
            color: #777;
            font-size: 12px;
            margin-left: 5px;
            cursor: help;
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            margin-top: 30px;
        }

        .btn {
            padding: 10px 20px;
            border-radius: var(--radius-sm);
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            font-size: 14px;
            margin-left: 10px;
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

        .image-preview {
            width: 200px;
            height: 150px;
            border: 2px dashed #ddd;
            border-radius: var(--radius-sm);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-top: 10px;
            overflow: hidden;
        }

        .image-preview img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
        }

        .image-preview-placeholder {
            color: #777;
            font-size: 14px;
            text-align: center;
        }

        .image-preview-placeholder i {
            font-size: 24px;
            margin-bottom: 10px;
            color: #ddd;
        }

        /* Tabs */
        .tabs {
            display: flex;
            border-bottom: 1px solid #ddd;
            margin-bottom: 20px;
        }

        .tab {
            padding: 10px 20px;
            cursor: pointer;
            border-bottom: 2px solid transparent;
            transition: all 0.3s ease;
        }

        .tab.active {
            border-bottom-color: var(--primary);
            color: var(--primary);
            font-weight: 600;
        }

        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
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
            .form-row {
                flex-direction: column;
            }
            
            .form-group {
                width: 100%;
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

        /* Alert Message Styles */
        .alert {
            padding: 15px 20px;
            border-radius: var(--radius-md);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            animation: fadeIn 0.3s ease-out;
            position: relative;
        }

        .alert-success {
            background-color: rgba(76, 175, 80, 0.1);
            border-left: 4px solid var(--success);
            color: var(--success);
        }

        .alert-error {
            background-color: rgba(244, 67, 54, 0.1);
            border-left: 4px solid var(--error);
            color: var(--error);
        }

        .alert-warning {
            background-color: rgba(255, 152, 0, 0.1);
            border-left: 4px solid var(--warning);
            color: var(--warning);
        }

        .alert-info {
            background-color: rgba(33, 150, 243, 0.1);
            border-left: 4px solid var(--info);
            color: var(--info);
        }

        .alert-icon {
            margin-right: 15px;
            font-size: 20px;
        }

        .alert-content {
            flex: 1;
        }

        .alert-title {
            font-weight: 600;
            margin-bottom: 5px;
        }

        .alert-close {
            cursor: pointer;
            font-size: 18px;
            opacity: 0.7;
        }

        .alert-close:hover {
            opacity: 1;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeOut {
            from {
                opacity: 1;
                transform: translateY(0);
            }
            to {
                opacity: 0;
                transform: translateY(-10px);
            }
        }

        .fadeOut {
            animation: fadeOut 0.3s ease-out forwards;
        }
    </style>
</head>
<body>
    <jsp:include page="adminsidebar.jsp" />

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

        <!-- Message Display Section -->
        <c:if test="${not empty param.message}">
            <c:choose>
                <c:when test="${param.message eq 'addSuccess'}">
                    <div class="alert alert-success" id="successAlert">
                        <div class="alert-icon">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div class="alert-content">
                            <div class="alert-title">Success!</div>
                            <div class="alert-text">The bike has been added successfully to the inventory.</div>
                        </div>
                        <div class="alert-close" onclick="closeAlert('successAlert')">
                            <i class="fas fa-times"></i>
                        </div>
                    </div>
                </c:when>
                <c:when test="${param.message eq 'addFailed'}">
                    <div class="alert alert-error" id="errorAlert">
                        <div class="alert-icon">
                            <i class="fas fa-exclamation-circle"></i>
                        </div>
                        <div class="alert-content">
                            <div class="alert-title">Error!</div>
                            <div class="alert-text">Failed to add the bike. Please try again.</div>
                        </div>
                        <div class="alert-close" onclick="closeAlert('errorAlert')">
                            <i class="fas fa-times"></i>
                        </div>
                    </div>
                </c:when>
                <c:when test="${param.message eq 'imageTooLarge'}">
                    <div class="alert alert-warning" id="warningAlert">
                        <div class="alert-icon">
                            <i class="fas fa-exclamation-triangle"></i>
                        </div>
                        <div class="alert-content">
                            <div class="alert-title">Warning!</div>
                            <div class="alert-text">The uploaded image was too large. Please use an image smaller than 50MB.</div>
                        </div>
                        <div class="alert-close" onclick="closeAlert('warningAlert')">
                            <i class="fas fa-times"></i>
                        </div>
                    </div>
                </c:when>
            </c:choose>
        </c:if>

        <!-- Form Container -->
        <div class="form-container">
            <h1 class="form-title">Add New Bike to Showroom Inventory</h1>
            
            <form action="../AdminDashboardServlet" method="post" enctype="multipart/form-data" id="addBikeForm">
                <input type="hidden" name="action" value="addBike">
                
                <!-- Tabs -->
                <div class="tabs">
                    <div class="tab active" data-tab="basic">Basic Info</div>
                    <div class="tab" data-tab="performance">Performance</div>
                    <div class="tab" data-tab="hardware">Hardware & Dimensions</div>
                    <div class="tab" data-tab="other">Other Details</div>
                </div>
                
                <!-- Basic Info Tab -->
                <div class="tab-content active" id="basic-tab">
                    <div class="form-section">
                        <h2 class="section-title">Basic Bike Information</h2>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="brandName" class="form-label">Brand Name <span class="form-help" title="Enter the manufacturer's name">?</span></label>
                                <input type="text" id="brandName" name="brandName" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="modelName" class="form-label">Model Name <span class="form-help" title="Enter the specific model name">?</span></label>
                                <input type="text" id="modelName" name="modelName" class="form-control" required>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="type" class="form-label">Type <span class="form-help" title="Select the bike category">?</span></label>
                                <select id="type" name="type" class="form-control" required>
                                    <option value="">Select Type</option>
                                    <option value="Cruiser">Cruiser</option>
                                    <option value="Sports">Sports</option>
                                    <option value="Adventure">Adventure</option>
                                    <option value="Naked">Naked</option>
                                    <option value="Scooter">Scooter</option>
                                    <option value="Electric">Electric</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="price" class="form-label">Price (NPR) <span class="form-help" title="Enter the price in Nepalese Rupees">?</span></label>
                                <input type="number" id="price" name="price" class="form-control" min="0" step="0.01" required>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Performance Tab -->
                <div class="tab-content" id="performance-tab">
                    <div class="form-section">
                        <h2 class="section-title">Performance Specifications</h2>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="engineCapacity" class="form-label">Engine Capacity <span class="form-help" title="Enter the engine displacement (e.g., 155cc)">?</span></label>
                                <input type="text" id="engineCapacity" name="engineCapacity" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="fuelType" class="form-label">Fuel Type <span class="form-help" title="Select the type of fuel used">?</span></label>
                                <select id="fuelType" name="fuelType" class="form-control" required>
                                    <option value="">Select Fuel Type</option>
                                    <option value="Petrol">Petrol</option>
                                    <option value="Electric">Electric</option>
                                    <option value="Hybrid">Hybrid</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="transmission" class="form-label">Transmission <span class="form-help" title="Select the transmission type">?</span></label>
                                <select id="transmission" name="transmission" class="form-control" required>
                                    <option value="">Select Transmission</option>
                                    <option value="Manual">Manual</option>
                                    <option value="Automatic">Automatic</option>
                                    <option value="Semi-Automatic">Semi-Automatic</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="mileage" class="form-label">Mileage <span class="form-help" title="Enter the fuel efficiency (km/l or km/charge)">?</span></label>
                                <input type="text" id="mileage" name="mileage" class="form-control" required>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="power" class="form-label">Power <span class="form-help" title="Enter the power output (e.g., 15 HP)">?</span></label>
                                <input type="text" id="power" name="power" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="torque" class="form-label">Torque <span class="form-help" title="Enter the torque output (e.g., 14 Nm)">?</span></label>
                                <input type="text" id="torque" name="torque" class="form-control" required>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="coolingSystem" class="form-label">Cooling System <span class="form-help" title="Select the cooling system type">?</span></label>
                                <select id="coolingSystem" name="coolingSystem" class="form-control" required>
                                    <option value="">Select Cooling System</option>
                                    <option value="Air">Air</option>
                                    <option value="Liquid">Liquid</option>
                                    <option value="Oil">Oil</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Hardware & Dimensions Tab -->
                <div class="tab-content" id="hardware-tab">
                    <div class="form-section">
                        <h2 class="section-title">Hardware & Dimensions</h2>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="brakeType" class="form-label">Brake Type <span class="form-help" title="Select the brake system">?</span></label>
                                <select id="brakeType" name="brakeType" class="form-control" required>
                                    <option value="">Select Brake Type</option>
                                    <option value="Disc">Disc</option>
                                    <option value="Drum">Drum</option>
                                    <option value="ABS">ABS</option>
                                    <option value="CBS">CBS</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="suspensionType" class="form-label">Suspension Type <span class="form-help" title="Select the suspension system">?</span></label>
                                <select id="suspensionType" name="suspensionType" class="form-control" required>
                                    <option value="">Select Suspension Type</option>
                                    <option value="Telescopic">Telescopic</option>
                                    <option value="Monoshock">Monoshock</option>
                                    <option value="Dual Shock">Dual Shock</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="kerbWeight" class="form-label">Kerb Weight (kg) <span class="form-help" title="Enter the weight of the bike with fluids">?</span></label>
                                <input type="text" id="kerbWeight" name="kerbWeight" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="seatHeight" class="form-label">Seat Height (mm) <span class="form-help" title="Enter the seat height in millimeters">?</span></label>
                                <input type="text" id="seatHeight" name="seatHeight" class="form-control" required>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="fuelTankCapacity" class="form-label">Fuel Tank Capacity (L) <span class="form-help" title="Enter the fuel tank capacity in liters">?</span></label>
                                <input type="text" id="fuelTankCapacity" name="fuelTankCapacity" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="topSpeed" class="form-label">Top Speed (km/h) <span class="form-help" title="Enter the maximum speed in kilometers per hour">?</span></label>
                                <input type="text" id="topSpeed" name="topSpeed" class="form-control" required>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Other Details Tab -->
                <div class="tab-content" id="other-tab">
                    <div class="form-section">
                        <h2 class="section-title">Other Details</h2>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="warrantyInfo" class="form-label">Warranty Info <span class="form-help" title="Enter the warranty details (e.g., 3 Years / 30,000km)">?</span></label>
                                <input type="text" id="warrantyInfo" name="warrantyInfo" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label for="stockQuantity" class="form-label">Stock Quantity <span class="form-help" title="Enter the number of units in stock">?</span></label>
                                <input type="number" id="stockQuantity" name="stockQuantity" class="form-control" min="0" step="1" required>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="color" class="form-label">Color <span class="form-help" title="Enter the available colors">?</span></label>
                                <input type="text" id="color" name="color" class="form-control" required>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="description" class="form-label">Description <span class="form-help" title="Enter a detailed description of the bike">?</span></label>
                                <textarea id="description" name="description" class="form-control" rows="5" required></textarea>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label for="bikeImage" class="form-label">Bike Image <span class="form-help" title="Upload a small image of the bike (max 50MB)">?</span></label>
                                <input type="file" id="bikeImage" name="bikeImage" class="form-control" accept="image/png, image/jpeg, image/jpg">
                                <small class="form-text">Please use images less than 50MB to avoid database errors.</small>
                                <div class="image-preview" id="imagePreview">
                                    <div class="image-preview-placeholder">
                                        <i class="fas fa-image"></i>
                                        <p>Image preview will appear here</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Form Actions -->
                <div class="form-actions">
                    <button type="reset" class="btn btn-outline">Reset</button>
                    <button type="submit" class="btn btn-primary">Save Bike</button>
                </div>
            </form>
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
        
        // Tab functionality
        document.addEventListener('DOMContentLoaded', function() {
            const tabs = document.querySelectorAll('.tab');
            const tabContents = document.querySelectorAll('.tab-content');
            
            tabs.forEach(tab => {
                tab.addEventListener('click', function() {
                    // Remove active class from all tabs and contents
                    tabs.forEach(t => t.classList.remove('active'));
                    tabContents.forEach(c => c.classList.remove('active'));
                    
                    // Add active class to clicked tab and corresponding content
                    this.classList.add('active');
                    const tabId = this.getAttribute('data-tab');
                    document.getElementById(tabId + '-tab').classList.add('active');
                });
            });
        });
        
        // Image preview
        document.getElementById('bikeImage').addEventListener('change', function() {
            const file = this.files[0];
            if (file) {
                // Check file size
                if (file.size > 50 * 1024 * 1024) { // 50MB limit
                    alert('Error: Image is too large! Please select an image less than 50MB.');
                    this.value = ''; // Clear the file input
                    document.getElementById('imagePreview').innerHTML = `
                        <div class="image-preview-placeholder">
                            <i class="fas fa-image"></i>
                            <p>Image preview will appear here</p>
                        </div>`;
                    return;
                }
                
                const reader = new FileReader();
                reader.onload = function(e) {
                    const preview = document.getElementById('imagePreview');
                    preview.innerHTML = `<img src="${e.target.result}" alt="Bike Preview">`;
                }
                reader.readAsDataURL(file);
            }
        });
        
        // Form validation
        document.getElementById('addBikeForm').addEventListener('submit', function(e) {
            // Validate image size once more
            const fileInput = document.getElementById('bikeImage');
            if (fileInput.files.length > 0) {
                const file = fileInput.files[0];
                if (file.size > 50 * 1024 * 1024) { // 50MB limit
                    e.preventDefault();
                    alert('Error: Image is too large! Please select an image less than 50MB.');
                    return false;
                }
            }
            return true;
        });
        
        // Close alert function
        function closeAlert(alertId) {
            const alert = document.getElementById(alertId);
            alert.classList.add('fadeOut');
            setTimeout(() => {
                alert.style.display = 'none';
            }, 300);
        }
        
        // Auto close alerts after 5 seconds
        document.addEventListener('DOMContentLoaded', function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                setTimeout(() => {
                    alert.classList.add('fadeOut');
                    setTimeout(() => {
                        alert.style.display = 'none';
                    }, 300);
                }, 5000);
            });
        });
    </script>
</body>
</html> 