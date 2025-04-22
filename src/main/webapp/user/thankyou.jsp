<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thank You - HIDASA Bikes</title>
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
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
        }

        /* Thank You Section */
        .thank-you-section {
            flex: 1;
            padding: 8rem 0 4rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .thank-you-card {
            background: var(--card-bg);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-lg);
            padding: 3rem;
            text-align: center;
            max-width: 800px;
            width: 100%;
            position: relative;
            overflow: hidden;
        }

        .thank-you-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 8px;
            background: var(--gradient-primary);
        }

        .thank-you-icon {
            width: 80px;
            height: 80px;
            background: var(--primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 2rem;
            color: white;
            font-size: 2.5rem;
            box-shadow: 0 0 0 10px rgba(255, 11, 85, 0.1);
        }

        .thank-you-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            color: var(--primary);
        }

        .thank-you-message {
            font-size: 1.2rem;
            color: #666;
            margin-bottom: 2rem;
        }

        .customer-name {
            font-weight: 600;
            color: var(--primary);
        }

        .next-steps {
            margin-top: 3rem;
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 1rem;
        }

        .btn {
            display: inline-block;
            padding: 1rem 2rem;
            border-radius: var(--radius-md);
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: var(--primary);
            color: var(--text-light);
        }

        .btn-primary:hover {
            background: var(--primary-dark);
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

        /* Confetti animation */
        .confetti {
            position: absolute;
            width: 10px;
            height: 10px;
            background-color: var(--primary);
            opacity: 0.7;
            top: -10px;
            animation: confetti 5s ease-in-out infinite;
        }

        @keyframes confetti {
            0% {
                transform: translateY(0) rotate(0deg);
                opacity: 0.7;
            }
            100% {
                transform: translateY(600px) rotate(360deg);
                opacity: 0;
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .thank-you-card {
                padding: 2rem;
            }
            
            .thank-you-title {
                font-size: 2rem;
            }
            
            .next-steps {
                flex-direction: column;
                width: 100%;
            }
            
            .btn {
                width: 100%;
                text-align: center;
            }
        }
    </style>
</head>
<body>
    <%@ include file="navigationBar.jsp" %>

    <!-- Thank You Section -->
    <section class="thank-you-section">
        <div class="container">
            <div class="thank-you-card">
                <!-- Confetti elements -->
                <div id="confetti-container"></div>
                
                <div class="thank-you-icon">
                    <i class="fas fa-check"></i>
                </div>
                
                <h1 class="thank-you-title">Thank You!</h1>
                
                <c:choose>
                    <c:when test="${formType == 'contact'}">
                        <p class="thank-you-message">
                            <span class="customer-name">${param.name}</span>, we've received your message and appreciate you reaching out to us.
                            Our team will review your inquiry and get back to you as soon as possible.
                        </p>
                        <p class="thank-you-detail">
                            We typically respond within 24-48 business hours.
                        </p>
                    </c:when>
                    <c:when test="${formType == 'order'}">
                        <p class="thank-you-message">
                            <span class="customer-name">${param.name}</span>, your order has been successfully placed!
                            We're processing it right now and will send you a confirmation email shortly.
                        </p>
                        <p class="thank-you-detail">
                            Your order reference number: <strong>${param.orderRef}</strong>
                        </p>
                    </c:when>
                    <c:otherwise>
                        <p class="thank-you-message">
                            <span class="customer-name">${param.name}</span>, your submission has been received.
                            Thank you for your interaction with HIDASA Bikes.
                        </p>
                    </c:otherwise>
                </c:choose>
                
                <div class="next-steps">
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-outline">
                        <i class="fas fa-home"></i> Back to Home
                    </a>
                    <a href="${pageContext.request.contextPath}/bikes" class="btn btn-primary">
                        <i class="fas fa-motorcycle"></i> Explore Bikes
                    </a>
                </div>
            </div>
        </div>
    </section>

    <script>
        // Create confetti animation
        document.addEventListener('DOMContentLoaded', function() {
            const confettiContainer = document.getElementById('confetti-container');
            const colors = ['#FF0B55', '#CF0F47', '#FFD700', '#1A1A1A'];
            
            // Create 50 confetti elements
            for (let i = 0; i < 50; i++) {
                const confetti = document.createElement('div');
                confetti.className = 'confetti';
                confetti.style.left = Math.random() * 100 + '%';
                confetti.style.width = Math.random() * 8 + 5 + 'px';
                confetti.style.height = confetti.style.width;
                confetti.style.backgroundColor = colors[Math.floor(Math.random() * colors.length)];
                confetti.style.animationDelay = Math.random() * 5 + 's';
                confetti.style.animationDuration = Math.random() * 3 + 3 + 's';
                
                confettiContainer.appendChild(confetti);
            }
        });
    </script>
</body>
</html>