<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Sidebar</title>
    <link rel="stylesheet" href="../assets/css/adminStyle.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
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

    </style>
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-header">
            <img src="../assets/images/logo.png" alt="HiDASA Bikes Logo">
        </div>
        <ul class="sidebar-menu">
            <li><a href="dashboard.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
            <li><a href="orders.jsp"><i class="fas fa-shopping-cart"></i> Orders</a></li>
            <li><a href="sales"><i class="fas fa-chart-line"></i> Sales History</a></li>
            <li><a href="add-bike.jsp"><i class="fas fa-plus-circle"></i> Add New Bike</a></li>
            <li><a href="manage-bikes.jsp"><i class="fas fa-bicycle"></i> Manage Bikes</a></li>
            <li><a href="inventory" class="active"><i class="fas fa-box"></i> Inventory</a></li>
            <li><a href="messages"><i class="fas fa-envelope"></i> Messages</a></li>
        </ul>
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
        setActiveMenuItem();
    </script>
</body>
</html> 