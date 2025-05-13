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

        /* Order history section */
        .orders-section {
            background: var(--card-bg);
            border-radius: 10px;
            box-shadow: var(--shadow);
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .orders-header {
            padding: 1.5rem;
            display: flex;
            align-items: center;
            border-bottom: 1px solid var(--border);
        }

        .orders-header h2 {
            font-size: 1.3rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 600;
        }

        .orders-header i {
            color: var(--primary);
        }

        /* Orders table */
        .orders-table {
            width: 100%;
            border-collapse: collapse;
        }

        .orders-table th {
            background-color: #f5f5f5;
            text-align: left;
            padding: 1rem;
            font-weight: 500;
            color: var(--text-dark);
            text-transform: uppercase;
            font-size: 0.85rem;
        }

        .orders-table td {
            padding: 1rem;
            border-bottom: 1px solid var(--border);
            vertical-align: middle;
        }

        .orders-table tr:last-child td {
            border-bottom: none;
        }

        .order-id {
            color: var(--primary);
            font-weight: 600;
        }

        /* Bike info cell */
        .bike-details {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .bike-img {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            object-fit: cover;
        }

        .bike-info {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        .bike-name {
            font-weight: 500;
        }

        .bike-model {
            color: var(--text-light);
            font-size: 0.85rem;
        }

        /* Quantity cell */
        .quantity {
            background-color: var(--primary-light);
            color: var(--primary-dark);
            padding: 0.3rem 0.7rem;
            border-radius: 50%;
            display: inline-block;
            text-align: center;
            font-weight: 500;
        }

        /* Price cell */
        .price {
            font-weight: 600;
        }

        /* Status badges */
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

        /* Action buttons */
        .action-btns {
            display: flex;
            gap: 0.5rem;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.4rem;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-size: 0.85rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-view {
            background-color: var(--primary);
            color: var(--text-white);
            border: none;
        }

        .btn-view:hover {
            background-color: var(--primary-dark);
        }

        .btn-cancel {
            background-color: #FEE2E2;
            color: #EF4444;
            border: none;
        }

        .btn-cancel:hover {
            background-color: #FCA5A5;
        }

        /* Empty state */
        .empty-orders {
            padding: 4rem 2rem;
            text-align: center;
        }

        .empty-icon {
            font-size: 3rem;
            color: var(--text-light);
            margin-bottom: 1rem;
        }

        .empty-title {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
        }

        .empty-text {
            color: var(--text-light);
            margin-bottom: 1.5rem;
        }

        .btn-shop {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.8rem 2rem;
            background-color: var(--primary);
            color: var(--text-white);
            border-radius: 8px;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .btn-shop:hover {
            background-color: var(--primary-dark);
        }

        @media (max-width: 768px) {
            .search-container {
                flex-direction: column;
                align-items: stretch;
            }
            
            .search-box, .filter-dropdown {
                width: 100%;
            }
            
            .orders-table {
                display: block;
                overflow-x: auto;
            }
            
            .action-btns {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
            }
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
        
        .btn-reorder {
            background-color: #E0F2FE;
            color: #0EA5E9;
        }
        
        .btn-reorder:hover {
            background-color: #BAE6FD;
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
                <option value="shipped">Shipped</option>
                <option value="delivered">Completed</option>
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
                <h2><i class="fas fa-box"></i> Order History</h2>
                <div style="margin-left: auto;">
                    <button type="button" class="btn btn-cancel" onclick="openBulkDeleteModal()" title="Delete Cancelled Orders" style="margin-left: auto;">
                        <i class="fas fa-trash"></i> Delete Cancelled Orders
                    </button>
                </div>
            </div>

            <table class="orders-table">
                <thead>
                    <tr>
                        <th>ORDER ID</th>
                        <th>BIKE DETAILS</th>
                        <th>QUANTITY</th>
                        <th>PRICE</th>
                        <th>ORDER DATE</th>
                        <th>STATUS</th>
                        <th>ACTIONS</th>
                    </tr>
                </thead>
                <tbody>
                   
                    <c:choose>
                        <c:when test="${not empty orders}">
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td class="order-id">#ORD${order.orderId}</td>
                                    <td>
                                        <c:forEach var="detail" items="${order.orderDetails}" varStatus="status">
                                            <c:if test="${status.first}">
                                                <div class="bike-details">
                                                    <c:choose>
                                                        <c:when test="${not empty detail.bike.base64Image}">
                                                            <img src="data:image/jpeg;base64,${detail.bike.base64Image}" alt="${detail.bike.brandName} ${detail.bike.modelName}" class="bike-img">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="../assets/images/hidasa${(detail.bike.bikeId % 3) + 1}.jpg" alt="${detail.bike.brandName} ${detail.bike.modelName}" class="bike-img">
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <div class="bike-info">
                                                        <div class="bike-name">${detail.bike.modelName}</div>
                                                        <div class="bike-model">${detail.bike.brandName}</div>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </td>
                                    <td>
                                        <c:set var="totalQuantity" value="0" />
                                        <c:forEach var="detail" items="${order.orderDetails}">
                                            <c:set var="totalQuantity" value="${totalQuantity + detail.quantity}" />
                                        </c:forEach>
                                        <span class="quantity">${totalQuantity}</span>
                                    </td>
                                    <td class="price">₹${order.formattedTotal}</td>
                                    <td>${order.formattedDate}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${order.status eq 'Pending'}">
                                                <span class="status-badge status-pending"><i class="fas fa-clock"></i> Pending</span>
                                            </c:when>
                                            <c:when test="${order.status eq 'Shipped'}">
                                                <span class="status-badge status-shipped"><i class="fas fa-truck"></i> Shipped</span>
                                            </c:when>
                                            <c:when test="${order.status eq 'Completed'}">
                                                <span class="status-badge status-delivered"><i class="fas fa-check-circle"></i> Delivered</span>
                                            </c:when>
                                            <c:when test="${order.status eq 'Cancelled'}">
                                                <span class="status-badge status-cancelled"><i class="fas fa-times-circle"></i> Cancelled</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge status-pending"><i class="fas fa-clock"></i> ${order.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="action-btns">
                                            <a href="order-details?id=${order.orderId}" class="btn btn-view" title="View Details">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <c:if test="${order.status eq 'Pending'}">
                                                <button type="button" class="btn btn-cancel" onclick="openCancelModal(${order.orderId})" title="Cancel Order">
                                                    <i class="fas fa-times"></i>
                                                </button>
                                            </c:if>
                                            <c:if test="${order.status ne 'Cancelled'}">
                                                <button type="button" class="btn btn-reorder" onclick="openReorderModal(${order.orderId})" title="Reorder">
                                                    <i class="fas fa-redo"></i>
                                                </button>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="7" style="text-align: center; padding: 2rem;">
                                    No orders found
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
            
            <!-- Empty state - show this when there are no orders -->
            <div class="empty-orders" style="display: none;">
                <i class="fas fa-shopping-bag empty-icon"></i>
                <h3 class="empty-title">No orders found</h3>
                <p class="empty-text">Looks like you haven't made any orders yet</p>
                <a href="#" class="btn-shop">
                    <i class="fas fa-motorcycle"></i>
                    Shop Bikes
                </a>
            </div>
        </div>
    </div>
    
    <!-- Modal for Cancel Order -->
    <div class="modal-overlay" id="cancelOrderModal">
        <div class="modal-container">
            <div class="modal-header">
                <h3 class="modal-title">Cancel Order</h3>
                <button class="modal-close" onclick="closeModal('cancelOrderModal')">
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
                <button class="modal-btn modal-btn-cancel" onclick="closeModal('cancelOrderModal')">No, Keep Order</button>
                <form action="myorders" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="cancel">
                    <input type="hidden" name="orderId" id="cancelOrderId" value="">
                    <input type="hidden" name="restoreStock" value="true">
                    <button type="submit" class="modal-btn modal-btn-confirm">Yes, Cancel Order</button>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Modal for Reorder -->
    <div class="modal-overlay" id="reorderModal">
        <div class="modal-container">
            <div class="modal-header">
                <h3 class="modal-title">Reorder Bike</h3>
                <button class="modal-close" onclick="closeModal('reorderModal')">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="modal-body">
                <div class="modal-icon">
                    <i class="fas fa-redo" style="color: #0EA5E9;"></i>
                </div>
                <p>Would you like to place a new order with the same bike and quantity?</p>
                <p style="margin-top: 10px; font-size: 0.9em; color: #555;">This will create a brand new order, leaving your original order intact.</p>
            </div>
            <div class="modal-footer">
                <button class="modal-btn modal-btn-cancel" onclick="closeModal('reorderModal')">Cancel</button>
                <form action="myorders" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="reorder">
                    <input type="hidden" name="orderId" id="reorderOrderId" value="">
                    <button type="submit" class="modal-btn modal-btn-confirm">Yes, Place New Order</button>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal for Bulk Delete Cancelled Orders -->
    <div class="modal-overlay" id="bulkDeleteModal">
        <div class="modal-container">
            <div class="modal-header">
                <h3 class="modal-title">Delete Cancelled Orders</h3>
                <button class="modal-close" onclick="closeModal('bulkDeleteModal')">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="modal-body">
                <div class="modal-icon">
                    <i class="fas fa-trash" style="color: #EF4444;"></i>
                </div>
                <p>Are you sure you want to permanently delete all cancelled orders? This action cannot be undone.</p>
            </div>
            <div class="modal-footer">
                <button class="modal-btn modal-btn-cancel" onclick="closeModal('bulkDeleteModal')">No, Keep Orders</button>
                <form action="myorders" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="bulkDelete">
                    <button type="submit" class="modal-btn modal-btn-confirm">Yes, Delete All Cancelled Orders</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        // JavaScript for filtering and search functionality
        document.addEventListener('DOMContentLoaded', function() {
            // Add event listeners for filters
            const searchInput = document.querySelector('.search-box input');
            const statusFilter = document.querySelector('.filter-dropdown');
            
            // Example of how to implement search functionality
            searchInput.addEventListener('keyup', function() {
                const searchTerm = this.value.toLowerCase();
                const tableRows = document.querySelectorAll('.orders-table tbody tr');
                
                tableRows.forEach(row => {
                    const orderId = row.querySelector('.order-id').textContent.toLowerCase();
                    const bikeName = row.querySelector('.bike-name').textContent.toLowerCase();
                    
                    if (orderId.includes(searchTerm) || bikeName.includes(searchTerm)) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            });
            
            // Example of how to implement status filtering
            statusFilter.addEventListener('change', function() {
                const status = this.value;
                const tableRows = document.querySelectorAll('.orders-table tbody tr');
                
                tableRows.forEach(row => {
                    if (status === 'all') {
                        row.style.display = '';
                        return;
                    }
                    
                    const statusElement = row.querySelector('.status-badge');
                    if (statusElement.textContent.toLowerCase().includes(status)) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            });
        });
        
        // Modal functions
        function openCancelModal(orderId) {
            document.getElementById('cancelOrderId').value = orderId;
            document.getElementById('cancelOrderModal').style.display = 'flex';
        }
        
        function openReorderModal(orderId) {
            document.getElementById('reorderOrderId').value = orderId;
            document.getElementById('reorderModal').style.display = 'flex';
        }
        
        function openBulkDeleteModal() {
            document.getElementById('bulkDeleteModal').style.display = 'flex';
        }
        
        function closeModal(modalId) {
            document.getElementById(modalId).style.display = 'none';
        }
        
        // Close modals when clicking outside
        window.addEventListener('click', function(event) {
            const cancelModal = document.getElementById('cancelOrderModal');
            const reorderModal = document.getElementById('reorderModal');
            const bulkDeleteModal = document.getElementById('bulkDeleteModal');
            
            if (event.target === cancelModal) {
                cancelModal.style.display = 'none';
            }
            
            if (event.target === reorderModal) {
                reorderModal.style.display = 'none';
            }
            
            if (event.target === bulkDeleteModal) {
                bulkDeleteModal.style.display = 'none';
            }
        });
    </script>
</body>
</html>