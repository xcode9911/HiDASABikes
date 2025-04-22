<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - HIDASA Bikes</title>
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
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 2rem;
        }

        /* Hero Section */
        .hero {
            height: 60vh;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            background-image: url('${pageContext.request.contextPath}/assets/images/hidasa1.jpg');
            background-size: cover;
            background-position: center;
            color: var(--text-light);
        }

        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(to top, rgba(0,0,0,0.7), rgba(0,0,0,0.4));
            z-index: 1;
        }

        .hero-content {
            max-width: 800px;
            padding: 2rem;
            z-index: 2;
        }

        .hero-title {
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }

        .hero-description {
            font-size: 1.2rem;
            max-width: 700px;
            margin: 0 auto 2rem;
        }

        .scroll-down {
            position: absolute;
            bottom: 2rem;
            left: 50%;
            transform: translateX(-50%);
            color: var(--text-light);
            font-size: 1.5rem;
            animation: bounce 2s infinite;
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(0) translateX(-50%);
            }
            40% {
                transform: translateY(-20px) translateX(-50%);
            }
            60% {
                transform: translateY(-10px) translateX(-50%);
            }
        }

        /* Contact Information Section */
        .contact-section {
            padding: 4rem 0;
        }

        .section-title {
            text-align: center;
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 3rem;
            position: relative;
        }

        .section-title::after {
            content: '';
            display: block;
            width: 80px;
            height: 4px;
            background: var(--primary);
            margin: 0.5rem auto 0;
        }

        .contact-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .contact-card {
            background: var(--card-bg);
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-md);
            padding: 2rem;
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .contact-card h3 {
            font-size: 1.5rem;
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .contact-icon {
            text-align: center;
            font-size: 3rem;
            color: var(--primary);
            margin-bottom: 1.5rem;
        }

        .contact-details {
            margin-bottom: 1.5rem;
        }

        .contact-details p {
            margin-bottom: 0.8rem;
            display: flex;
            align-items: center;
        }

        .contact-details i {
            width: 25px;
            margin-right: 10px;
            color: var(--primary);
        }

        .contact-link {
            color: var(--primary);
            text-decoration: none;
        }

        /* Contact Form */
        .contact-form {
            display: flex;
            flex-direction: column;
            flex: 1;
        }

        .form-group {
            margin-bottom: 1.2rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: var(--radius-sm);
            font-size: 1rem;
            transition: border 0.3s;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            border-color: var(--primary);
            outline: none;
        }

        .form-checkbox {
            display: flex;
            align-items: flex-start;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
        }

        .form-checkbox input {
            margin-right: 10px;
            margin-top: 4px;
        }

        .submit-btn {
            background: var(--primary);
            color: white;
            border: none;
            padding: 1rem;
            font-weight: 600;
            border-radius: var(--radius-sm);
            cursor: pointer;
            transition: background 0.3s;
            margin-top: auto;
        }

        .submit-btn:hover {
            background: var(--primary-dark);
        }

        .terms-link {
            color: var(--primary);
            text-decoration: none;
        }

        /* Alert Messages */
        .alert {
            padding: 12px 15px;
            margin-bottom: 1.5rem;
            border-radius: var(--radius-sm);
            display: flex;
            align-items: center;
            font-size: 0.9rem;
        }

        .alert i {
            margin-right: 10px;
            font-size: 1.1rem;
        }

        .alert-success {
            background-color: #e6f7e6;
            color: #2e7d32;
            border-left: 4px solid #2e7d32;
        }

        .alert-error {
            background-color: #ffebee;
            color: #c62828;
            border-left: 4px solid #c62828;
        }

        .info-message {
            background-color: #e3f2fd;
            color: #0d47a1;
            border-left: 4px solid #0d47a1;
            padding: 12px 15px;
            margin-bottom: 1.5rem;
            border-radius: var(--radius-sm);
            font-size: 0.9rem;
        }

        /* Responsive Adjustments */
        @media (max-width: 768px) {
            .hero-title {
                font-size: 2.5rem;
            }
            .contact-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <%@ include file="navigationBar.jsp" %>

    <!-- Hero Section -->
    <section class="hero">
        <div class="hero-content">
            <h1 class="hero-title">Let's Talk. We're Just a Message Away.</h1>
            <p class="hero-description">Whether it's a query, compliment, concern, or feedback – we value your voice.</p>
        </div>
        <div class="scroll-down">
            <i class="fas fa-chevron-down"></i>
        </div>
    </section>

    <!-- Contact Information Section -->
    <section class="contact-section">
        <div class="container">
            <h2 class="section-title">Contact Information</h2>

            <div class="contact-grid">
                <!-- Contact Form Card -->
                <div class="contact-card">
                    <h3>Send Us a Message</h3>
                    <form class="contact-form" action="${pageContext.request.contextPath}/contact" method="post">
                        <!-- Display success message if present -->
                        <c:if test="${param.success == 'true'}">
                            <div class="alert alert-success">
                                <i class="fas fa-check-circle"></i>
                                Thank you for your message! We'll get back to you soon.
                            </div>
                        </c:if>
                        
                        <!-- Display error message if present -->
                        <c:if test="${not empty requestScope.error}">
                            <div class="alert alert-error">
                                <i class="fas fa-exclamation-circle"></i>
                                ${requestScope.error}
                            </div>
                        </c:if>
                        
                        <!-- Show this message if user is logged in -->
                        <c:if test="${not empty sessionScope.userId}">
                            <div class="info-message">
                                <p>You are contacting us as ${sessionScope.name} (${sessionScope.email})</p>
                            </div>
                        </c:if>
                        
                        <!-- Email field only shown for users who are not logged in -->
                        <c:if test="${empty sessionScope.userId}">
                            <div class="form-group">
                                <label for="email">Your Email</label>
                                <input type="email" id="email" name="email" required 
                                       placeholder="Enter your email address for us to respond">
                            </div>
                        </c:if>
                        
                        <div class="form-group">
                            <label for="subject">Subject</label>
                            <input type="text" id="subject" name="subject" required>
                        </div>
                        <div class="form-group">
                            <label for="message">Message</label>
                            <textarea id="message" name="message" rows="6" required></textarea>
                        </div>
                        <div class="form-checkbox">
                            <input type="checkbox" id="terms" name="terms" required>
                            <label for="terms">I agree to the <a href="#" class="terms-link">Terms</a> and allow HIDASA to contact me.</label>
                        </div>
                        <button type="submit" class="submit-btn">Send Message</button>
                    </form>
                </div>

                <!-- Head Office Card -->
                <div class="contact-card">
                    <div class="contact-icon">
                        <i class="fas fa-building"></i>
                    </div>
                    <h3>Head Office</h3>
                    <div class="contact-details">
                        <p><i class="fas fa-map-marker-alt"></i> HIDASA Bikes Pvt. Ltd.</p>
                        <p>Ring Road, Kalanki,<br>Kathmandu, Nepal</p>
                        <p><i class="far fa-clock"></i> Open: Sun - Fri | 9:00 AM - 6:00 PM</p>
                        <p><i class="fas fa-phone"></i> <a href="tel:+9771555XXXX" class="contact-link">+977-1-555XXXX</a></p>
                        <p><i class="fas fa-envelope"></i> <a href="mailto:info@hidasabikes.com" class="contact-link">info@hidasabikes.com</a></p>
                    </div>
                </div>

                <!-- Customer Service Card -->
                <div class="contact-card">
                    <div class="contact-icon">
                        <i class="fas fa-headset"></i>
                    </div>
                    <h3>Customer Service</h3>
                    <div class="contact-details">
                        <p><i class="fas fa-phone"></i> Toll-Free: <a href="tel:1660-HIDASA-00" class="contact-link">1660-HIDASA-00</a></p>
                        <p><i class="fab fa-whatsapp"></i> WhatsApp: <a href="https://wa.me/977-98XXXXXXXX" class="contact-link">+977-98XXXXXXXX</a></p>
                        <p><i class="fas fa-cog"></i> Service: <a href="mailto:service@hidasabikes.com" class="contact-link">service@hidasabikes.com</a></p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <script>
        // Smooth scroll when clicking the scroll down arrow
        document.querySelector('.scroll-down').addEventListener('click', function() {
            document.querySelector('.contact-section').scrollIntoView({ 
                behavior: 'smooth' 
            });
        });
    </script>
</body>
</html>