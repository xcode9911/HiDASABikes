<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Sidebar</title>
    <link rel="stylesheet" href="../assets/css/adminStyle.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Loading Overlay */
        .page-transition-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: transparent;
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            opacity: 0;
            visibility: hidden;
            transition: opacity 0.3s ease, visibility 0.3s ease;
        }

        .page-transition-overlay.active {
            opacity: 1;
            visibility: visible;
        }



        @keyframes rotation {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Page Transition */
        .page-content {
            opacity: 1;
            transition: opacity 0.1s ease;
        }

        .page-content.fade-out {
            opacity: 0;
        }

        /* Additional CSS for sidebar */
        .sidebar {
            width: 250px;
            background-color: var(--secondary-color);
            padding: 20px;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            position: fixed;
            height: 100vh;
            color: white;
            border-top-right-radius: 20px;
            border-bottom-right-radius: 20px;
            z-index: 1000;
        }

        .sidebar-header img {
            width: 100%;
            height: auto;
            display: block;
            object-fit: cover;
            margin: 15px 0 30px 0;
            border: none;
        }

        .sidebar-menu {
            list-style: none;
            margin-bottom: 20px;
        }

        .sidebar-menu li {
            margin-bottom: 10px;
        }

        .sidebar-menu a {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            color: black;
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .sidebar-menu a i {
            margin-right: 10px;
            font-size: 1.1rem;
        }

        .sidebar-menu a.active {
            background-color: var(--highlight-color);
            color: var(--accent-color);
            transform: translateX(5px);
        }

        .sidebar-menu a:hover {
            background-color: var(--highlight-color);
            color: var(--accent-color);
            transform: translateX(5px);
        }

        .logout-link {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            color: #dc3545;
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.3s ease;
            margin-top: auto;
            border-top: 1px solid rgba(0, 0, 0, 0.1);
        }

        .logout-link i {
            margin-right: 10px;
            font-size: 1.1rem;
        }

        .logout-link:hover {
            background-color: #dc3545;
            color: white;
            transform: translateX(5px);
        }
    </style>
</head>
<body>
    <!-- Loading Overlay -->
    <div class="page-transition-overlay">
        <div class="loader"></div>
    </div>

    <div class="sidebar">
        <div class="sidebar-header">
            <img src="../assets/images/logo.png" alt="HiDASA Bikes Logo">
        </div>
        <ul class="sidebar-menu">
            <li><a href="dashboard.jsp" data-page="dashboard"><i class="fas fa-home"></i> Dashboard</a></li>
            <li><a href="orders.jsp" data-page="orders"><i class="fas fa-shopping-cart"></i> Orders</a></li>
            <li><a href="sales" data-page="sales"><i class="fas fa-chart-line"></i> Sales History</a></li>
            <li><a href="add-bike.jsp" data-page="add-bike"><i class="fas fa-plus-circle"></i> Add New Bike</a></li>
            <li><a href="manage-bikes.jsp" data-page="manage-bikes"><i class="fas fa-bicycle"></i> Manage Bikes</a></li>
            <li><a href="inventory" data-page="inventory"><i class="fas fa-box"></i> Inventory</a></li>
            <li><a href="messages" data-page="messages"><i class="fas fa-envelope"></i> Messages</a></li>
        </ul>
        <a href="${pageContext.request.contextPath}/logout" class="logout-link">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>

    <script>
        // JavaScript function to highlight the active menu item
        function setActiveMenuItem() {
            const currentPage = window.location.pathname.split('/').pop();
            const menuItems = document.querySelectorAll('.sidebar-menu a');
            menuItems.forEach(item => {
                if (item.getAttribute('href') === currentPage) {
                    item.classList.add('active');
                } else {
                    item.classList.remove('active');
                }
            });
        }

        // Page transition handling
        document.addEventListener('DOMContentLoaded', function() {
            const overlay = document.querySelector('.page-transition-overlay');
            const menuLinks = document.querySelectorAll('.sidebar-menu a');
            
            menuLinks.forEach(link => {
                link.addEventListener('click', function(e) {
                    e.preventDefault();
                    const href = this.getAttribute('href');
                    
                    // Show loading overlay
                    overlay.classList.add('active');
                    
                    // Add fade-out effect to current page
                    document.body.classList.add('fade-out');
                    
                    // Navigate to new page after a short delay
                    setTimeout(() => {
                        window.location.href = href;
                    }, 300);
                });
            });
        });

        // Handle page load
        window.addEventListener('load', function() {
            const overlay = document.querySelector('.page-transition-overlay');
            overlay.classList.remove('active');
            document.body.classList.remove('fade-out');
        });

        setActiveMenuItem();
    </script>
</body>
</html> 