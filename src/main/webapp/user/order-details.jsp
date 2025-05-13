<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Details | HIDASA Bikes</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
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
            --success: #10B981;
            --warning: #F59E0B;
            --info: #3B82F6;
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
            max-width: 1100px;
            margin: 0 auto;
            padding: 2rem 1rem;
            margin-top: 6rem;
        }
        
        .message-box {
            margin-bottom: 1.5rem;
            padding: 1rem;
            border-radius: 8px;
            font-weight: 500;
        }
        
        .success-message {
            background-color: #DCFCE7;
            color: var(--success);
            border: 1px solid #86EFAC;
        }
        
        .error-message {
            background-color: #FEE2E2;
            color: #EF4444;
            border: 1px solid #FCA5A5;
        }
        
        .order-details-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 2rem;
        }
        
        .order-details-title {
            font-size: 1.5rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .order-details-title i {
            color: var(--primary);
        }
        
        .back-button {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            background-color: var(--text-light);
            color: white;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .back-button:hover {
            background-color: var(--secondary);
        }
        
        .order-container {
            display: flex;
            flex-wrap: wrap;
            gap: 2rem;
        }
        
        .order-summary {
            flex: 1;
            min-width: 300px;
        }
        
        .order-tracking {
            flex: 1;
            min-width: 300px;
        }
        
        .order-card {
            background-color: var(--card-bg);
            border-radius: 12px;
            box-shadow: var(--shadow);
            padding: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .card-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .card-title i {
            color: var(--primary);
        }
        
        .order-info {
            margin-bottom: 1.5rem;
        }
        
        .info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.8rem;
            padding-bottom: 0.8rem;
            border-bottom: 1px solid var(--border);
        }
        
        .info-row:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }
        
        .info-label {
            color: var(--text-light);
            font-weight: 500;
        }
        
        .info-value {
            font-weight: 600;
            text-align: right;
        }
        
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
        }
        
        .status-pending {
            background-color: #FFF7E6;
            color: #F59E0B;
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
        
        .bike-list {
            margin-top: 1rem;
        }
        
        .bike-item {
            display: flex;
            gap: 1rem;
            padding: 1rem 0;
            border-bottom: 1px solid var(--border);
        }
        
        .bike-item:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }
        
        .bike-img {
            width: 80px;
            height: 60px;
            border-radius: 8px;
            object-fit: cover;
        }
        
        .bike-details {
            flex: 1;
        }
        
        .bike-name {
            font-weight: 600;
            margin-bottom: 0.3rem;
        }
        
        .bike-price {
            color: var(--text-light);
            font-size: 0.9rem;
        }
        
        .bike-quantity {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            justify-content: center;
        }
        
        .quantity-badge {
            background-color: var(--primary-light);
            color: var(--primary-dark);
            padding: 0.2rem 0.5rem;
            border-radius: 4px;
            font-weight: 600;
            font-size: 0.9rem;
        }
        
        .total-price {
            color: var(--primary);
            font-weight: 600;
            font-size: 1.1rem;
        }
        
        /* Tracking system styles */
        .tracking-steps {
            position: relative;
            margin: 2rem 0;
        }
        
        .tracking-line {
            position: absolute;
            top: 24px;
            left: 40px;
            width: 4px;
            height: calc(100% - 48px);
            background-color: var(--border);
            z-index: 1;
        }
        
        .tracking-step {
            position: relative;
            display: flex;
            align-items: flex-start;
            padding: 1rem 0;
            z-index: 2;
        }
        
        .step-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--card-bg);
            border: 3px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            flex-shrink: 0;
        }
        
        .step-active .step-icon {
            background-color: var(--primary);
            border-color: var(--primary-light);
            color: white;
        }
        
        .step-completed .step-icon {
            background-color: var(--success);
            border-color: #86EFAC;
            color: white;
        }
        
        .step-cancelled .step-icon {
            background-color: #EF4444;
            border-color: #FCA5A5;
            color: white;
        }
        
        .step-content {
            flex: 1;
        }
        
        .step-title {
            font-weight: 600;
            margin-bottom: 0.2rem;
        }
        
        .step-text {
            color: var(--text-light);
            font-size: 0.9rem;
        }
        
        .step-date {
            font-size: 0.85rem;
            color: var(--text-light);
            margin-top: 0.3rem;
        }
        
        .reorder-btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.8rem 1.5rem;
            background-color: var(--info);
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 1rem;
            text-decoration: none;
        }
        
        .reorder-btn:hover {
            background-color: #2563EB;
        }
        
        .cancel-btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.8rem 1.5rem;
            background-color: #FEE2E2;
            color: #EF4444;
            border: none;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 1rem;
        }
        
        .cancel-btn:hover {
            background-color: #FCA5A5;
        }
        
        /* Modal styles */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0,0,0,0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }
        
        .modal-container {
            background-color: white;
            border-radius: 12px;
            max-width: 400px;
            width: 100%;
            padding: 2rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            position: relative;
        }
        
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }
        
        .modal-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--text-dark);
        }
        
        .modal-close {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 1.2rem;
            color: var(--text-light);
        }
        
        .modal-body {
            margin-bottom: 1.5rem;
        }
        
        .modal-footer {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
        }
        
        .modal-btn {
            padding: 0.6rem 1.2rem;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            border: none;
        }
        
        .modal-btn-cancel {
            background-color: #f1f1f1;
            color: var(--text-dark);
        }
        
        .modal-btn-confirm {
            background-color: var(--primary);
            color: white;
        }
        
        .modal-icon {
            display: flex;
            justify-content: center;
            margin-bottom: 1rem;
        }
        
        .modal-icon i {
            font-size: 3rem;
            color: var(--primary);
        }
        
        @media (max-width: 768px) {
            .order-container {
                flex-direction: column;
            }
            
            .info-row {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .info-value {
                text-align: left;
                margin-top: 0.3rem;
            }
        }
    </style>
</head>
<body>
    <%@ include file="navigationBar.jsp" %>

    <div class="container">
        <c:if test="${not empty message}">
            <div class="message-box success-message">
                <i class="fas fa-check-circle"></i> ${message}
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="message-box error-message">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>

        <div class="order-details-header">
            <h2 class="order-details-title"><i class="fas fa-clipboard-list"></i> Order Details</h2>
            <a href="${pageContext.request.contextPath}/myorders" class="back-button">
                <i class="fas fa-arrow-left"></i> Back to Orders
            </a>
        </div>

        <div class="order-container">
            <div class="order-summary">
                <div class="order-card">
                    <h3 class="card-title"><i class="fas fa-info-circle"></i> Order Information</h3>
                    <div class="order-info">
                        <div class="info-row">
                            <div class="info-label">Order ID</div>
                            <div class="info-value">#ORD${order.orderId}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Order Date</div>
                            <div class="info-value">${order.formattedDate}</div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Status</div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${order.status eq 'Pending'}">
                                        <span class="status-badge status-pending"><i class="fas fa-clock"></i> Pending</span>
                                    </c:when>
                                    <c:when test="${order.status eq 'Shipped'}">
                                        <span class="status-badge status-shipped"><i class="fas fa-truck"></i> Shipped</span>
                                    </c:when>
                                    <c:when test="${order.status eq 'Delivered'}">
                                        <span class="status-badge status-delivered"><i class="fas fa-check-circle"></i> Delivered</span>
                                    </c:when>
                                    <c:when test="${order.status eq 'Cancelled'}">
                                        <span class="status-badge status-cancelled"><i class="fas fa-times-circle"></i> Cancelled</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge status-pending"><i class="fas fa-clock"></i> ${order.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Total Amount</div>
                            <div class="info-value">₹${order.formattedTotal}</div>
                        </div>
                    </div>
                </div>

                <div class="order-card">
                    <h3 class="card-title"><i class="fas fa-motorcycle"></i> Ordered Bikes</h3>
                    <div class="bike-list">
                        <c:forEach var="detail" items="${order.orderDetails}">
                            <div class="bike-item">
                                <c:choose>
                                    <c:when test="${not empty detail.bike.base64Image}">
                                        <img src="data:image/jpeg;base64,${detail.bike.base64Image}" alt="${detail.bike.brandName} ${detail.bike.modelName}" class="bike-img">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="../assets/images/hidasa${(detail.bike.bikeId % 3) + 1}.jpg" alt="${detail.bike.brandName} ${detail.bike.modelName}" class="bike-img">
                                    </c:otherwise>
                                </c:choose>
                                <div class="bike-details">
                                    <div class="bike-name">${detail.bike.brandName} ${detail.bike.modelName}</div>
                                    <div class="bike-price">₹${detail.bike.price}</div>
                                </div>
                                <div class="bike-quantity">
                                    <div class="quantity-badge">Qty: ${detail.quantity}</div>
                                    <div class="total-price">₹${detail.bike.price * detail.quantity}</div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                
                <c:if test="${order.status eq 'Pending'}">
                    <button type="button" class="cancel-btn" onclick="openCancelModal()">
                        <i class="fas fa-times"></i> Cancel Order
                    </button>
                </c:if>
                
                <c:if test="${order.status ne 'Cancelled'}">
                    <form action="${pageContext.request.contextPath}/myorders" method="post" style="display: inline-block;">
                        <input type="hidden" name="action" value="reorder">
                        <input type="hidden" name="orderId" value="${order.orderId}">
                        <button type="submit" class="reorder-btn">
                            <i class="fas fa-redo"></i> Reorder
                        </button>
                    </form>
                </c:if>
            </div>

            <div class="order-tracking">
                <div class="order-card">
                    <h3 class="card-title"><i class="fas fa-truck-loading"></i> Order Tracking</h3>
                    <div class="tracking-steps">
                        <div class="tracking-line"></div>
                        
                        <!-- Order Placed Step -->
                        <div class="tracking-step step-completed">
                            <div class="step-icon">
                                <i class="fas fa-clipboard-check"></i>
                            </div>
                            <div class="step-content">
                                <div class="step-title">Order Placed</div>
                                <div class="step-text">Your order has been placed</div>
                                <div class="step-date">${order.formattedDate}</div>
                            </div>
                        </div>
                        
                        <!-- Order Processing Step -->
                        <div class="tracking-step ${order.status eq 'Cancelled' ? 'step-cancelled' : (order.status eq 'Pending' ? 'step-active' : 'step-completed')}">
                            <div class="step-icon">
                                <i class="fas ${order.status eq 'Cancelled' ? 'fa-times' : 'fa-cog'}"></i>
                            </div>
                            <div class="step-content">
                                <div class="step-title">${order.status eq 'Cancelled' ? 'Order Cancelled' : 'Order Processing'}</div>
                                <div class="step-text">
                                    ${order.status eq 'Cancelled' ? 'Your order has been cancelled' : (order.status eq 'Pending' ? 'Your order is being processed' : 'Your order has been processed')}
                                </div>
                                <c:if test="${order.status eq 'Cancelled'}">
                                    <div class="step-date">
                                        <c:out value="${order.cancelDate != null ? order.cancelDate : 'Recently'}" />
                                    </div>
                                </c:if>
                            </div>
                        </div>
                        
                        <!-- Shipping Step -->
                        <c:if test="${order.status ne 'Cancelled'}">
                            <div class="tracking-step ${order.status eq 'Shipped' ? 'step-active' : (order.status eq 'Delivered' ? 'step-completed' : '')}">
                                <div class="step-icon">
                                    <i class="fas fa-shipping-fast"></i>
                                </div>
                                <div class="step-content">
                                    <div class="step-title">Shipped</div>
                                    <div class="step-text">
                                        ${order.status eq 'Shipped' ? 'Your order is on the way' : (order.status eq 'Delivered' ? 'Your order has been shipped' : 'Your order will be shipped soon')}
                                    </div>
                                    <c:if test="${order.status eq 'Shipped' || order.status eq 'Delivered'}">
                                        <div class="step-date">
                                            <c:out value="${order.shipDate != null ? order.shipDate : 'Recently'}" />
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                            
                            <!-- Delivery Step -->
                            <div class="tracking-step ${order.status eq 'Delivered' ? 'step-completed' : ''}">
                                <div class="step-icon">
                                    <i class="fas fa-home"></i>
                                </div>
                                <div class="step-content">
                                    <div class="step-title">Delivered</div>
                                    <div class="step-text">
                                        ${order.status eq 'Delivered' ? 'Your order has been delivered' : 'Your order will be delivered soon'}
                                    </div>
                                    <c:if test="${order.status eq 'Delivered'}">
                                        <div class="step-date">
                                            <c:out value="${order.deliveryDate != null ? order.deliveryDate : 'Recently'}" />
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Modal for Cancel Order -->
    <div class="modal-overlay" id="cancelOrderModal">
        <div class="modal-container">
            <div class="modal-header">
                <h3 class="modal-title">Cancel Order</h3>
                <button class="modal-close" onclick="closeCancelModal()">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="modal-body">
                <div class="modal-icon">
                    <i class="fas fa-exclamation-circle" style="color: #EF4444;"></i>
                </div>
                <p>Are you sure you want to cancel this order? This action cannot be undone.</p>
            </div>
            <div class="modal-footer">
                <button class="modal-btn modal-btn-cancel" onclick="closeCancelModal()">No, Keep Order</button>
                <form action="${pageContext.request.contextPath}/myorders" method="post">
                    <input type="hidden" name="action" value="cancel">
                    <input type="hidden" name="orderId" value="${order.orderId}">
                    <input type="hidden" name="restoreStock" value="true">
                    <button type="submit" class="modal-btn modal-btn-confirm">Yes, Cancel Order</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        function openCancelModal() {
            document.getElementById('cancelOrderModal').style.display = 'flex';
        }
        
        function closeCancelModal() {
            document.getElementById('cancelOrderModal').style.display = 'none';
        }
        
        // Close modal when clicking outside
        window.addEventListener('click', function(event) {
            const modal = document.getElementById('cancelOrderModal');
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        });
    </script>
</body>
</html>