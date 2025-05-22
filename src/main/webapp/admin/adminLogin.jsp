<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HIDASA Bikes - Admin Login</title>
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
            --background: #121212;
            --card-bg: #1E1E1E;
            --input-bg: #2A2A2A;
            --gradient-primary: linear-gradient(135deg, #FF0B55, #CF0F47);
            --gradient-dark: linear-gradient(135deg, #1A1A1A, #333333);
            --shadow-sm: 0 2px 4px rgba(0,0,0,0.2);
            --shadow-md: 0 4px 8px rgba(0,0,0,0.3);
            --shadow-lg: 0 8px 16px rgba(0,0,0,0.4);
            --radius-sm: 4px;
            --radius-md: 8px;
            --radius-lg: 16px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: var(--background);
            color: var(--text-light);
            line-height: 1.6;
            min-height: 100vh;
            display: flex;
            overflow: hidden;
        }

        .container {
            display: flex;
            width: 100%;
            height: 100vh;
        }

        /* Left Side - Background Image */
        .background-side {
            flex: 1;
            background-image: url('../assets/images/bikehero.jpg');
            background-size: cover;
            background-position: center;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .background-side::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6);
            z-index: 1;
        }

        .background-content {
            position: relative;
            z-index: 2;
            text-align: center;
            padding: 20px;
            max-width: 500px;
        }

        .background-content h1 {
            font-size: 3rem;
            font-weight: 800;
            margin-bottom: 20px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.5);
        }

        .background-content p {
            font-size: 1.2rem;
            margin-bottom: 30px;
            text-shadow: 0 1px 2px rgba(0,0,0,0.5);
        }

        .background-content .btn {
            display: inline-block;
            padding: 12px 30px;
            background: var(--primary);
            color: var(--text-light);
            text-decoration: none;
            border-radius: var(--radius-md);
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-md);
        }

        .background-content .btn:hover {
            background: var(--primary-dark);
            transform: translateY(-3px);
            box-shadow: var(--shadow-lg);
        }

        /* Right Side - Login Form */
        .login-side {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px;
            position: relative;
        }

        .login-container {
            width: 100%;
            max-width: 450px;
            background: var(--card-bg);
            border-radius: var(--radius-lg);
            padding: 40px;
            box-shadow: var(--shadow-lg);
            position: relative;
            overflow: hidden;
            animation: fadeIn 0.8s ease-out;
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

        .login-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: var(--gradient-primary);
        }

        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .login-header img {
            max-width: 150px;
            margin-bottom: 20px;
        }

        .login-header h2 {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .login-header p {
            color: #aaa;
            font-size: 0.9rem;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #ddd;
        }

        .form-group .input-icon {
            position: absolute;
            left: 15px;
            top: 40px;
            color: #777;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px 12px 45px;
            background: var(--input-bg);
            border: 1px solid #333;
            border-radius: var(--radius-md);
            color: var(--text-light);
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--primary);
            outline: none;
            box-shadow: 0 0 0 3px rgba(255, 11, 85, 0.2);
        }

        .form-control::placeholder {
            color: #777;
        }

        .form-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .remember-me {
            display: flex;
            align-items: center;
        }

        .remember-me input {
            margin-right: 8px;
            accent-color: var(--primary);
        }

        .forgot-password {
            color: var(--primary);
            text-decoration: none;
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }

        .forgot-password:hover {
            color: var(--primary-dark);
            text-decoration: underline;
        }

        .login-btn {
            width: 100%;
            padding: 14px;
            background: var(--gradient-primary);
            color: var(--text-light);
            border: none;
            border-radius: var(--radius-md);
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-md);
        }

        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .login-btn:active {
            transform: translateY(0);
        }

        .security-info {
            margin-top: 30px;
            text-align: center;
            font-size: 0.8rem;
            color: #777;
        }

        .security-info i {
            color: var(--primary);
            margin-right: 5px;
        }

        .error-message {
            background: rgba(255, 11, 85, 0.1);
            color: var(--primary);
            padding: 10px 15px;
            border-radius: var(--radius-sm);
            margin-bottom: 20px;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
        }

        .error-message i {
            margin-right: 10px;
        }

        /* Responsive Styles */
        @media (max-width: 992px) {
            .container {
                flex-direction: column;
            }
            
            .background-side {
                display: none;
            }
            
            .login-side {
                padding: 20px;
            }
        }

        @media (max-width: 576px) {
            .login-container {
                padding: 30px 20px;
            }
            
            .form-options {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .forgot-password {
                margin-top: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Left Side - Background Image -->
        <div class="background-side">
            <div class="background-content">
                <h1>HIDASA Bikes</h1>
                <p>Power, Performance, and Precision in Every Ride</p>
                <a href="../index.jsp" class="btn">Visit Showroom</a>
            </div>
        </div>
        
        <!-- Right Side - Login Form -->
        <div class="login-side">
            <div class="login-container">
                <div class="login-header">
                    <img src="../assets/images/hidasalogo.png" alt="HIDASA Bikes Logo">
                    <h2>Admin Login</h2>
                    <p>Admin access only. Please log in to manage the HIDASA Bike Inventory.</p>
                </div>
                
                <% if (request.getAttribute("error") != null) { %>
                    <div class="error-message">
                        <i class="fas fa-exclamation-circle"></i>
                        <%= request.getAttribute("error") %>
                    </div>
                <% } %>
                
                <form action="${pageContext.request.contextPath}/AdminLoginServlet" method="post" id="loginForm">
                    <div class="form-group">
                        <label for="username">Username or Admin Email</label>
                        <i class="fas fa-user input-icon"></i>
                        <input type="text" id="username" name="username" class="form-control" placeholder="Enter your username or email" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="password">Password</label>
                        <i class="fas fa-lock input-icon"></i>
                        <input type="password" id="password" name="password" class="form-control" placeholder="Enter your password" required>
                    </div>
                    
                    <div class="form-options">
                        <div class="remember-me">
                            <input type="checkbox" id="remember" name="remember">
                            <label for="remember">Remember Me</label>
                        </div>
                        <a href="#" class="forgot-password">Forgot Password?</a>
                    </div>
                    
                    <button type="submit" class="login-btn">Login</button>
                    
                    <div class="security-info">
                        <i class="fas fa-shield-alt"></i>
                        Secure connection (HTTPS) - Your data is protected
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        // Form validation
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const username = document.getElementById('username').value.trim();
            const password = document.getElementById('password').value.trim();
            
            if (username === '' || password === '') {
                e.preventDefault();
                alert('Please fill in all fields');
            }
        });
        
        // Add animation to input fields
        const inputs = document.querySelectorAll('.form-control');
        inputs.forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.classList.add('focused');
            });
            
            input.addEventListener('blur', function() {
                if (this.value === '') {
                    this.parentElement.classList.remove('focused');
                }
            });
        });
    </script>
</body>
</html>