<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HIDASA Bikes - Navigation</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
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
            --header-height: 70px;
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
        }

        /* Header Styles */
        .header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            height: var(--header-height);
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            z-index: 1000;
            box-shadow: var(--shadow-sm);
            transition: all 0.3s ease;
        }

        .header.scrolled {
            background: rgba(255, 255, 255, 0.98);
            box-shadow: var(--shadow-md);
        }

        .header-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 2rem;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .logo {
            height: 50px;
            display: flex;
            align-items: center;
        }

        .logo img {
            height: 100%;
            width: auto;
        }

        .nav-menu {
            display: flex;
            gap: 2rem;
            align-items: center;
        }

        .nav-link {
            color: var(--text-dark);
            text-decoration: none;
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: var(--radius-sm);
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            color: var(--primary);
            background: rgba(255, 11, 85, 0.1);
        }

        .nav-link.active {
            color: var(--primary);
            background: rgba(255, 11, 85, 0.1);
        }

        .auth-buttons {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: var(--radius-md);
            font-weight: 500;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .btn-primary {
            background: var(--gradient-primary);
            color: var(--text-light);
            border: none;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .btn-outline {
            border: 2px solid var(--primary);
            color: var(--primary);
            background: transparent;
        }

        .btn-outline:hover {
            background: rgba(255, 11, 85, 0.1);
            transform: translateY(-2px);
        }

        /* User Profile Menu Styles */
        .user-profile-menu {
            position: relative;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            padding: 5px 10px;
            border-radius: var(--radius-md);
            transition: all 0.3s ease;
        }

        .user-info:hover {
            background: rgba(0, 0, 0, 0.05);
        }

        .profile-image {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid var(--primary);
        }

        .profile-initial {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--primary);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            font-weight: 600;
        }

        .user-name {
            font-weight: 500;
            color: var(--text-dark);
        }

        .dropdown-menu {
            position: absolute;
            top: 100%;
            right: 0;
            width: 220px;
            background: white;
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-lg);
            padding: 8px 0;
            opacity: 0;
            visibility: hidden;
            transform: translateY(10px);
            transition: all 0.3s ease;
            z-index: 1000;
        }

        .user-profile-menu:hover .dropdown-menu {
            opacity: 1;
            visibility: visible;
            transform: translateY(0);
        }

        .dropdown-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 20px;
            color: var(--text-dark);
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .dropdown-item:hover {
            background: rgba(0, 0, 0, 0.05);
            color: var(--primary);
        }

        .dropdown-item i {
            font-size: 1.1rem;
            width: 20px;
            text-align: center;
        }

        .dropdown-divider {
            height: 1px;
            background: rgba(0, 0, 0, 0.1);
            margin: 8px 0;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-container">
            <a href="${pageContext.request.contextPath}/home" class="logo">
                <img src="${pageContext.request.contextPath}/assets/images/hidasalogo.png" alt="HIDASA Bikes">
            </a>
            <nav class="nav-menu">
                <c:set var="currentPage" value="${pageContext.request.servletPath}" />
                <a href="${pageContext.request.contextPath}/home" class="nav-link ${fn:contains(currentPage, 'home') ? 'active' : ''}">Home</a>
                <a href="${pageContext.request.contextPath}/bikes" class="nav-link ${fn:contains(currentPage, 'bikes') ? 'active' : ''}">Bikes</a>
                <a href="${pageContext.request.contextPath}/about" class="nav-link ${fn:contains(currentPage, 'about') ? 'active' : ''}">About</a>
                <a href="${pageContext.request.contextPath}/contact" class="nav-link ${fn:contains(currentPage, 'contact') ? 'active' : ''}">Contact</a>
            </nav>
            <div class="auth-buttons">
                <c:choose>
                    <c:when test="${not empty sessionScope.userId}">
                        <div class="user-profile-menu">
                            <div class="user-info">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.Profile_Image}">
                                        <img src="data:image/jpeg;base64,${sessionScope.Profile_Image}" alt="Profile" class="profile-image">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="profile-initial">${fn:substring(sessionScope.name, 0, 1)}</div>
                                    </c:otherwise>
                                </c:choose>
                                <span class="user-name">${sessionScope.name}</span>
                                <i class="fas fa-chevron-down"></i>
                            </div>
                            <div class="dropdown-menu">
                                <a href="${pageContext.request.contextPath}/profile" class="dropdown-item">
                                    <i class="fas fa-user"></i> My Profile
                                </a>
                                <a href="${pageContext.request.contextPath}/orders" class="dropdown-item">
                                    <i class="fas fa-shopping-bag"></i> My Orders
                                </a>
                                <a href="${pageContext.request.contextPath}/settings" class="dropdown-item">
                                    <i class="fas fa-cog"></i> Settings
                                </a>
                                <div class="dropdown-divider"></div>
                                <a href="${pageContext.request.contextPath}/logout" class="dropdown-item">
                                    <i class="fas fa-sign-out-alt"></i> Logout
                                </a>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-outline">Login</a>
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-primary">Register</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </header>
</body>
</html>