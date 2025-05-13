<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HIDASA Bikes - Logout</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">
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

        .header-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 2rem;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

       .mylogo {
            height: 50px;
            display: flex;
            align-items: center;
        }

        .mylogo img {
            height: 100%;
            width: auto;
        }

        /* Logout Container */
        .logout-container {
            max-width: 600px;
            margin: 150px auto;
            padding: 3rem;
            background: var(--card-bg);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-lg);
            text-align: center;
            animation: fadeIn 0.8s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .logout-icon {
            font-size: 4rem;
            color: var(--primary);
            margin-bottom: 1.5rem;
        }

        .logout-title {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 1rem;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .logout-message {
            font-size: 1.1rem;
            color: #666;
            margin-bottom: 2rem;
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
            cursor: pointer;
            border: none;
        }

        .btn-primary {
            background: var(--gradient-primary);
            color: var(--text-light);
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

        .button-group {
            display: flex;
            gap: 1rem;
            justify-content: center;
        }

        /* Footer */
        .footer {
            background: var(--secondary);
            color: var(--text-light);
            padding: 3rem 0;
            margin-top: 4rem;
        }

        .footer-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 2rem;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
        }

        .footer-logo {
            height: 40px;
            margin-bottom: 1rem;
        }

        .footer-text {
            margin-bottom: 1.5rem;
            opacity: 0.8;
        }

        .footer-links {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .footer-link {
            color: var(--text-light);
            text-decoration: none;
            opacity: 0.8;
            transition: all 0.3s ease;
        }

        .footer-link:hover {
            opacity: 1;
            color: var(--primary);
        }

        .footer-bottom {
            text-align: center;
            padding-top: 2rem;
            margin-top: 2rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            opacity: 0.7;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-container">
            <div class="logo">
                <a href="home.jsp">
                   <img src="${pageContext.request.contextPath}/images/hidasalogo.png" alt="HIDASA Bikes" class="mylogo">
                </a>
            </div>
        </div>
    </header>

    <!-- Logout Container -->
    <div class="logout-container">
        <div class="logout-icon">
            <i class="fas fa-sign-out-alt"></i>
        </div>
        <h1 class="logout-title">You've Been Logged Out</h1>
        <p class="logout-message">Thank you for using HIDASA Bikes. You have been successfully logged out of your account.</p>
        <div class="button-group">
            <a href="home.jsp" class="btn btn-primary">
                <i class="fas fa-home"></i> Return to Home
            </a>
            <a href="login.jsp" class="btn btn-outline">
                <i class="fas fa-sign-in-alt"></i> Log In Again
            </a>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-container">
            <div class="footer-about">
                <img src="${pageContext.request.contextPath}/images/hidasalogo.png" alt="HIDASA Bikes" class="footer-logo">
                <p class="footer-text">Experience the power and elegance of HIDASA Bikes. Premium motorcycles for the discerning rider.</p>
            </div>
            <div class="footer-links">
                <h3>Quick Links</h3>
                <a href="home.jsp" class="footer-link">Home</a>
                <a href="#" class="footer-link">About Us</a>
                <a href="#" class="footer-link">Contact</a>
                <a href="#" class="footer-link">Privacy Policy</a>
            </div>
            <div class="footer-contact">
                <h3>Contact Us</h3>
                <p class="footer-text">123 Bike Street, Motor City, MC 12345</p>
                <p class="footer-text">Phone: (123) 456-7890</p>
                <p class="footer-text">Email: info@hidasabikes.com</p>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2023 HIDASA Bikes. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
    <script>
        // Initialize AOS
        AOS.init({
            duration: 800,
            easing: 'ease-in-out',
            once: true
        });
    </script>
</body>
</html>