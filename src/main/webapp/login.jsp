<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HIDASA Bikes - Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
    
    <!-- Simple cookie check script -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Function to get cookie value
            function getCookie(name) {
                const value = `; ${document.cookie}`;
                const parts = value.split(`; ${name}=`);
                if (parts.length === 2) return parts.pop().split(';').shift();
                return null;
            }
            
            // Check for auth cookies
            const hasAuthCookies = 
                getCookie('authToken') && 
                getCookie('userEmail') && 
                getCookie('userId');
                
            // If all auth cookies exist, redirect to home page
            if (hasAuthCookies) {
                window.location.href = "${pageContext.request.contextPath}/home";
            }
        });
    </script>
</head>
<body>
    <div class="container">
        <!-- Static Left Side -->
        <div class="left-side">
            <!-- Login Welcome Content -->
            <div class="welcome-content">
                <a href="${pageContext.request.contextPath}/home">
                    <img src="${pageContext.request.contextPath}/assets/images/hidasalogo.png" alt="HIDASA Logo" style="max-width: 80%; margin-top: -200px;">
                </a>
                <div class="welcome-text">
                    <h1>Welcome Back!<span>Ready to Ride?</span></h1>
                    <a class="welcome-link" href="${pageContext.request.contextPath}/register">Register Now</a>
                </div>
            </div>
        </div>

        <!-- Right Side -->
        <div class="right-side-container">
            <!-- Login Form -->
            <div class="form-panel">
                <div class="form-container">
                    <div class="form-header">
                        <h2>Login</h2>
                        <p>Welcome back! Please log in to your account</p>
                    </div>
                    <form action="${pageContext.request.contextPath}/login" method="post">
                        <input type="hidden" name="action" value="login">
                        
                        <c:if test="${not empty param.error}">
                            <div class="alert alert-error">
                                <i class="fas fa-exclamation-circle"></i>
                                <c:choose>
                                    <c:when test="${param.error == 'missing_fields'}">
                                        Please fill in all required fields.
                                    </c:when>
                                    <c:when test="${param.error == 'invalid_credentials'}">
                                        Invalid email or password.
                                    </c:when>
                                    <c:when test="${param.error == 'database'}">
                                        Database error occurred. Please try again.
                                    </c:when>
                                    <c:when test="${param.error == 'database_connection'}">
                                        Unable to connect to the database. Please check if the database server is running.
                                    </c:when>
                                    <c:when test="${param.error == 'session_expired'}">
                                        Your session has expired. Please log in again.
                                    </c:when>
                                    <c:when test="${param.error == 'cookies_disabled'}">
                                        Please enable cookies to use remember me feature.
                                    </c:when>
                                    <c:otherwise>
                                        An error occurred. Please try again.
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty param.success && param.success == 'registered'}">
                            <div class="alert alert-success">
                                <i class="fas fa-check-circle"></i>
                                Registration successful! Please login.
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty param.logout && param.logout == 'success'}">
                            <div class="alert alert-success">
                                <i class="fas fa-check-circle"></i>
                                You have been successfully logged out.
                            </div>
                        </c:if>
                        
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" required 
                                   placeholder="Enter your email address"
                                   value="${param.email}">
                        </div>
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" id="password" name="password" required 
                                   placeholder="Enter your password">
                        </div>
                        <div class="form-footer">
                            <label class="remember-me">
                                <input type="checkbox" name="remember" id="remember">
                                Remember me
                            </label>
                            <a href="#" class="forgot-password">Forgot Password?</a>
                        </div>
                        <button type="submit" class="submit-btn">Login</button>
                    </form>
                    
                    <div class="toggle-form">
                        <p>Don't have an account?<a href="${pageContext.request.contextPath}/register">Register</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Initialize welcome content visibility and animations
        document.addEventListener('DOMContentLoaded', function() {
            const welcomeText = document.querySelector('.welcome-text');
            const welcomeTextH1 = document.querySelector('.welcome-text h1');
            const welcomeTextSpan = document.querySelector('.welcome-text h1 span');
            const welcomeLink = document.querySelector('.welcome-link');
            
            welcomeText.style.opacity = '1';
            welcomeText.style.transform = 'translateY(0)';
            welcomeTextH1.style.opacity = '1';
            welcomeTextH1.style.transform = 'translateY(0)';
            welcomeTextSpan.style.opacity = '1';
            welcomeTextSpan.style.transform = 'translateY(0)';
            welcomeLink.style.opacity = '1';
            
            // Check if cookies are enabled
            const rememberCheckbox = document.getElementById('remember');
            if (rememberCheckbox && !navigator.cookieEnabled) {
                rememberCheckbox.disabled = true;
                rememberCheckbox.parentElement.title = "Cookies are disabled in your browser";
                rememberCheckbox.parentElement.style.opacity = "0.5";
            }
        });
    </script>
</body>
</html>

                        
                  
                  