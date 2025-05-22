<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HIDASA Bikes - My Orders</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary: #FF0B55;
            --primary-light: #FFDEDE;
            --primary-dark: #CF0F47;
            --secondary: #333;
            --background: #f9f9f9;
            --card-bg: #FFFFFF;
            --border: #e8e8e8;
            --text-dark: #333;
            --text-light: #777;
            --text-white: #fff;
            --shadow: 0 2px 8px rgba(0,0,0,0.1);
            --shadow-hover: 0 5px 15px rgba(0,0,0,0.15);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background-color: var(--background);
            color: var(--text-dark);
        }

        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
            margin-top: 6rem;
        }

        /* Search bar and filters */
        .search-container {
            background: var(--card-bg);
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 3rem;
            box-shadow: var(--shadow);
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            align-items: center;
        }

        .search-box {
            flex: 1;
            position: relative;
            min-width: 250px;
        }

        .search-box input {
            width: 100%;
            padding: 0.8rem 1rem 0.8rem 2.5rem;
            border: 1px solid var(--border);
            border-radius: 8px;
            font-size: 0.95rem;
        }

        .search-box i {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-light);
        }

        .search-box input:focus {
            outline: none;
            border-color: var(--primary);
        }

        .filter-dropdown {
            min-width: 150px;
            padding: 0.8rem;
            border: 1px solid var(--border);
            border-radius: 8px;
            background-color: var(--card-bg);
            color: var(--text-dark);
            cursor: pointer;
        }

        .filter-dropdown:focus {
            outline: none;
            border-color: var(--primary);
        }

        /* Orders section */
        .orders-section {
            position: relative;
        }

        .orders-header {
            margin-bottom: 1.5rem;
        }

        .orders-header h2 {
            font-size: 1.5rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .orders-header i {
            color: var(--primary);
        }

        /* Orders card grid */
        .orders-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 1.5rem;
        }

        .order-card {
            background: var(--card-bg);
            border-radius: 12px;
            overflow: hidden;
            box-shadow: var(--shadow);
            transition: var(--transition);
            position: relative;
        }

        .order-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-hover);
        }

        .order-image {
            height: 180px;
            overflow: hidden;
            position: relative;
        }

        .order-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: var(--transition);
        }

        .order-card:hover .order-image img {
            transform: scale(1.05);
        }

        .order-id-badge {
            position: absolute;
            top: 1rem;
            left: 1rem;
            background-color: var(--primary);
            color: var(--text-white);
            padding: 0.3rem 0.7rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
            z-index: 1;
        }

        .order-status {
            position: absolute;
            top: 1rem;
            right: 1rem;
            border-radius: 20px;
            padding: 0.3rem 0.7rem;
            font-size: 0.75rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.25rem;
            z-index: 1;
        }

        .status-pending {
            background-color: #FFF7E6;
            color: #F59E0B;
        }

        .status-processed {
            background-color: #E0F2FE;
            color: #0EA5E9;
        }

        .status-shipped {
            background-color: #E0E7FF;
            color: #4F46E5;
        }

        .status-delivered {
            background-color: #DCFCE7;
            color: #16A34A;
        }

        .status-cancelled {
            background-color: #FEE2E2;
            color: #EF4444;
        }

        .order-details {
            padding: 1.5rem;
        }

        .order-info {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
        }

        .bike-info h3 {
            font-size: 1.1rem;
            margin-bottom: 0.25rem;
        }

        .bike-brand {
            color: var(--text-light);
            font-size: 0.9rem;
        }

        .order-quantity {
            background-color: var(--primary-light);
            color: var(--primary-dark);
            padding: 0.3rem 0.7rem;
            border-radius: 50%;
            display: inline-block;
            text-align: center;
            font-weight: 500;
            font-size: 0.9rem;
        }

        .order-price {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 0.5rem;
        }

        .order-date {
            color: var(--text-light);
            font-size: 0.9rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .order-actions {
            display: flex;
            gap: 0.5rem;
        }

        .btn {
            padding: 0.6rem 1rem;
            border-radius: 8px;
            font-weight: 500;
            font-size: 0.9rem;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            cursor: pointer;
            transition: var(--transition);
            border: none;
            text-decoration: none;
        }

        .btn-primary {
            background-color: var(--primary);
            color: var(--text-white);
            flex: 1;
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
        }

        .btn-outline {
            background-color: transparent;
            color: var(--primary);
            border: 1px solid var(--primary);
            flex: 1;
        }

        .btn-outline:hover {
            background-color: var(--primary-light);
        }

        .btn-cancel {
            background-color: #FEE2E2;
            color: #EF4444;
        }

        .btn-cancel:hover {
            background-color: #FCA5A5;
        }

        /* Empty state */
        .empty-orders {
            background: var(--card-bg);
            border-radius: 12px;
            box-shadow: var(--shadow);
            padding: 4rem 2rem;
            text-align: center;
            margin-top: 1rem;
        }

        .empty-icon {
            font-size: 4rem;
            color: var(--primary-light);
            margin-bottom: 1.5rem;
        }

        .empty-title {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
            color: var(--text-dark);
        }

        .empty-text {
            color: var(--text-light);
            margin-bottom: 2rem;
        }

        .btn-large {
            padding: 0.8rem 2rem;
            font-size: 1rem;
        }

        /* Order timeline indicators */
        .order-timeline {
            display: flex;
            justify-content: space-between;
            margin: 1.5rem 0;
            position: relative;
        }

        .order-timeline::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 2px;
            background-color: var(--border);
            transform: translateY(-50%);
            z-index: 0;
        }

        .timeline-step {
            position: relative;
            z-index: 1;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            background-color: var(--border);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .timeline-step.active {
            background-color: var(--primary);
        }

        .timeline-step.active ~ .timeline-step {
            background-color: var(--border);
        }

        .timeline-step i {
            color: var(--text-white);
            font-size: 0.7rem;
        }

        /* Responsive design */
        @media (max-width: 992px) {
            .orders-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .search-container {
                flex-direction: column;
                align-items: stretch;
            }
            
            .search-box, .filter-dropdown {
                width: 100%;
            }
            
            .orders-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <%@ include file="navigationBar.jsp" %>

    <div class="container">
        <!-- Search and filters -->
        <div class="search-container">
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="Search by Order ID or Bike Name...">
            </div>
            <select class="filter-dropdown">
                <option value="all">All Orders</option>
                <option value="pending">Pending</option>
                <option value="processed">Processed</option>
                <option value="shipped">Shipped</option>
                <option value="delivered">Delivered</option>
                <option value="cancelled">Cancelled</option>
            </select>
            <select class="filter-dropdown">
                <option value="all">All Time</option>
                <option value="week">Last 7 Days</option>
                <option value="month">Last 30 Days</option>
                <option value="year">Last Year</option>
            </select>
        </div>

        <!-- Order history section -->
        <div class="orders-section">
            <div class="orders-header">
                <h2><i class="fas fa-box-open"></i> My Orders</h2>
            </div>

            <c:choose>
                <c:when test="${not empty orders}">
                    <div class="orders-grid">
                        <c:forEach var="order" items="${orders}">
                            <div class="order-card">
                                <c:forEach var="detail" items="${order.orderDetails}" varStatus="status">
                                    <c:if test="${status.first}">
                                        <div class="order-image">
                                            <c:choose>
                                                <c:when test="${not empty detail.bike.base64Image}">
                                                    <img src="data:image/jpeg;base64,${detail.bike.base64Image}" alt="${detail.bike.brandName} ${detail.bike.modelName}">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="../assets/images/hidasa${(detail.bike.bikeId % 3) + 1}.jpg" alt="${detail.bike.brandName} ${detail.bike.modelName}">
                                                </c:otherwise>
                                            </c:choose>
                                            <div class="order-id-badge">#ORD${order.orderId}</div>
                                            
                                            <!-- Order status badge -->
                                            <c:choose>
                                                <c:when test="${order.status eq 'Pending'}">
                                                    <div class="order-status status-pending">
                                                        <i class="fas fa-clock"></i> Pending
                                                    </div>
                                                </c:when>
                                                <c:when test="${order.status eq 'Processed'}">
                                                    <div class="order-status status-processed">
                                                        <i class="fas fa-cog"></i> Processed
                                                    </div>
                                                </c:when>
                                                <c:when test="${order.status eq 'Shipped'}">
                                                    <div class="order-status status-shipped">
                                                        <i class="fas fa-truck"></i> Shipped
                                                    </div>
                                                </c:when>
                                                <c:when test="${order.status eq 'Delivered'}">
                                                    <div class="order-status status-delivered">
                                                        <i class="fas fa-check-circle"></i> Delivered
                                                    </div>
                                                </c:when>
                                                <c:when test="${order.status eq 'Cancelled'}">
                                                    <div class="order-status status-cancelled">
                                                        <i class="fas fa-times-circle"></i> Cancelled
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="order-status status-pending">
                                                        <i class="fas fa-circle"></i> ${order.status}
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </c:if>
                                </c:forEach>

                                <div class="order-details">
                                    <c:forEach var="detail" items="${order.orderDetails}" varStatus="status">
                                        <c:if test="${status.first}">
                                            <div class="order-info">
                                                <div class="bike-info">
                                                    <h3>${detail.bike.modelName}</h3>
                                                    <div class="bike-brand">${detail.bike.brandName}</div>
                                                </div>
                                                <div class="order-quantity">${detail.quantity}</div>
                                            </div>
                                        </c:if>
                                    </c:forEach>

                                    <div class="order-price">₹${order.formattedTotal}</div>
                                    <div class="order-date">
                                        <i class="far fa-calendar-alt"></i> Ordered on ${order.formattedDate}
                                    </div>

                                    <!-- Order progress timeline for non-cancelled orders -->
                                    <c:if test="${order.status ne 'Cancelled'}">
                                        <div class="order-timeline">
                                            <div class="timeline-step active">
                                                <i class="fas fa-check"></i>
                                            </div>
                                            <div class="timeline-step ${order.status eq 'Processed' || order.status eq 'Shipped' || order.status eq 'Delivered' ? 'active' : ''}">
                                                <i class="fas fa-check"></i>
                                            </div>
                                            <div class="timeline-step ${order.status eq 'Shipped' || order.status eq 'Delivered' ? 'active' : ''}">
                                                <i class="fas fa-check"></i>
                                            </div>
                                            <div class="timeline-step ${order.status eq 'Delivered' ? 'active' : ''}">
                                                <i class="fas fa-check"></i>
                                            </div>
                                        </div>
                                    </c:if>
                                    
                                    <div class="order-actions">
                                        <a href="order-details?id=${order.orderId}" class="btn btn-primary">
                                            <i class="fas fa-eye"></i> View Details
                                        </a>
                                        <c:if test="${order.status eq 'Delivered'}">
                                            <a href="#" class="btn btn-outline">
                                                <i class="fas fa-redo"></i> Reorder
                                            </a>
                                        </c:if>
                                        <c:if test="${order.status eq 'Pending'}">
                                            <form action="myorders" method="post" style="flex: 1;">
                                                <input type="hidden" name="action" value="cancel">
                                                <input type="hidden" name="orderId" value="${order.orderId}">
                                                <button type="submit" class="btn btn-cancel" style="width: 100%;" onclick="return confirm('Are you sure you want to cancel this order?')">
                                                    <i class="fas fa-times"></i> Cancel
                                                </button>
                                            </form>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-orders">
                        <i class="fas fa-shopping-bag empty-icon"></i>
                        <h3 class="empty-title">No orders found</h3>
                        <p class="empty-text">You haven't placed any orders yet. Start shopping to see your orders here.</p>
                        <a href="${pageContext.request.contextPath}/bikes" class="btn btn-primary btn-large">
                            <i class="fas fa-motorcycle"></i> Browse Bikes
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
        // JavaScript for filtering and search functionality
        document.addEventListener('DOMContentLoaded', function() {
            // Add event listeners for filters
            const searchInput = document.querySelector('.search-box input');
            const statusFilter = document.querySelector('.filter-dropdown');
            
            // Search functionality
            searchInput.addEventListener('keyup', function() {
                const searchTerm = this.value.toLowerCase();
                const orderCards = document.querySelectorAll('.order-card');
                
                orderCards.forEach(card => {
                    const orderId = card.querySelector('.order-id-badge').textContent.toLowerCase();
                    const bikeName = card.querySelector('.bike-info h3').textContent.toLowerCase();
                    
                    if (orderId.includes(searchTerm) || bikeName.includes(searchTerm)) {
                        card.style.display = '';
                    } else {
                        card.style.display = 'none';
                    }
                });
                
                // Show empty state if no results
                checkEmptyResults();
            });
            
            // Status filter functionality
            statusFilter.addEventListener('change', function() {
                const status = this.value.toLowerCase();
                const orderCards = document.querySelectorAll('.order-card');
                
                orderCards.forEach(card => {
                    if (status === 'all') {
                        card.style.display = '';
                        return;
                    }
                    
                    const statusBadge = card.querySelector('.order-status');
                    if (statusBadge.textContent.toLowerCase().includes(status)) {
                        card.style.display = '';
                    } else {
                        card.style.display = 'none';
                    }
                });
                
                // Show empty state if no results
                checkEmptyResults();
            });
            
            // Check if there are any visible results
            function checkEmptyResults() {
                const visibleCards = document.querySelectorAll('.order-card[style="display: none;"]');
                const ordersGrid = document.querySelector('.orders-grid');
                const emptyOrders = document.querySelector('.empty-orders');
                
                if (visibleCards.length === document.querySelectorAll('.order-card').length) {
                    // No visible cards
                    if (ordersGrid) ordersGrid.style.display = 'none';
                    if (emptyOrders) {
                        emptyOrders.style.display = 'block';
                        emptyOrders.querySelector('.empty-title').textContent = 'No matching orders found';
                        emptyOrders.querySelector('.empty-text').textContent = 'Try adjusting your search or filter criteria';
                    }
                } else {
                    // Some cards are visible
                    if (ordersGrid) ordersGrid.style.display = 'grid';
                    if (emptyOrders) emptyOrders.style.display = 'none';
                }
            }
        });
    </script>
</body>
</html>