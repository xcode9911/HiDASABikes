<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    
<footer class="site-footer">
    <div class="footer-top">
        <div class="container">
            <div class="footer-grid">
                <!-- Company Info -->
                <div class="footer-column">
                    <div class="footer-logo">
                        <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="HIDASA Bikes Logo">
                        <h3>HIDASA Bikes</h3>
                    </div>
                    <p class="footer-description">Your trusted partner in the journey of riding excellence. We provide premium bikes and exceptional service across Nepal.</p>
                    <div class="social-links">
                        <a href="#" class="social-link"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="social-link"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="social-link"><i class="fab fa-youtube"></i></a>
                        <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
                
                <!-- Quick Links -->
                <div class="footer-column">
                    <h4 class="footer-title">Quick Links</h4>
                    <ul class="footer-links">
                        <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/bikes">Our Bikes</a></li>
                        <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                        <li><a href="${pageContext.request.contextPath}/services">Services</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                        <li><a href="${pageContext.request.contextPath}/blog">Blog</a></li>
                    </ul>
                </div>
                
                <!-- Bike Categories -->
                <div class="footer-column">
                    <h4 class="footer-title">Bike Categories</h4>
                    <ul class="footer-links">
                        <li><a href="${pageContext.request.contextPath}/bikes?category=cruiser">Cruiser Bikes</a></li>
                        <li><a href="${pageContext.request.contextPath}/bikes?category=commuter">Commuter Bikes</a></li>
                        <li><a href="${pageContext.request.contextPath}/bikes?category=sports">Sports Bikes</a></li>
                        <li><a href="${pageContext.request.contextPath}/bikes?category=electric">Electric Bikes</a></li>
                        <li><a href="${pageContext.request.contextPath}/bikes?category=adventure">Adventure Bikes</a></li>
                        <li><a href="${pageContext.request.contextPath}/bikes?category=offroad">Off-Road Bikes</a></li>
                    </ul>
                </div>
                
                <!-- Contact Info -->
                <div class="footer-column">
                    <h4 class="footer-title">Contact Us</h4>
                    <ul class="contact-info">
                        <li>
                            <i class="fas fa-map-marker-alt"></i>
                            <span>Ring Road, Kalanki, Kathmandu, Nepal</span>
                        </li>
                        <li>
                            <i class="fas fa-phone-alt"></i>
                            <span>Toll-Free: 1660-HIDASA-00</span>
                        </li>
                        <li>
                            <i class="fas fa-envelope"></i>
                            <span>info@hidasabikes.com</span>
                        </li>
                        <li>
                            <i class="fas fa-clock"></i>
                            <span>Sun - Fri: 9:00 AM - 6:00 PM</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Newsletter -->
    <div class="footer-newsletter">
        <div class="container">
            <div class="newsletter-content">
                <h4>Subscribe to Our Newsletter</h4>
                <p>Stay updated with our latest models, offers, and riding tips</p>
                <form class="newsletter-form">
                    <input type="email" placeholder="Your Email Address" required>
                    <button type="submit" class="btn btn-primary">Subscribe</button>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Footer Bottom -->
    <div class="footer-bottom">
        <div class="container">
            <div class="footer-bottom-content">
                <div class="copyright">
                    <p>&copy; ${java.time.Year.now().getValue()} HIDASA Bikes. All Rights Reserved.</p>
                </div>
                <div class="footer-bottom-links">
                    <a href="${pageContext.request.contextPath}/privacy-policy">Privacy Policy</a>
                    <a href="${pageContext.request.contextPath}/terms-of-service">Terms of Service</a>
                    <a href="${pageContext.request.contextPath}/sitemap">Sitemap</a>
                </div>
            </div>
        </div>
    </div>
</footer>

<style>
    /* Footer Styles */
    .site-footer {
        background-color: #1a1a1a;
        color: #f8f8f8;
        padding-top: 60px;
    }
    
    .footer-top {
        padding-bottom: 40px;
    }
    
    .footer-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 30px;
    }
    
    .footer-column {
        margin-bottom: 20px;
    }
    
    .footer-logo {
        display: flex;
        align-items: center;
        margin-bottom: 15px;
    }
    
    .footer-logo img {
        height: 40px;
        margin-right: 10px;
    }
    
    .footer-logo h3 {
        font-size: 24px;
        margin: 0;
        color: #fff;
    }
    
    .footer-description {
        margin-bottom: 20px;
        line-height: 1.6;
        color: #ccc;
    }
    
    .social-links {
        display: flex;
        gap: 10px;
    }
    
    .social-link {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 36px;
        height: 36px;
        background-color: rgba(255, 255, 255, 0.1);
        border-radius: 50%;
        color: #fff;
        transition: all 0.3s ease;
    }
    
    .social-link:hover {
        background-color: #e63946;
        transform: translateY(-3px);
    }
    
    .footer-title {
        font-size: 18px;
        margin-bottom: 20px;
        position: relative;
        padding-bottom: 10px;
    }
    
    .footer-title:after {
        content: '';
        position: absolute;
        left: 0;
        bottom: 0;
        width: 50px;
        height: 2px;
        background-color: #e63946;
    }
    
    .footer-links {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    
    .footer-links li {
        margin-bottom: 10px;
    }
    
    .footer-links a {
        color: #ccc;
        text-decoration: none;
        transition: all 0.3s ease;
        display: inline-block;
    }
    
    .footer-links a:hover {
        color: #e63946;
        transform: translateX(5px);
    }
    
    .contact-info {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    
    .contact-info li {
        display: flex;
        margin-bottom: 15px;
        color: #ccc;
    }
    
    .contact-info i {
        margin-right: 10px;
        color: #e63946;
        font-size: 16px;
    }
    
    .footer-newsletter {
        background-color: #222;
        padding: 30px 0;
    }
    
    .newsletter-content {
        text-align: center;
    }
    
    .newsletter-content h4 {
        font-size: 20px;
        margin-bottom: 10px;
    }
    
    .newsletter-content p {
        margin-bottom: 20px;
        color: #ccc;
    }
    
    .newsletter-form {
        display: flex;
        max-width: 500px;
        margin: 0 auto;
    }
    
    .newsletter-form input {
        flex: 1;
        padding: 12px 15px;
        border: none;
        border-radius: 4px 0 0 4px;
        font-size: 14px;
    }
    
    .newsletter-form button {
        border-radius: 0 4px 4px 0;
        padding: 0 20px;
    }
    
    .footer-bottom {
        background-color: #111;
        padding: 20px 0;
    }
    
    .footer-bottom-content {
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
    }
    
    .copyright {
        color: #ccc;
        font-size: 14px;
    }
    
    .footer-bottom-links {
        display: flex;
        gap: 20px;
    }
    
    .footer-bottom-links a {
        color: #ccc;
        text-decoration: none;
        font-size: 14px;
        transition: color 0.3s ease;
    }
    
    .footer-bottom-links a:hover {
        color: #e63946;
    }
    
    /* Responsive Styles */
    @media (max-width: 768px) {
        .footer-bottom-content {
            flex-direction: column;
            gap: 15px;
            text-align: center;
        }
        
        .newsletter-form {
            flex-direction: column;
        }
        
        .newsletter-form input {
            border-radius: 4px;
            margin-bottom: 10px;
        }
        
        .newsletter-form button {
            border-radius: 4px;
        }
    }
</style>