<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HIDASA Bikes - My Profile</title>
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
            --header-height: 70px;
        }

        .profile-page * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        .profile-page body {
            background: var(--background);
            color: var(--text-dark);
            line-height: 1.6;
            padding-top: var(--header-height);
        }

        .profile-page .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
             margin-top: 2rem;
        }

        .profile-page .profile-section {
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: 2rem;
            margin-top: 2rem;
        }

        .profile-page .profile-sidebar {
            background: var(--card-bg);
            border-radius: var(--radius-lg);
            padding: 2rem;
            box-shadow: var(--shadow-md);
            height: fit-content;
        }

        .profile-page .profileimage {
            text-align: center;
            margin-bottom: 2rem;
        }

        .profile-page .profile-image-preview {
            width: 200px;
            height: 200px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid var(--primary);
            margin-bottom: 1rem;
        }

        .profile-page .profile-image-upload {
            display: none;
        }

        .profile-page .upload-btn {
            background: var(--gradient-primary);
            color: var(--text-light);
            padding: 0.75rem 1.5rem;
            border-radius: var(--radius-md);
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-block;
            font-weight: 500;
        }

        .profile-page .upload-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .profile-page .profile-menu {
            list-style: none;
        }

        .profile-page .profile-menu-item {
            margin-bottom: 0.5rem;
        }

        .profile-page .profile-menu-link {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem;
            color: var(--text-dark);
            text-decoration: none;
            border-radius: var(--radius-md);
            transition: all 0.3s ease;
        }

        .profile-page .profile-menu-link:hover,
        .profile-page .profile-menu-link.active {
            background: rgba(255, 11, 85, 0.1);
            color: var(--primary);
        }

        .profile-page .profile-menu-link i {
            width: 20px;
            text-align: center;
        }

        .profile-page .profile-content {
            background: var(--card-bg);
            border-radius: var(--radius-lg);
            padding: 2rem;
            box-shadow: var(--shadow-md);
        }

        .profile-page .section-title {
            font-size: 1.8rem;
            font-weight: 600;
            margin-bottom: 2rem;
            color: var(--primary);
        }

        .profile-page .form-group {
            margin-bottom: 1.5rem;
        }

        .profile-page .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }

        .profile-page .form-control {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 2px solid rgba(0, 0, 0, 0.1);
            border-radius: var(--radius-md);
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .profile-page .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(255, 11, 85, 0.1);
        }

        .profile-page .btn {
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

        .profile-page .btn-primary {
            background: var(--gradient-primary);
            color: var(--text-light);
        }

        .profile-page .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .profile-page .form-row {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
        }

        .profile-page .alert {
            padding: 1rem;
            border-radius: var(--radius-md);
            margin-bottom: 1rem;
            display: none;
            font-weight: 500;
            animation: fadeIn 0.3s ease-in-out;
        }

        .profile-page .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .profile-page .alert-danger {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .profile-page .tab-content {
            display: none;
        }

        .profile-page .tab-content.active {
            display: block;
        }

        .profile-page .user-info {
            margin-bottom: 1.5rem;
            padding: 1rem;
            background: rgba(0, 0, 0, 0.03);
            border-radius: var(--radius-md);
        }

        .profile-page .user-info-title {
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--primary);
        }

        .profile-page .user-info-item {
            display: flex;
            margin-bottom: 0.5rem;
        }

        .profile-page .user-info-label {
            font-weight: 500;
            width: 150px;
        }

        .profile-page .user-info-value {
            flex: 1;
        }

        @media (max-width: 768px) {
            .profile-page .profile-section {
                grid-template-columns: 1fr;
            }

            .profile-page .form-row {
                grid-template-columns: 1fr;
            }
            
            .profile-page .user-info-item {
                flex-direction: column;
            }
            
            .profile-page .user-info-label {
                width: 100%;
                margin-bottom: 0.25rem;
            }
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <%@ include file="navigationBar.jsp" %>

    <div class="profile-page">
    <div class="container">
        <div class="profile-section">
            <!-- Profile Sidebar -->
            <div class="profile-sidebar">
                <div class="profileimage">
                    <img src="${profileImage != null ? 'data:image/jpeg;base64,'.concat(profileImage) : 'https://via.placeholder.com/200'}" alt="Profile" id="profileImagePreview" class="profile-image-preview">
                    <form id="imageUploadForm" action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="uploadImage">
                        <input type="file" id="profileImage" name="profileImage" class="profile-image-upload" accept="image/*">
                        <label for="profileImage" class="upload-btn">
                            <i class="fas fa-camera"></i> Change Photo
                        </label>
                    </form>
                </div>

                <ul class="profile-menu">
                    <li class="profile-menu-item">
                        <a href="#personal-info" class="profile-menu-link active" data-tab="personal-info">
                            <i class="fas fa-user"></i> Personal Information
                        </a>
                    </li>
                    <li class="profile-menu-item">
                        <a href="#security" class="profile-menu-link" data-tab="security">
                            <i class="fas fa-lock"></i> Security
                        </a>
                    </li>

                </ul>
            </div>

            <!-- Profile Content -->
            <div class="profile-content">
                <!-- Personal Information Tab -->
                <div id="personal-info" class="tab-content active">
                    <h2 class="section-title">Personal Information</h2>
                    <div class="alert alert-success" id="personalInfoSuccess" style="display: none;">Information updated successfully!</div>
                    <div class="alert alert-danger" id="personalInfoError" style="display: none;">Please fill all required fields.</div>
                    
                    <!-- Display User Information -->
                    <div class="user-info">
                        <h3 class="user-info-title">Account Information</h3>
                        <div class="user-info-item">
                            <span class="user-info-label">User ID:</span>
                            <span class="user-info-value">${user.userId != null ? user.userId : sessionScope.userId}</span>
                        </div>
                        <div class="user-info-item">
                            <span class="user-info-label">Role:</span>
                            <span class="user-info-value">${user.role != null ? user.role : sessionScope.role}</span>
                        </div>
                    </div>
                    
                    <form id="personalInfoForm" action="${pageContext.request.contextPath}/profile" method="post">
                        <input type="hidden" name="action" value="updateProfile">
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Full Name</label>
                                <input type="text" class="form-control" name="name" value="${user.name != null ? user.name : sessionScope.name}" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" name="email" value="${user.email != null ? user.email : sessionScope.email}" required>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Phone Number</label>
                                <input type="tel" class="form-control" name="phone" value="${user.phone != null ? user.phone : sessionScope.phone}">
                            </div>
                      
                        </div>
                        
                        <!-- Address Information -->
                        <h3 class="section-title" style="font-size: 1.5rem; margin-top: 2rem;">Address Information</h3>
                        <div class="form-group">
                            <label class="form-label">Street Address</label>
                            <input type="text" class="form-control" name="street" value="${address != null ? address.street : ''}">
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">City</label>
                                <input type="text" class="form-control" name="city" value="${address != null ? address.city : ''}">
                            </div>
                            <div class="form-group">
                                <label class="form-label">State/Province</label>
                                <input type="text" class="form-control" name="state" value="${address != null ? address.state : ''}">
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Zip/Postal Code</label>
                                <input type="text" class="form-control" name="zipCode" value="${address != null ? address.zipCode : ''}">
                            </div>
                            <div class="form-group">
                                <label class="form-label">Country</label>
                                <input type="text" class="form-control" name="country" value="${address != null ? address.country : ''}">
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Save Changes
                        </button>
                    </form>
                </div>

                <!-- Security Tab -->
                <div id="security" class="tab-content">
                    <h2 class="section-title">Security Settings</h2>
                    <div class="alert alert-success" id="securitySuccess" style="display: none;">Password updated successfully!</div>
                    <div class="alert alert-danger" id="securityError" style="display: none;">Error updating password.</div>
                    <form id="securityForm" action="${pageContext.request.contextPath}/profile" method="post">
                        <input type="hidden" name="action" value="updatePassword">
                        <div class="form-group">
                            <label class="form-label">Current Password</label>
                            <input type="password" class="form-control" name="currentPassword" required>
                        </div>
                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">New Password</label>
                                <input type="password" class="form-control" name="newPassword" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Confirm New Password</label>
                                <input type="password" class="form-control" name="confirmPassword" required>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-key"></i> Update Password
                        </button>
                    </form>
                </div>

                <!-- Preferences Tab -->
               
            </div>
        </div>
    </div>
    </div>

    <script>
        // Tab switching functionality
        document.querySelectorAll('.profile-menu-link').forEach(link => {
            link.addEventListener('click', function(e) {
                e.preventDefault();
                
                // Remove active class from all links and tabs
                document.querySelectorAll('.profile-menu-link').forEach(l => l.classList.remove('active'));
                document.querySelectorAll('.tab-content').forEach(t => t.classList.remove('active'));
                
                // Add active class to clicked link and corresponding tab
                this.classList.add('active');
                document.getElementById(this.dataset.tab).classList.add('active');
            });
        });

        // Profile image preview
        document.getElementById('profileImage').addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('profileImagePreview').src = e.target.result;
                }
                reader.readAsDataURL(file);
                
                // Auto submit form when file is selected
                document.getElementById('imageUploadForm').submit();
            }
        });

        // Display success or error messages based on query parameters
        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            
            // Check for success messages
            if (urlParams.has('success')) {
                const successType = urlParams.get('success');
                if (successType === 'profile_updated') {
                    // Check if we have specific changes
                    if (urlParams.has('changes')) {
                        const changes = urlParams.get('changes').split(',');
                        let message = '';
                        
                        // Build a descriptive message based on what changed
                        if (changes.includes('name')) {
                            message += 'Name, ';
                        }
                        if (changes.includes('email')) {
                            message += 'Email, ';
                        }
                        if (changes.includes('phone')) {
                            message += 'Phone number, ';
                        }
                        
                        // Address changes
                        let addressChanged = false;
                        if (changes.includes('street')) {
                            addressChanged = true;
                            message += 'Street, ';
                        }
                        if (changes.includes('city')) {
                            addressChanged = true;
                            message += 'City, ';
                        }
                        if (changes.includes('state')) {
                            addressChanged = true;
                            message += 'State, ';
                        }
                        if (changes.includes('zipCode')) {
                            addressChanged = true;
                            message += 'Zip code, ';
                        }
                        if (changes.includes('country')) {
                            addressChanged = true;
                            message += 'Country, ';
                        }
                        if (changes.includes('newAddress') || changes.includes('addressAdded')) {
                            message += 'New address added, ';
                        }
                        
                        // Trim trailing comma and space
                        message = message.trim();
                        if (message.endsWith(',')) {
                            message = message.substring(0, message.length - 1);
                        }
                        
                        if (message) {
                            const alertElem = document.getElementById('personalInfoSuccess');
                            alertElem.innerHTML = message + ' successfully updated!';
                            showAlert('personalInfoSuccess');
                        } else {
                            showAlert('personalInfoSuccess');
                        }
                    } else {
                        showAlert('personalInfoSuccess');
                    }
                } else if (successType === 'profile_unchanged') {
                    const alertElem = document.getElementById('personalInfoSuccess');
                    alertElem.innerHTML = 'No changes detected. Your profile remains the same.';
                    showAlert('personalInfoSuccess');
                } else if (successType === 'profile_partial') {
                    // Show success but add a note about partial update
                    const alertElem = document.getElementById('personalInfoSuccess');
                    if (urlParams.has('note') && urlParams.get('note') === 'address_failed') {
                        alertElem.innerHTML = "Profile information updated, but there was an issue updating your address.";
                    }
                    showAlert('personalInfoSuccess');
                } else if (successType === 'password_updated') {
                    showAlert('securitySuccess');
                    // Switch to security tab if needed
                    if (urlParams.has('tab') && urlParams.get('tab') === 'password') {
                        switchTab('security');
                    }
                } else if (successType === 'image_updated') {
                    const alertElem = document.getElementById('personalInfoSuccess');
                    alertElem.innerHTML = "Profile image updated successfully!";
                    showAlert('personalInfoSuccess');
                }
            }
            
            // Check for error messages
            if (urlParams.has('error')) {
                const errorType = urlParams.get('error');
                let errorMessage = "An error occurred. Please try again.";
                
                // Set appropriate error messages based on error type
                if (errorType === 'missing_fields') {
                    errorMessage = "Please fill all required fields.";
                    document.getElementById('personalInfoError').innerHTML = errorMessage;
                    showAlert('personalInfoError');
                } else if (errorType === 'update_failed') {
                    errorMessage = "Failed to update information. Please try again.";
                    document.getElementById('personalInfoError').innerHTML = errorMessage;
                    showAlert('personalInfoError');
                } else if (errorType === 'password_mismatch') {
                    errorMessage = "Passwords do not match.";
                    document.getElementById('securityError').innerHTML = errorMessage;
                    showAlert('securityError');
                    switchTab('security');
                } else if (errorType === 'wrong_password') {
                    errorMessage = "Current password is incorrect.";
                    document.getElementById('securityError').innerHTML = errorMessage;
                    showAlert('securityError');
                    switchTab('security');
                }
                
                console.error('Error: ' + errorType + ' - ' + errorMessage);
            }
            
            // Switch to specified tab if needed
            if (urlParams.has('tab')) {
                switchTab(urlParams.get('tab'));
            }
        };
        
        // Function to switch tabs programmatically
        function switchTab(tabId) {
            // Remove active class from all links and tabs
            document.querySelectorAll('.profile-menu-link').forEach(l => l.classList.remove('active'));
            document.querySelectorAll('.tab-content').forEach(t => t.classList.remove('active'));
            
            // Add active class to specified link and corresponding tab
            const tabLink = document.querySelector(`.profile-menu-link[data-tab="${tabId}"]`);
            if (tabLink) {
                tabLink.classList.add('active');
                document.getElementById(tabId).classList.add('active');
            }
        }

        // Form submissions (removing the preventDefault to allow actual submission)
        document.getElementById('personalInfoForm').addEventListener('submit', function(e) {
            // Check if form is valid
            if (!this.checkValidity()) {
                e.preventDefault();
                document.getElementById('personalInfoError').innerText = "Please fill all required fields.";
                showAlert('personalInfoError');
                return;
            }
            
            // Show loading message
            document.getElementById('personalInfoSuccess').innerText = "Saving your information...";
            showAlert('personalInfoSuccess');
            // Form will be submitted to the server
        });

        document.getElementById('securityForm').addEventListener('submit', function(e) {
            // Check if passwords match
            const newPassword = document.querySelector('input[name="newPassword"]').value;
            const confirmPassword = document.querySelector('input[name="confirmPassword"]').value;
            
            if (newPassword !== confirmPassword) {
                e.preventDefault();
                document.getElementById('securityError').innerText = "Passwords do not match.";
                showAlert('securityError');
                return;
            }
            
            // Show loading message
            document.getElementById('securitySuccess').innerText = "Updating your password...";
            showAlert('securitySuccess');
            // Form will be submitted to the server
        });

        document.getElementById('preferencesForm').addEventListener('submit', function(e) {
            // Show loading message
            document.getElementById('preferencesSuccess').innerText = "Saving your preferences...";
            showAlert('preferencesSuccess');
            // Form will be submitted to the server
        });

        document.getElementById('billingForm').addEventListener('submit', function(e) {
            // Check if form is valid
            if (!this.checkValidity()) {
                e.preventDefault();
                document.getElementById('billingError').innerText = "Please fill all required fields.";
                showAlert('billingError');
                return;
            }
            
            // Show loading message
            document.getElementById('billingSuccess').innerText = "Saving your billing information...";
            showAlert('billingSuccess');
            // Form will be submitted to the server
        });

        // Helper function to show alerts
        function showAlert(alertId) {
            const alert = document.getElementById(alertId);
            if (alert) {
                alert.style.display = 'block';
                // Scroll to the alert to ensure it's visible
                alert.scrollIntoView({ behavior: 'smooth', block: 'center' });
                setTimeout(() => {
                    alert.style.display = 'none';
                }, 5000); // Show for 5 seconds
            }
        }
    </script>
    
    <!-- Immediately check URL parameters and display messages -->
    <script>
        // Get URL parameters right away
        const urlParams = new URLSearchParams(window.location.search);
        
        // Check for success messages
        if (urlParams.has('success')) {
            const successType = urlParams.get('success');
            
            // Handle different success types
            if (successType === 'profile_updated' || 
                successType === 'profile_partial' || 
                successType === 'image_updated' ||
                successType === 'profile_unchanged') {
                
                // This will be handled by the window.onload function
                // Just ensure the user sees something is happening
                document.getElementById('personalInfoSuccess').style.display = 'block';
            }
            else if (successType === 'password_updated') {
                document.getElementById('securitySuccess').style.display = 'block';
                // Will switch tabs in the onload function
            }
        }
        
        // Check for error messages
        if (urlParams.has('error')) {
            const errorType = urlParams.get('error');
            
            // Show appropriate error
            if (errorType === 'missing_fields' || errorType === 'update_failed') {
                document.getElementById('personalInfoError').style.display = 'block';
            }
            else if (errorType === 'password_mismatch' || errorType === 'wrong_password') {
                document.getElementById('securityError').style.display = 'block';
            }
        }
    </script>
</body>
</html>
