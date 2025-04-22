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

      
</head>
<body>
    <%@ include file="navigationBar.jsp" %>

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
                        <a href="#featured-bikes" class="btn btn-primary">Explore Models</a>
                    </div>
                </div>
                
                <!-- Slide 2 -->
                <div class="swiper-slide" style="background-image: url('${pageContext.request.contextPath}/assets/images/hidasa2.jpg');">
                    <div class="slide-overlay"></div>
                    <div class="slide-content">
                        <h1 class="slide-title">Power Meets Precision</h1>
                        <p class="slide-description">Discover bikes engineered for the perfect balance of performance and control.</p>
                        <a href="#featured-bikes" class="btn btn-primary">Explore Models</a>
                    </div>
                </div>
                
                <!-- Slide 3 -->
                <div class="swiper-slide" style="background-image: url('${pageContext.request.contextPath}/assets/images/hidasa3.jpg');">
                    <div class="slide-overlay"></div>
                    <div class="slide-content">
                        <h1 class="slide-title">Ride Beyond Limits</h1>
                        <p class="slide-description">Push boundaries with motorcycles designed for adventure and endurance.</p>
                        <a href="#featured-bikes" class="btn btn-primary">Explore Models</a>
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
                            <a href="#" class="btn btn-primary">View Details</a>
                            <a href="#" class="btn btn-primary">Buy Now</a>
                        </div>
                    </div>
                </div>
                <!-- Add more bike cards as needed -->
            </div>
        </div>
    </section>

    <!-- Choose Your Ride -->
    <section class="choose-ride">
        <div class="container">
            <h2 class="section-title">Choose Your Ride</h2>
            <p class="section-subtitle">Find the perfect bike for your journey</p>
            <div class="ride-categories">
                <div class="category-card">
                    <i class="fas fa-road"></i>
                    <h3>Cruiser</h3>
                    <p>Laid-back Power</p>
                </div>
                <div class="category-card">
                    <i class="fas fa-motorcycle"></i>
                    <h3>Commuter</h3>
                    <p>Smart, Efficient, Stylish</p>
                </div>
                <div class="category-card">
                    <i class="fas fa-charging-station"></i>
                    <h3>Electric</h3>
                    <p>Clean, Quiet, Cool</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats-section">
        <div class="container">
            <div class="stats-grid">
                <div class="stat-item">
                    <i class="fas fa-motorcycle"></i>
                    <div class="stat-value">15,000+</div>
                    <div class="stat-label">Bikes Sold</div>
                </div>
                <div class="stat-item">
                    <i class="fas fa-map-marker-alt"></i>
                    <div class="stat-value">75+</div>
                    <div class="stat-label">Districts</div>
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
                    <a href="#" class="btn btn-primary">Learn More About Us</a>
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
                <div class="contact-info">
                    <h3>Visit Us</h3>
                    <p>Ring Road, Kalanki, Kathmandu, Nepal</p>
                    <p>Open: Sun – Fri | 9:00 AM – 6:00 PM</p>
                    <h3>Call Us</h3>
                    <p>Toll-Free: 1660-HIDASA-00</p>
                    <p>WhatsApp: +977-98XXXXXXXX</p>
                    <h3>Email Us</h3>
                    <p>info@hidasabikes.com</p>
                    <p>support@hidasabikes.com</p>
                </div>
                <div class="contact-form">
                    <h3>Send Us a Message</h3>
                    <form>
                        <div class="form-group">
                            <input type="text" placeholder="Your Name" required>
                        </div>
                        <div class="form-group">
                            <input type="email" placeholder="Your Email" required>
                        </div>
                        <div class="form-group">
                            <textarea placeholder="Your Message" rows="5" required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Send Message</button>
                    </form>
                </div>
            </div>
        </div>
    </section>

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
        
        // Handle cookies and personalization
        document.addEventListener('DOMContentLoaded', function() {
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
        });
    </script>
</body>
</html>