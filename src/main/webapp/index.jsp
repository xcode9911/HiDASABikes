<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HIDASA Bikes - Register</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
</head>
<body>
    <div class="container">
        <!-- Static Left Side -->
        <div class="left-side">
            <!-- Register Welcome Content -->
            <div class="welcome-content">
                <img src="${pageContext.request.contextPath}/assets/images/hidasalogo.png" alt="HIDASA Logo" style="max-width: 80%; margin-top: -200px;">
                <div class="welcome-text">
                    <h1>New Here?<span>Join the Journey!</span></h1>
                    <a class="welcome-link" href="${pageContext.request.contextPath}/login.jsp">Back to Login</a>
                </div>
            </div>
        </div>

        <!-- Right Side -->
        <div class="right-side-container">
            <!-- Register Form -->
            <div class="form-panel">
                <div class="form-container">
                    <div class="form-header">
                        <h2>Register</h2>
                        <p>Create your account to get started</p>
                    </div>
                    <form action="${pageContext.request.contextPath}/register" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="register">
                        
                        <c:if test="${not empty param.error}">
                            <div class="alert alert-error">
                                <i class="fas fa-exclamation-circle"></i>
                                <c:choose>
                                    <c:when test="${param.error == 'missing_fields'}">
                                        Please fill in all required fields.
                                    </c:when>
                                    <c:when test="${param.error == 'password_mismatch'}">
                                        Passwords do not match.
                                    </c:when>
                                    <c:when test="${param.error == 'email_exists'}">
                                        Email already exists.
                                    </c:when>
                                    <c:when test="${param.error == 'database'}">
                                        Database error occurred. Please try again.
                                    </c:when>
                                    <c:when test="${param.error == 'registration_failed'}">
                                        Registration failed. Please try again.
                                    </c:when>
                                    <c:otherwise>
                                        An error occurred. Please try again.
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:if>
                        
                        <!-- Basic Information -->
                        <div class="form-group">
                            <label for="name">Full Name*</label>
                            <input type="text" id="name" name="name" required 
                                   placeholder="Enter your full name"
                                   maxlength="100">
                        </div>

                        <div class="form-group">
                            <label for="email">Email Address*</label>
                            <input type="email" id="email" name="email" required 
                                   placeholder="Enter your email address"
                                   maxlength="100">
                        </div>

                        <div class="form-group">
                            <label for="phone">Phone Number</label>
                            <input type="tel" id="phone" name="phone" 
                                   placeholder="Enter your phone number"
                                   maxlength="20"
                                   pattern="[0-9+\-\s()]*">
                        </div>

                        <div class="form-group">
                            <label for="password">Password*</label>
                            <input type="password" id="password" name="password" required 
                                   placeholder="Enter your password"
                                   maxlength="255">
                        </div>

                        <div class="form-group">
                            <label for="confirmPassword">Confirm Password*</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" required 
                                   placeholder="Confirm your password"
                                   maxlength="255">
                        </div>

                        <!-- Address Information -->
                        <div class="form-group">
                            <label for="street">Street Address</label>
                            <input type="text" id="street" name="street" 
                                   placeholder="Enter your street address"
                                   maxlength="255">
                        </div>

                        <div class="form-group">
                            <label for="city">City</label>
                            <input type="text" id="city" name="city" 
                                   placeholder="Enter your city"
                                   maxlength="100">
                        </div>

                        <div class="form-group">
                            <label for="state">State/Province</label>
                            <input type="text" id="state" name="state" 
                                   placeholder="Enter your state/province"
                                   maxlength="100">
                        </div>

                        <div class="form-group">
                            <label for="zipCode">ZIP/Postal Code</label>
                            <input type="text" id="zipCode" name="zipCode" 
                                   placeholder="Enter your ZIP/postal code"
                                   maxlength="20"
                                   pattern="[0-9\-]*">
                        </div>

                        <div class="form-group">
                            <label for="country">Country</label>
                            <input type="text" id="country" name="country" 
                                   placeholder="Enter your country"
                                   maxlength="100">
                        </div>

                        <!-- Profile Image -->
                        <div class="form-group">
                            <label for="profileImage">Profile Picture</label>
                            <input type="file" id="profileImage" name="profileImage" 
                                   accept="image/*"
                                   class="file-input">
                            <small class="form-text">Maximum file size: 5MB. Supported formats: JPG, PNG, GIF</small>
                        </div>

                        <input type="hidden" name="role" value="customer">

                        <button type="submit" class="submit-btn">Create Account</button>
                    </form>
                    
                    <div class="toggle-form">
                        <p>Already have an account? <a href="${pageContext.request.contextPath}/login.jsp">Login</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Initialize welcome content visibility and animations
        document.addEventListener('DOMContentLoaded', function() {
            const welcomeContent = document.querySelector('.welcome-content');
            const welcomeText = document.querySelector('.welcome-text');
            const welcomeLink = document.querySelector('.welcome-link');
            
            welcomeText.style.opacity = '1';
            welcomeText.style.transform = 'translateY(0)';
            
            welcomeLink.style.opacity = '1';
        });
    </script>
</body>
</html>