<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HIDASA Bikes - Find Your Perfect Ride</title>

   <style>
   
    /* Bikes Page Specific Styles */
    .bikes-hero {
        position: relative;
        width: 100%;
        height: 380px;
        background: url('${pageContext.request.contextPath}/assets/images/bikehead.png') center center/cover no-repeat;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-top: var(--header-height);
    }
    
    .bikes-hero-overlay {
        width: 100%;
        height: 100%;
        background: rgba(30, 30, 30, 0.5);
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        padding: 0 20px;
    }
    
    .bikes-title {
        color: #fff;
        font-size: 3.5rem;
        font-weight: 700;
        margin-bottom: 1rem;
        text-align: center;
    }
    
    .bikes-subtitle {
        color: #fff;
        font-size: 1.25rem;
        text-align: center;
        max-width: 700px;
        margin-bottom: 2rem;
    }
    
    .search-bar {
        width: 100%;
        max-width: 650px;
        position: relative;
    }
    
    .search-input {
        width: 100%;
        padding: 15px 20px;
        border-radius: 30px;
        border: none;
        font-size: 1.1rem;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }
    
    .search-button {
        position: absolute;
        top: 5px;
        right: 5px;
        bottom: 5px;
        width: 50px;
        background: #FF0B55;
        border: none;
        border-radius: 25px;
        color: white;
        cursor: pointer;
        transition: all 0.3s ease;
    }
    
    .search-button:hover {
        background: #d4074a;
    }
    
    /* Filter Section */
    .filter-section {
        background: white;
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        padding: 20px 30px;
        margin: -30px auto 40px;
        max-width: 1200px;
        display: flex;
        flex-wrap: wrap;
        align-items: center;
        justify-content: space-between;
        gap: 15px;
        z-index: 10;
        position: relative;
    }
    
    .filter-group {
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .filter-label {
        font-weight: 600;
        color: #333;
        min-width: 60px;
    }
    
    .filter-select {
        padding: 10px 15px;
        border-radius: 5px;
        border: 1px solid #ddd;
        background: #f8f8f8;
        min-width: 140px;
    }
    
    .apply-filters-button {
        background: #FF0B55;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 8px;
        font-weight: 500;
        transition: all 0.3s ease;
    }
    
    .apply-filters-button:hover {
        background: #d4074a;
        transform: translateY(-2px);
    }
    
    /* Bikes Section */
    .bikes-content {
        padding: 20px 0 60px;
    }
    
    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 20px;
    }
    
    .section-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
    }
    
    .section-title {
        font-size: 2rem;
        font-weight: 700;
        color: #222;
        position: relative;
        padding-bottom: 10px;
    }
    
    .section-title::after {
        content: '';
        position: absolute;
        left: 0;
        bottom: 0;
        width: 60px;
        height: 4px;
        background: #FF0B55;
        border-radius: 2px;
    }
    
    .view-all {
        color: #FF0B55;
        text-decoration: none;
        font-weight: 500;
        display: flex;
        align-items: center;
        gap: 5px;
        transition: all 0.3s ease;
    }
    
    .view-all:hover {
        color: #d4074a;
    }
    
    /* Bikes Grid */
    .bikes-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        gap: 30px;
    }
    
    .bike-card {
        background: #fff;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        transition: all 0.3s ease;
        position: relative;
    }
    
    .bike-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 25px rgba(0,0,0,0.15);
    }
    
    .bike-image {
        height: 200px;
        width: 100%;
        object-fit: cover;
    }
    
    .bike-stock-tag {
        position: absolute;
        top: 15px;
        left: 15px;
        background: #FF0B55;
        color: white;
        padding: 5px 10px;
        font-size: 0.8rem;
        border-radius: 4px;
        font-weight: 500;
    }
    
    .bike-details {
        padding: 20px;
    }
    
    .bike-brand {
        color: #666;
        font-size: 0.9rem;
        margin-bottom: 5px;
    }
    
    .bike-model {
        font-size: 1.2rem;
        font-weight: 600;
        margin-bottom: 10px;
        color: #222;
    }
    
    .bike-specs {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 10px;
        margin-bottom: 15px;
    }
    
    .bike-spec {
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    .bike-spec i {
        color: #FF0B55;
        font-size: 1rem;
    }
    
    .bike-spec-text {
        font-size: 0.9rem;
        color: #444;
    }
    
    .bike-price {
        font-size: 1.3rem;
        font-weight: 700;
        color: #222;
        margin-bottom: 15px;
    }
    
    .bike-actions {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 10px;
    }
    
    .view-details-button {
        flex: 1;
        text-align: center;
        padding: 10px;
        background: #f8f8f8;
        color: #222;
        text-decoration: none;
        border-radius: 5px;
        transition: all 0.3s ease;
    }
    
    .view-details-button:hover {
        background: #eee;
    }
    
    .add-to-cart-button {
        flex: 1;
        text-align: center;
        padding: 10px;
        background: #FF0B55;
        color: white;
        text-decoration: none;
        border-radius: 5px;
        transition: all 0.3s ease;
    }
    
    .add-to-cart-button:hover {
        background: #d4074a;
    }
    
    /* Pagination */
    .pagination {
        display: flex;
        justify-content: center;
        margin-top: 40px;
        gap: 10px;
    }
    
    .page-item {
        width: 40px;
        height: 40px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 5px;
        border: 1px solid #ddd;
        background: #fff;
        color: #222;
        text-decoration: none;
        transition: all 0.3s ease;
    }
    
    .page-item.active,
    .page-item:hover {
        background: #FF0B55;
        color: white;
        border-color: #FF0B55;
    }
    
    .page-item.disabled {
        opacity: 0.5;
        cursor: not-allowed;
    }
    
    /* Responsive */
    @media (max-width: 900px) {
        .filter-section {
            flex-direction: column;
            align-items: flex-start;
        }
        
        .bike-specs {
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

<!-- Hero Section -->
<div class="bikes-hero">
    <div class="bikes-hero-overlay">
        <h1 class="bikes-title">Find Your Perfect Ride</h1>
        <p class="bikes-subtitle">Explore our collection of premium bikes for every style and need</p>
        <form action="${pageContext.request.contextPath}/bikes" method="GET" class="search-bar">
            <input type="text" name="search" placeholder="Search by model, brand, or type..." class="search-input" value="${param.search}">
            <button type="submit" class="search-button">
                <i class="fas fa-search"></i>
            </button>
        </form>
    </div>
</div>

<!-- Filter Section -->
<form action="${pageContext.request.contextPath}/bikes" method="GET" class="filter-section">
    <div class="filter-group">
        <span class="filter-label">Brand:</span>
        <select name="brand" class="filter-select">
            <option value="">All Brands</option>
            <c:forEach items="${brandsList}" var="brand">
                <option value="${brand}" ${param.brand eq brand ? 'selected' : ''}>${brand}</option>
            </c:forEach>
        </select>
    </div>
    
    <div class="filter-group">
        <span class="filter-label">Type:</span>
        <select name="type" class="filter-select">
            <option value="">All Types</option>
            <c:forEach items="${typesList}" var="type">
                <option value="${type}" ${param.type eq type ? 'selected' : ''}>${type}</option>
            </c:forEach>
        </select>
    </div>
    
    <div class="filter-group">
        <span class="filter-label">Price:</span>
        <select name="price" class="filter-select">
            <option value="">All Prices</option>
            <option value="0-100000" ${param.price eq '0-100000' ? 'selected' : ''}>Under ₹1,00,000</option>
            <option value="100000-200000" ${param.price eq '100000-200000' ? 'selected' : ''}>₹1,00,000 - ₹2,00,000</option>
            <option value="200000-500000" ${param.price eq '200000-500000' ? 'selected' : ''}>₹2,00,000 - ₹5,00,000</option>
            <option value="500000-9999999" ${param.price eq '500000-9999999' ? 'selected' : ''}>Above ₹5,00,000</option>
        </select>
    </div>
    
    <div class="filter-group">
        <span class="filter-label">Sort:</span>
        <select name="sort" class="filter-select">
            <option value="popular" ${param.sort eq 'popular' || param.sort == null ? 'selected' : ''}>Popular</option>
            <option value="price_low" ${param.sort eq 'price_low' ? 'selected' : ''}>Price: Low to High</option>
            <option value="price_high" ${param.sort eq 'price_high' ? 'selected' : ''}>Price: High to Low</option>
            <option value="newest" ${param.sort eq 'newest' ? 'selected' : ''}>Newest First</option>
        </select>
    </div>
    
    <button type="submit" class="apply-filters-button">
        <i class="fas fa-filter"></i> Apply Filters
    </button>
</form>

<!-- Bikes Section -->
<section class="bikes-content">
    <div class="container">
        <div class="section-header">
            <h2 class="section-title">All Bikes</h2>
            <a href="${pageContext.request.contextPath}/bikes" class="view-all">View All <i class="fas fa-arrow-right"></i></a>
        </div>
        
        <div class="bikes-grid">
            <c:if test="${empty bikesList}">
                <div style="grid-column: 1 / -1; text-align: center; padding: 40px 0;">
                    <h3>No bikes found matching your criteria.</h3>
                    <p>Try adjusting your filters or search term.</p>
                </div>
            </c:if>
            
            <c:forEach items="${bikesList}" var="bike">
                <div class="bike-card">
                    <c:if test="${bike.stockQuantity < 5 && bike.stockQuantity > 0}">
                        <div class="bike-stock-tag">Low Stock</div>
                    </c:if>
                    <c:if test="${bike.stockQuantity == 0}">
                        <div class="bike-stock-tag" style="background: #888;">Out of Stock</div>
                    </c:if>
                    
                    <img src="data:image/jpeg;base64,${bike.base64Image}" alt="${bike.brandName} ${bike.modelName}" class="bike-image" onerror="this.src='${pageContext.request.contextPath}/assets/images/bike-placeholder.jpg'">
                    
                    <div class="bike-details">
                        <div class="bike-brand">${bike.brandName}</div>
                        <h3 class="bike-model">${bike.modelName}</h3>
                        
                        <div class="bike-specs">
                            <div class="bike-spec">
                                <i class="fas fa-tachometer-alt"></i>
                                <span class="bike-spec-text">${bike.engineCapacity}</span>
                            </div>
                            <div class="bike-spec">
                                <i class="fas fa-bolt"></i>
                                <span class="bike-spec-text">${bike.power}</span>
                            </div>
                            <div class="bike-spec">
                                <i class="fas fa-gas-pump"></i>
                                <span class="bike-spec-text">${bike.fuelType}</span>
                            </div>
                            <div class="bike-spec">
                                <i class="fas fa-cog"></i>
                                <span class="bike-spec-text">${bike.transmission}</span>
                            </div>
                        </div>
                        
                        <div class="bike-price">₹${bike.formattedPrice}</div>
                        
                        <div class="bike-actions">
                            <a href="${pageContext.request.contextPath}/bike-details?id=${bike.bikeId}" class="view-details-button" title="View details of ${bike.brandName} ${bike.modelName}">View Details</a>
                            <c:if test="${bike.stockQuantity > 0}">
                                <a href="#" onclick="checkLoginBeforeBuy(${bike.bikeId}, event)" class="add-to-cart-button">Buy Now</a>
                            </c:if>
                            <c:if test="${bike.stockQuantity == 0}">
                                <a href="#" class="add-to-cart-button" style="background: #888; cursor: not-allowed;">Sold Out</a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <!-- Pagination -->
        <c:if test="${not empty bikesList && totalPages > 1}">
            <div class="pagination">
                <a href="${pageContext.request.contextPath}/bikes?page=${currentPage - 1}${searchParams}" class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <i class="fas fa-chevron-left"></i>
                </a>
                
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <a href="${pageContext.request.contextPath}/bikes?page=${i}${searchParams}" class="page-item ${currentPage == i ? 'active' : ''}">${i}</a>
                </c:forEach>
                
                <a href="${pageContext.request.contextPath}/bikes?page=${currentPage + 1}${searchParams}" class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <i class="fas fa-chevron-right"></i>
                </a>
            </div>
        </c:if>
    </div>
</section>

<%@ include file="footer.jsp" %>

<script>
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
    
    // Close modal when clicking the X or Cancel button
    document.addEventListener('DOMContentLoaded', function() {
        // Close button handlers
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
</script>

</body>
</html>