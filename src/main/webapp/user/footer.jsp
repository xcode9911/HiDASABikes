<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib uri="jakarta.tags.core" prefix="c" %>
<style>
.footer-logo img {
            filter: brightness(0) invert(1);
        }
</style> 
<footer class="site-footer">
    <div class="container">
        <div class="footer-content">
            <!-- Company Info -->
            <div class="footer-info">
                <div class="footer-logo">
                    <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="HIDASA Bikes Logo">
                    <h3>Bikes</h3>
                </div>
                <p class="footer-description">Your trusted partner in the journey of riding excellence.</p>
                <div class="social-links">
                    <a href="#" class="social-link"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="social-link"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                </div>
            </div>
            
            <!-- Quick Links -->
            <div class="footer-links">
                <h4>Quick Links</h4>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/bikes">Our Bikes</a></li>
                    <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                </ul>
            </div>
            
            <!-- Contact Info -->
            <div class="footer-contact">
                <h4>Contact Us</h4>
                <ul>
                    <li><i class="fas fa-map-marker-alt"></i> Ring Road, Kalanki, Kathmandu</li>
                    <li><i class="fas fa-phone-alt"></i> 1660-HIDASA-00</li>
                    <li><i class="fas fa-envelope"></i> info@hidasabikes.com</li>
                </ul>
            </div>
        </div>
        
        <div class="footer-bottom">
            <p>&copy; ${java.time.Year.now().getValue()} HIDASA Bikes. All Rights Reserved.</p>
            <div class="footer-bottom-links">
               <a href="${pageContext.request.contextPath}/user/privacy.jsp">Privacy</a>
                <a href="${pageContext.request.contextPath}/user/termsofservice.jsp">Terms</a>
            </div>
        </div>
    </div>
</footer>

<style>
    .site-footer {
        background-color: #1a1a1a;
        color: #f8f8f8;
        padding: 40px 0 20px;
    }
    
    .footer-content {
        display: grid;
        grid-template-columns: 2fr 1fr 1fr;
        gap: 40px;
        margin-bottom: 30px;
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
        color: #ccc;
        margin-bottom: 20px;
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
    
    .footer-links h4,
    .footer-contact h4 {
        font-size: 18px;
        margin-bottom: 15px;
        color: #fff;
    }
    
    .footer-links ul,
    .footer-contact ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    
    .footer-links li,
    .footer-contact li {
        margin-bottom: 10px;
        color: #ccc;
    }
    
    .footer-links a {
        color: #ccc;
        text-decoration: none;
        transition: color 0.3s ease;
    }
    
    .footer-links a:hover {
        color: #e63946;
    }
    
    .footer-contact i {
        margin-right: 10px;
        color: #e63946;
    }
    
    .footer-bottom {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding-top: 20px;
        border-top: 1px solid rgba(255, 255, 255, 0.1);
    }
    
    .footer-bottom p {
        color: #ccc;
        margin: 0;
    }
    
    .footer-bottom-links {
        display: flex;
        gap: 20px;
    }
    
    .footer-bottom-links a {
        color: #ccc;
        text-decoration: none;
        transition: color 0.3s ease;
    }
    
    .footer-bottom-links a:hover {
        color: #e63946;
    }
    
    @media (max-width: 768px) {
        .footer-content {
            grid-template-columns: 1fr;
            gap: 30px;
        }
        
        .footer-bottom {
            flex-direction: column;
            text-align: center;
            gap: 15px;
        }
    }
</style>