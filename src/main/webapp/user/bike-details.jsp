<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HIDASA Bikes - ${bike.brandName} ${bike.modelName}</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-bg: #FFDEDE;
            --text-color: #000000;
            --accent-color: #FF0B55;
            --hover-color: #CF0F47;
            --hover-bg: rgba(207, 15, 71, 0.1);
            --card-bg: #FFFFFF;
            --border-color: #E5E5E5;
            --success-color: #4CAF50;
            --error-color: #F44336;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background-color: var(--primary-bg);
            color: var(--text-color);
            line-height: 1.6;
        }

        .bike-details-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 2rem;
            margin-top: 6rem;
        }
        
        /* Two-column layout */
        .bike-details-content {
            display: flex;
            gap: 2rem;
            margin-bottom: 2rem;
        }
        
        .left-column {
            flex: 1;
            max-width: 60%;
        }
        
        .right-column {
            flex: 1;
            max-width: 40%;
        }
        
        /* Bike Header Section */
        .bike-header {
            background-color: var(--card-bg);
            border-radius: 1rem;
            padding: 1.5rem 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        }

        .bike-title-section {
            margin-bottom: 1.5rem;
        }

        .bike-title {
            font-size: 2.3rem;
            font-weight: 600;
            color: var(--accent-color);
        }

        .bike-subtitle {
            font-size: 1.1rem;
            color: #777;
            margin-top: 0.3rem;
        }
        
        .price-section {
            margin-bottom: 1.5rem;
        }

        .bike-price {
            font-size: 1.8rem;
            font-weight: 600;
            color: var(--accent-color);
            white-space: nowrap;
        }
        
        .action-section {
            margin-bottom: 1.5rem;
        }

        .action-button {
            padding: 0.8rem 1.5rem;
            border-radius: 0.5rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
            white-space: nowrap;
            justify-content: center;
            width: 100%;
        }

        .btn-primary {
            background-color: var(--accent-color);
            color: white;
            border: none;
        }

        .btn-primary:hover {
            background-color: var(--hover-color);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(207, 15, 71, 0.2);
        }
        
        .btn-disabled {
            background-color: #888;
            color: white;
            cursor: not-allowed;
        }

        /* Image Showcase */
        .image-showcase {
            position: relative;
            width: 100%;
            background-color: var(--card-bg);
            border-radius: 1rem;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            margin-bottom: 2rem;
        }

        .image-container {
            position: relative;
            height: 400px;
            width: 100%;
            overflow: hidden;
        }

        .main-image {
            width: 100%;
            height: 100%;
            object-fit: contain;
            transition: transform 0.5s ease;
        }

        .main-image:hover {
            transform: scale(1.05);
        }

        .image-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background: linear-gradient(transparent, rgba(0, 0, 0, 0.7));
            padding: 2rem;
            color: white;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .image-container:hover .image-overlay {
            opacity: 1;
        }

        .overlay-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .overlay-text {
            font-size: 1rem;
        }

        .stock-badge {
            position: absolute;
            top: 1rem;
            right: 1rem;
            padding: 0.5rem 1rem;
            border-radius: 2rem;
            font-size: 0.875rem;
            font-weight: 500;
            z-index: 10;
        }
        
        .in-stock {
            background-color: var(--success-color);
            color: white;
        }
        
        .low-stock {
            background-color: #FFC107;
            color: #333;
        }
        
        .out-of-stock {
            background-color: var(--error-color);
            color: white;
        }

        /* Section Cards */
        .section-card {
            background-color: var(--card-bg);
            border-radius: 1rem;
            padding: 2rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            margin-bottom: 2rem;
        }

        .section-header {
            margin-bottom: 1.5rem;
            position: relative;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--border-color);
        }

        .section-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--accent-color);
        }

        /* Specification Styles */
        .specs-content {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 2rem;
        }

        .spec-group {
            margin-bottom: 1.5rem;
        }

        .spec-title {
            font-weight: 600;
            margin-bottom: 1rem;
            color: var(--accent-color);
            position: relative;
            padding-left: 1.5rem;
        }

        .spec-title::before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            transform: translateY(-50%);
            width: 1rem;
            height: 2px;
            background-color: var(--accent-color);
        }

        .spec-list {
            display: grid;
            grid-template-columns: 1fr;
            gap: 1rem;
        }

        .spec-item {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            padding: 0.5rem 0;
            border-bottom: 1px dashed #eee;
        }

        .spec-item:last-child {
            border-bottom: none;
        }

        .spec-icon {
            color: var(--accent-color);
            font-size: 1.2rem;
            width: 2rem;
            height: 2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: var(--hover-bg);
            border-radius: 50%;
        }

        .spec-label {
            font-weight: 500;
            margin-right: auto;
        }

        .spec-value {
            font-weight: 600;
            color: #333;
        }
        
        /* Description Styles */
        .bike-description {
            line-height: 1.7;
            color: #555;
        }

        .description-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: var(--accent-color);
        }

        /* Color Selector */
        .color-section {
            margin-top: 2rem;
        }
        
        .color-title {
            font-weight: 600;
            margin-bottom: 1rem;
            font-size: 1.2rem;
            color: var(--accent-color);
        }

        .color-options {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .color-option {
            padding: 0.75rem 1.5rem;
            border: 1px solid var(--border-color);
            border-radius: 0.5rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .color-option:hover {
            border-color: var(--accent-color);
            transform: translateY(-2px);
        }

        .color-option.selected {
            border-color: var(--accent-color);
            background-color: var(--hover-bg);
            color: var(--accent-color);
        }

        /* Features Styles */
        .features-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 2rem;
        }

        .feature-card {
            background-color: var(--card-bg);
            border-radius: 1rem;
            padding: 1.5rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
        }

        .feature-icon {
            font-size: 2.5rem;
            color: var(--accent-color);
            margin-bottom: 1.5rem;
        }

        .feature-title {
            font-weight: 600;
            margin-bottom: 0.8rem;
            font-size: 1.2rem;
        }

        .feature-description {
            color: #666;
            font-size: 0.9rem;
        }

        @media (max-width: 992px) {
            .specs-content {
                grid-template-columns: repeat(2, 1fr);
            }

            .features-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .bike-details-content {
                flex-direction: column;
            }
            
            .left-column, .right-column {
                max-width: 100%;
            }
            
            .image-container {
                height: 350px;
            }
            
            .specs-content {
                grid-template-columns: 1fr;
            }

            .features-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <%@ include file="navigationBar.jsp" %>
 
    <div class="bike-details-container">
        <!-- Two-column layout container -->
        <div class="bike-details-content">
            <!-- Left Column: Image and Tech Specs -->
            <div class="left-column">
                <!-- Bike Image Showcase -->
                <div class="image-showcase">
                    <c:choose>
                        <c:when test="${bike.stockQuantity > 5}">
                            <div class="stock-badge in-stock">
                                <i class="fas fa-check-circle"></i> In Stock
                            </div>
                        </c:when>
                        <c:when test="${bike.stockQuantity > 0}">
                            <div class="stock-badge low-stock">
                                <i class="fas fa-exclamation-circle"></i> Only ${bike.stockQuantity} Left
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="stock-badge out-of-stock">
                                <i class="fas fa-times-circle"></i> Out of Stock
                            </div>
                        </c:otherwise>
                    </c:choose>
                    
                    <div class="image-container">
                        <c:choose>
                            <c:when test="${not empty bikeImage}">
                                <img src="data:image/jpeg;base64,${bikeImage}" alt="${bike.brandName} ${bike.modelName}" class="main-image" id="mainImage">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/assets/images/bike-placeholder.jpg" alt="${bike.brandName} ${bike.modelName}" class="main-image" id="mainImage">
                            </c:otherwise>
                        </c:choose>
                        
                        <div class="image-overlay">
                            <h3 class="overlay-title">${bike.brandName} ${bike.modelName}</h3>
                            <p class="overlay-text">${bike.engineCapacity} | ${bike.power}</p>
                        </div>
                    </div>
                </div>
                
                <!-- Technical Specifications -->
                <div class="section-card">
                    <div class="section-header">
                        <h2 class="section-title">Technical Specifications</h2>
                    </div>
                    <div class="specs-content">
                        <!-- Engine Specs -->
                        <div class="spec-group">
                            <h3 class="spec-title">Engine & Performance</h3>
                            <div class="spec-list">
                                <div class="spec-item">
                                    <div class="spec-icon"><i class="fas fa-tachometer-alt"></i></div>
                                    <span class="spec-label">Engine Capacity</span>
                                    <span class="spec-value">${bike.engineCapacity}</span>
                                </div>
                                <div class="spec-item">
                                    <div class="spec-icon"><i class="fas fa-bolt"></i></div>
                                    <span class="spec-label">Power</span>
                                    <span class="spec-value">${bike.power}</span>
                                </div>
                                <div class="spec-item">
                                    <div class="spec-icon"><i class="fas fa-cog"></i></div>
                                    <span class="spec-label">Torque</span>
                                    <span class="spec-value">${bike.torque}</span>
                                </div>
                                <div class="spec-item">
                                    <div class="spec-icon"><i class="fas fa-tachometer-alt"></i></div>
                                    <span class="spec-label">Top Speed</span>
                                    <span class="spec-value">${bike.topSpeed}</span>
                                </div>
                                <div class="spec-item">
                                    <div class="spec-icon"><i class="fas fa-gas-pump"></i></div>
                                    <span class="spec-label">Fuel Type</span>
                                    <span class="spec-value">${bike.fuelType}</span>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Transmission & Drivetrain -->
                        <div class="spec-group">
                            <h3 class="spec-title">Transmission & Chassis</h3>
                            <div class="spec-list">
                                <div class="spec-item">
                                    <div class="spec-icon"><i class="fas fa-cogs"></i></div>
                                    <span class="spec-label">Transmission</span>
                                    <span class="spec-value">${bike.transmission}</span>
                                </div>
                                <div class="spec-item">
                                    <div class="spec-icon"><i class="fas fa-snowflake"></i></div>
                                    <span class="spec-label">Cooling System</span>
                                    <span class="spec-value">${bike.coolingSystem}</span>
                                </div>
                                <div class="spec-item">
                                    <div class="spec-icon"><i class="fas fa-th"></i></div>
                                    <span class="spec-label">Braking System</span>
                                    <span class="spec-value">${bike.brakeType}</span>
                                </div>
                                <div class="spec-item">
                                    <div class="spec-icon"><i class="fas fa-sort"></i></div>
                                    <span class="spec-label">Suspension</span>
                                    <span class="spec-value">${bike.suspensionType}</span>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Dimensions & Weight -->
                        <div class="spec-group">
                            <h3 class="spec-title">Dimensions & Capacity</h3>
                            <div class="spec-list">
                                <div class="spec-item">
                                    <div class="spec-icon"><i class="fas fa-weight"></i></div>
                                    <span class="spec-label">Kerb Weight</span>
                                    <span class="spec-value">${bike.kerbWeight}</span>
                                </div>
                                <div class="spec-item">
                                    <div class="spec-icon"><i class="fas fa-ruler-vertical"></i></div>
                                    <span class="spec-label">Seat Height</span>
                                    <span class="spec-value">${bike.seatHeight}</span>
                                </div>
                                <div class="spec-item">
                                    <div class="spec-icon"><i class="fas fa-gas-pump"></i></div>
                                    <span class="spec-label">Fuel Capacity</span>
                                    <span class="spec-value">${bike.fuelTankCapacity}</span>
                                </div>
                                <div class="spec-item">
                                    <div class="spec-icon"><i class="fas fa-road"></i></div>
                                    <span class="spec-label">Mileage</span>
                                    <span class="spec-value">${bike.mileage}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Right Column: Details, Price, and Action Buttons -->
            <div class="right-column">
                <!-- Bike Header with Title and Details -->
                <div class="bike-header">
                    <div class="bike-title-section">
                        <h1 class="bike-title">${bike.brandName} ${bike.modelName}</h1>
                        <p class="bike-subtitle">${bike.type} Bike</p>
                    </div>
                    
                    <div class="price-section">
                        <div class="bike-price">₹${bike.formattedPrice}</div>
                    </div>
                    
                    <div class="action-section">
                        <c:choose>
                            <c:when test="${bike.stockQuantity > 0}">
                                <a href="${pageContext.request.contextPath}/user/payment.jsp?bikeId=${bike.bikeId}" class="action-button btn-primary">
                                    <i class="fas fa-shopping-cart"></i>
                                    Proceed to Pay
                                </a>
                            </c:when>
                            <c:otherwise>
                                <button class="action-button btn-disabled" disabled>
                                    <i class="fas fa-times-circle"></i>
                                    Out of Stock
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <!-- Color Options -->
                    <div class="color-section">
                        <h3 class="color-title">Available Colors</h3>
                        <div class="color-options">
                            <div class="color-option selected">${bike.color}</div>
                            <c:if test="${not empty bike.color}">
                                <div class="color-option">Other Colors</div>
                            </c:if>
                        </div>
                    </div>
                </div>
                
                <!-- Description Section if available -->
                <c:if test="${not empty bike.description}">
                    <div class="section-card">
                        <div class="section-header">
                            <h2 class="section-title">About this Bike</h2>
                        </div>
                        <div class="bike-description">
                            <p>${bike.description}</p>
                        </div>
                    </div>
                </c:if>
                
                <!-- Additional Information -->
                <div class="section-card">
                    <div class="section-header">
                        <h2 class="section-title">Key Features</h2>
                    </div>
                    <div class="spec-list">
                        <div class="spec-item">
                            <div class="spec-icon"><i class="fas fa-tachometer-alt"></i></div>
                            <span class="spec-label">Color</span>
                            <span class="spec-value">${bike.color}</span>
                        </div>
                        <div class="spec-item">
                            <div class="spec-icon"><i class="fas fa-shield-alt"></i></div>
                            <span class="spec-label">Braking System</span>
                            <span class="spec-value">${bike.brakeType}</span>
                        </div>
                        <div class="spec-item">
                            <div class="spec-icon"><i class="fas fa-bolt"></i></div>
                            <span class="spec-label">Power</span>
                            <span class="spec-value">${bike.power}</span>
                        </div>
                        <div class="spec-item">
                            <div class="spec-icon"><i class="fas fa-road"></i></div>
                            <span class="spec-label">Top Speed</span>
                            <span class="spec-value">${bike.topSpeed}</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Bottom Section for Features - Full Width -->
        <div class="section-card">
            <div class="section-header">
                <h2 class="section-title">Why Choose This Bike</h2>
            </div>
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <h3 class="feature-title">Safety First</h3>
                    <p class="feature-description">Advanced ${bike.brakeType} braking system with precise control for enhanced safety in all riding conditions.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-tools"></i>
                    </div>
                    <h3 class="feature-title">Easy Maintenance</h3>
                    <p class="feature-description">Engineered for simple maintenance with easy access to service points, reducing downtime and costs.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-bolt"></i>
                    </div>
                    <h3 class="feature-title">Power & Efficiency</h3>
                    <p class="feature-description">Powerful ${bike.engineCapacity} engine delivers exceptional performance while maintaining excellent fuel efficiency.</p>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Color selection
        const colorOptions = document.querySelectorAll('.color-option');
        colorOptions.forEach(option => {
            option.addEventListener('click', () => {
                colorOptions.forEach(v => v.classList.remove('selected'));
                option.classList.add('selected');
            });
        });
    </script>
</body>
</html> 