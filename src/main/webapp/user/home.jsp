<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HIDASA Bikes - Experience the Power</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/home.css" rel="stylesheet">
    
    <style>
        /* Contact Section Styles */
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
            background: #FF0B55;
            margin: 0.5rem auto 0;
        }

        .contact-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .contact-card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
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
            color: #FF0B55;
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
            color: #FF0B55;
        }

        .contact-link {
            color: #FF0B55;
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
            border-radius: 5px;
            font-size: 1rem;
            transition: border 0.3s;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            border-color: #FF0B55;
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
            background: #FF0B55;
            color: white;
            border: none;
            padding: 1rem;
            font-weight: 600;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s;
            margin-top: auto;
        }

        .submit-btn:hover {
            background: #d4074a;
        }

        .terms-link {
            color: #FF0B55;
            text-decoration: none;
        }

        /* Alert Messages */
        .alert {
            padding: 12px 15px;
            margin-bottom: 1.5rem;
            border-radius: 5px;
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
            border-radius: 5px;
            font-size: 0.9rem;
        }

        /* Responsive Adjustments */
        @media (max-width: 768px) {
            .contact-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>
    <%@ include file="navigationBar.jsp" %>

    <!-- Hidden field to store login status -->
    <input type="hidden" id="userLoggedIn" value="${not empty sessionScope.userId}">

    <!-- Login Modal -->
    <div id="loginModal" class="modal" style="display: none; position: fixed; z-index: 999; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgba(0,0,0,0.4);">
        <div class="modal-content" style="background-color: #fff; margin: 15% auto; padding: 20px; border-radius: 10px; width: 400px; max-width: 90%; box-shadow: 0 5px 15px rgba(0,0,0,0.3); position: relative;">
            <span class="close-modal" style="position: absolute; top: 10px; right: 15px; font-size: 24px; cursor: pointer; color: #aaa;">&times;</span>
            <h2 style="margin-bottom: 20px; color: #333; text-align: center;">Login Required</h2>
            <p style="margin-bottom: 25px; text-align: center; color: #555;">Please login to continue with your purchase.</p>
            <div style="display: flex; justify-content: center; gap: 15px;">
                <a href="${pageContext.request.contextPath}/login" class="btn" style="background-color: #FF0B55; color: white; padding: 10px 20px; border-radius: 5px; text-decoration: none; display: inline-block; text-align: center; font-weight: 500;">Login</a>
                <button class="btn close-btn" style="background-color: #f1f1f1; color: #333; padding: 10px 20px; border-radius: 5px; border: none; cursor: pointer; font-weight: 500;">Cancel</button>
            </div>
        </div>
    </div>

    <!-- Error Message if any -->
    <c:if test="${not empty error}">
        <div class="error-container">
            <div class="error-message">
                <i class="fas fa-exclamation-triangle"></i>
                <p>${error}</p>
                <button class="close-error"><i class="fas fa-times"></i></button>
            </div>
        </div>
    </c:if>

    <!-- Hero Section with Slider -->
    <section class="hero-slider">
        <div class="swiper-container main-slider">
            <div class="swiper-wrapper">
                <!-- Slide 1 -->
                <div class="swiper-slide" style="background-image: url('${pageContext.request.contextPath}/assets/images/hidasa1.jpg');">
                    <div class="slide-overlay"></div>
                    <div class="slide-content">
                        <h1 class="slide-title">Unleash the Machine Within</h1>
                        <p class="slide-description">Experience the thrill of riding with our latest collection of premium bikes.</p>
                        <a href="#featured-bikes" class="button button-primary">Explore Models</a>
                    </div>
                </div>
                
                <!-- Slide 2 -->
                <div class="swiper-slide" style="background-image: url('${pageContext.request.contextPath}/assets/images/hidasa2.jpg');">
                    <div class="slide-overlay"></div>
                    <div class="slide-content">
                        <h1 class="slide-title">Power Meets Precision</h1>
                        <p class="slide-description">Discover bikes engineered for the perfect balance of performance and control.</p>
                        <a href="#featured-bikes" class="button button-primary">Explore Models</a>
                    </div>
                </div>
                
                <!-- Slide 3 -->
                <div class="swiper-slide" style="background-image: url('${pageContext.request.contextPath}/assets/images/hidasa3.jpg');">
                    <div class="slide-overlay"></div>
                    <div class="slide-content">
                        <h1 class="slide-title">Ride Beyond Limits</h1>
                        <p class="slide-description">Push boundaries with motorcycles designed for adventure and endurance.</p>
                        <a href="#featured-bikes" class="button button-primary">Explore Models</a>
                    </div>
                </div>
            </div>
            
            <!-- Navigation buttons -->
            <div class="swiper-button-next"></div>
            <div class="swiper-button-prev"></div>
            
            <!-- Pagination dots -->
            <div class="swiper-pagination"></div>
        </div>
    </section>

    <!-- Welcome Section -->
    <section class="welcome-section">
        <div class="container">
            <h2 class="section-title">Welcome to HIDASA Bikes</h2>
            <p class="section-subtitle">Your journey to the perfect ride begins here</p>
            <div class="welcome-grid">
                <div class="welcome-card">
                    <i class="fas fa-motorcycle"></i>
                    <h3>Premium Selection</h3>
                    <p>Choose from our curated collection of high-performance bikes</p>
                </div>
                <div class="welcome-card">
                    <i class="fas fa-tools"></i>
                    <h3>Expert Service</h3>
                    <p>Professional maintenance and support at your fingertips</p>
                </div>
                <div class="welcome-card">
                    <i class="fas fa-shield-alt"></i>
                    <h3>Warranty Protection</h3>
                    <p>Comprehensive coverage for your peace of mind</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Featured Bikes -->
    <section class="featured-bikes" id="featured-bikes">
        <div class="container">
            <h2 class="section-title">Featured Bikes</h2>
            <p class="section-subtitle">Discover our most popular models</p>
            <div class="bike-grid">
                <c:forEach var="bike" items="${featuredBikes}">
                    <div class="bike-card">
                        <c:choose>
                            <c:when test="${not empty bike.base64Image}">
                                <img src="data:image/jpeg;base64,${bike.base64Image}" alt="${bike.brandName} ${bike.modelName}" class="bike-image">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/assets/images/hidasa${(bike.bikeId % 3) + 1}.jpg" alt="${bike.brandName} ${bike.modelName}" class="bike-image">
                            </c:otherwise>
                        </c:choose>
                        <div class="bike-details">
                            <div class="bike-brand">${bike.brandName}</div>
                            <h3 class="bike-name">${bike.modelName}</h3>
                            <div class="bike-specs">
                                <c:if test="${not empty bike.engineCapacity}">
                                    <div class="spec-item">
                                        <i class="fas fa-tachometer-alt"></i>
                                        <span>${bike.engineCapacity}</span>
                                    </div>
                                </c:if>
                                <c:if test="${not empty bike.fuelType}">
                                    <div class="spec-item">
                                        <i class="fas fa-gas-pump"></i>
                                        <span>${bike.fuelType}</span>
                                    </div>
                                </c:if>
                                <c:if test="${not empty bike.mileage}">
                                    <div class="spec-item">
                                        <i class="fas fa-road"></i>
                                        <span>${bike.mileage}</span>
                                    </div>
                                </c:if>
                                <c:if test="${not empty bike.power}">
                                    <div class="spec-item">
                                        <i class="fas fa-bolt"></i>
                                        <span>${bike.power}</span>
                                    </div>
                                </c:if>
                            </div>
                            <div class="bike-price">Rs. ${bike.formattedPrice}</div>
                            <div class="bike-actions">
                                <a href="${pageContext.request.contextPath}/bike-details?id=${bike.bikeId}" class="button button-primary">View Details</a>
                                <a href="#" onclick="checkLoginBeforeBuy('${bike.bikeId}', event)" class="button button-primary">Buy Now</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                
                <!-- Fallback if no bikes are found -->
                <c:if test="${empty featuredBikes}">
                    <div class="bike-card">
                        <img src="${pageContext.request.contextPath}/assets/images/hidasa2.jpg" alt="Royal Enfield Classic 350" class="bike-image">
                        <div class="bike-details">
                            <div class="bike-brand">ROYAL ENFIELD</div>
                            <h3 class="bike-name">Classic 350</h3>
                            <div class="bike-specs">
                                <div class="spec-item">
                                    <i class="fas fa-tachometer-alt"></i>
                                    <span>349cc</span>
                                </div>
                                <div class="spec-item">
                                    <i class="fas fa-gas-pump"></i>
                                    <span>Petrol</span>
                                </div>
                                <div class="spec-item">
                                    <i class="fas fa-road"></i>
                                    <span>35 kmpl</span>
                                </div>
                                <div class="spec-item">
                                    <i class="fas fa-bolt"></i>
                                    <span>20.2 bhp @ 6100 rpm</span>
                                </div>
                            </div>
                            <div class="bike-price">Rs. 219,000.00</div>
                            <div class="bike-actions">
                                <a href="${pageContext.request.contextPath}/bike-details?id=${bike.bikeId}" class="button button-primary">View Details</a>
                                <a href="#" onclick="checkLoginBeforeBuy('${bike.bikeId}', event)" class="button button-primary">Buy Now</a>
                            </div>
                        </div>
                    </div>
                    
                    <div class="bike-card">
                        <img src="${pageContext.request.contextPath}/assets/images/hidasa1.jpg" alt="Yamaha FZ-S" class="bike-image">
                        <div class="bike-details">
                            <div class="bike-brand">YAMAHA</div>
                            <h3 class="bike-name">FZ-S</h3>
                            <div class="bike-specs">
                                <div class="spec-item">
                                    <i class="fas fa-tachometer-alt"></i>
                                    <span>149cc</span>
                                </div>
                                <div class="spec-item">
                                    <i class="fas fa-gas-pump"></i>
                                    <span>Petrol</span>
                                </div>
                                <div class="spec-item">
                                    <i class="fas fa-road"></i>
                                    <span>45 kmpl</span>
                                </div>
                                <div class="spec-item">
                                    <i class="fas fa-bolt"></i>
                                    <span>12.4 bhp @ 7250 rpm</span>
                                </div>
                            </div>
                            <div class="bike-price">Rs. 164,000.00</div>
                            <div class="bike-actions">
                                <a href="${pageContext.request.contextPath}/bike-details?id=${bike.bikeId}" class="button button-primary">View Details</a>
                                <a href="#" onclick="checkLoginBeforeBuy('${bike.bikeId}', event)" class="button button-primary">Buy Now</a>
                            </div>
                        </div>
                    </div>
                    
                    <div class="bike-card">
                        <img src="${pageContext.request.contextPath}/assets/images/hidasa3.jpg" alt="Bajaj Pulsar NS200" class="bike-image">
                        <div class="bike-details">
                            <div class="bike-brand">BAJAJ</div>
                            <h3 class="bike-name">Pulsar NS200</h3>
                            <div class="bike-specs">
                                <div class="spec-item">
                                    <i class="fas fa-tachometer-alt"></i>
                                    <span>199.5cc</span>
                                </div>
                                <div class="spec-item">
                                    <i class="fas fa-gas-pump"></i>
                                    <span>Petrol</span>
                                </div>
                                <div class="spec-item">
                                    <i class="fas fa-road"></i>
                                    <span>40 kmpl</span>
                                </div>
                                <div class="spec-item">
                                    <i class="fas fa-bolt"></i>
                                    <span>24.5 bhp @ 9750 rpm</span>
                                </div>
                            </div>
                            <div class="bike-price">Rs. 189,000.00</div>
                            <div class="bike-actions">
                                <a href="${pageContext.request.contextPath}/bike-details?id=${bike.bikeId}" class="button button-primary">View Details</a>
                                <a href="#" onclick="checkLoginBeforeBuy('${bike.bikeId}', event)" class="button button-primary">Buy Now</a>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </section>

    <!-- Choose Your Ride -->
    <section class="choose-ride">
        <div class="container">
            <h2 class="section-title">Choose Your Ride</h2>
            <p class="section-subtitle">Find the perfect bike for your journey</p>
            <div class="ride-categories">
                <c:if test="${not empty bikeTypes}">
                    <c:forEach var="type" items="${bikeTypes}" varStatus="status">
                        <a href="${pageContext.request.contextPath}/bikes?type=${type}" class="category-card">
                            <!-- Use different icons based on the status count for variety -->
                            <c:choose>
                                <c:when test="${status.index % 3 == 0}">
                                    <i class="fas fa-road"></i>
                                </c:when>
                                <c:when test="${status.index % 3 == 1}">
                                    <i class="fas fa-motorcycle"></i>
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-charging-station"></i>
                                </c:otherwise>
                            </c:choose>
                            <h3>${type}</h3>
                            <p>${bikeTypeCounts[type]} Bikes</p>
                        </a>
                    </c:forEach>
                </c:if>
                
                <!-- Fallback if no types are found -->
                <c:if test="${empty bikeTypes}">
                    <a href="${pageContext.request.contextPath}/bikes?type=Cruiser" class="category-card">
                        <i class="fas fa-road"></i>
                        <h3>Cruiser</h3>
                        <p>Laid-back Power</p>
                    </a>
                    <a href="${pageContext.request.contextPath}/bikes?type=Commuter" class="category-card">
                        <i class="fas fa-motorcycle"></i>
                        <h3>Commuter</h3>
                        <p>Smart, Efficient, Stylish</p>
                    </a>
                    <a href="${pageContext.request.contextPath}/bikes?type=Adventure" class="category-card">
                        <i class="fas fa-mountain"></i>
                        <h3>Adventure</h3>
                        <p>Conquer Any Terrain</p>
                    </a>
                    <a href="${pageContext.request.contextPath}/bikes?type=Sport" class="category-card">
                        <i class="fas fa-tachometer-alt"></i>
                        <h3>Sport</h3>
                        <p>Pure Performance</p>
                    </a>
                    <a href="${pageContext.request.contextPath}/bikes?type=Naked" class="category-card">
                        <i class="fas fa-bolt"></i>
                        <h3>Naked</h3>
                        <p>Raw Power & Style</p>
                    </a>
                    <a href="${pageContext.request.contextPath}/bikes?type=Electric" class="category-card">
                        <i class="fas fa-charging-station"></i>
                        <h3>Electric</h3>
                        <p>Clean, Quiet, Cool</p>
                    </a>
                </c:if>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats-section">
        <div class="container">
            <div class="stats-grid">
                <div class="stat-item">
                    <i class="fas fa-motorcycle"></i>
                    <div class="stat-value">${totalBikeCount > 0 ? totalBikeCount : '15,000+'}</div>
                    <div class="stat-label">Bikes Available</div>
                </div>
                <div class="stat-item">
                    <i class="fas fa-tags"></i>
                    <div class="stat-value">${bikeTypes.size() > 0 ? bikeTypes.size() : '10+'}</div>
                    <div class="stat-label">Categories</div>
                </div>
                <div class="stat-item">
                    <i class="fas fa-star"></i>
                    <div class="stat-value">98%</div>
                    <div class="stat-label">Customer Satisfaction</div>
                </div>
                <div class="stat-item">
                    <i class="fas fa-tools"></i>
                    <div class="stat-value">24/7</div>
                    <div class="stat-label">Service Coverage</div>
                </div>
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section class="about-section">
        <div class="container">
            <h2 class="section-title">About HIDASA Bikes</h2>
            <p class="section-subtitle">Our journey of innovation and excellence</p>
            <div class="about-content">
                <div class="about-image">
                    <img src="${pageContext.request.contextPath}/assets/images/hidasa3.jpg" alt="HIDASA Bikes Factory">
                </div>
                <div class="about-text">
                    <h3>Our Story</h3>
                    <p>Founded in 2005, HIDASA Bikes has grown from a small workshop to Nepal's leading motorcycle manufacturer. Our commitment to quality, innovation, and customer satisfaction has made us the trusted choice for riders across the country.</p>
                    <p>We believe in creating bikes that not only perform exceptionally but also reflect the spirit of adventure and freedom that riding represents.</p>
                    <a href="${pageContext.request.contextPath}/about" class="button button-primary">Learn More About Us</a>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section class="contact-section">
        <div class="container">
            <h2 class="section-title">Contact Us</h2>
            <p class="section-subtitle">We're here to help with any questions you may have</p>
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
      <%@ include file="footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
    <script>
        // Initialize AOS animations
        AOS.init({
            duration: 800,
            once: true
        });
        
        // Initialize Swiper slider
        const mainSlider = new Swiper('.main-slider', {
            // Optional parameters
            loop: true,
            speed: 800,
            autoplay: {
                delay: 5000,
                disableOnInteraction: false,
            },
            // If we need pagination
            pagination: {
                el: '.swiper-pagination',
                clickable: true
            },
            // Navigation arrows
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
            },
            effect: 'fade',
            fadeEffect: {
                crossFade: true
            }
        });
        
        // Handle error message dismissal
        document.addEventListener('DOMContentLoaded', function() {
            const closeErrorBtn = document.querySelector('.close-error');
            if (closeErrorBtn) {
                closeErrorBtn.addEventListener('click', function() {
                    const errorContainer = document.querySelector('.error-container');
                    if (errorContainer) {
                        errorContainer.style.display = 'none';
                    }
                });
            }
            
            // Function to get cookie value by name
            function getCookie(name) {
                const value = `; ${document.cookie}`;
                const parts = value.split(`; ${name}=`);
                if (parts.length === 2) {
                    const cookieValue = parts.pop().split(';').shift();
                    // Decode the URL-encoded cookie value
                    try {
                        return decodeURIComponent(cookieValue);
                    } catch (e) {
                        return cookieValue; // Return as-is if decoding fails
                    }
                }
                return null;
            }
            
            // Get user data from cookies for personalization
            const userName = getCookie('userName');
            
            // Personalize welcome message with user name if available
            if (userName) {
                const welcomeTitle = document.querySelector('.section-title');
                if (welcomeTitle && welcomeTitle.textContent.includes('Welcome to HIDASA Bikes')) {
                    welcomeTitle.textContent = `Welcome to HIDASA Bikes, ${userName}!`;
                }
            }

            // Close modal when clicking the X or Cancel button
            var closeButtons = document.querySelectorAll('.close-modal, .close-btn');
            closeButtons.forEach(function(button) {
                button.addEventListener('click', function() {
                    document.getElementById('loginModal').style.display = 'none';
                });
            });
            
            // Close modal when clicking outside modal content
            window.addEventListener('click', function(event) {
                var modal = document.getElementById('loginModal');
                if (event.target == modal) {
                    modal.style.display = 'none';
                }
            });
        });

        // Function to check login before buying
        function checkLoginBeforeBuy(bikeId, event) {
            // Get login status from hidden field
            var isUserLoggedIn = document.getElementById('userLoggedIn').value === 'true';
            
            if (!isUserLoggedIn) {
                // User is not logged in, show modal
                event.preventDefault();
                document.getElementById('loginModal').style.display = 'block';
            } else {
                // User is logged in, allow redirect to payment page
                window.location.href = "${pageContext.request.contextPath}/user/payment.jsp?bikeId=" + bikeId;
            }
        }
    </script>
</body>
</html>