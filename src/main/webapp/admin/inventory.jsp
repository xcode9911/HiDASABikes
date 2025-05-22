<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Inventory - Bike Showroom Admin</title>
    <link rel="stylesheet" href="../assets/css/adminStyle.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <jsp:include page="adminsidebar.jsp" />

    <div class="container">
        <!-- Main Content -->
        <div class="main-content">
            <h1>Inventory Management</h1>
            
            <!-- Display error message if any -->
            <c:if test="${not empty error}">
                <div class="error-message">
                    ${error}
                </div>
            </c:if>
            
            <!-- Display success message if any -->
            <c:if test="${not empty param.message}">
                <div class="success-message">
                    <c:if test="${param.message == 'stock_updated'}">
                        Stock updated successfully!
                    </c:if>
                </div>
            </c:if>
            
            <!-- Stock Summary Cards -->
            <div class="dashboard-cards">
                <div class="card">
                    <h3>Total Stock</h3>
                    <div class="value">${summary.totalStock}</div>
                </div>
                <div class="card">
                    <h3>Low Stock Items</h3>
                    <div class="value">${summary.lowStock}</div>
                </div>
                <div class="card">
                    <h3>Out of Stock</h3>
                    <div class="value">${summary.outOfStock}</div>
                </div>
                <div class="card">
                    <h3>Total Value</h3>
                    <div class="value">₹${summary.totalValue}</div>
                </div>
            </div>

            <!-- Inventory Table -->
            <div class="table-container">
                <div style="margin-bottom: 20px;">
                    <select id="stockFilter" style="width: 200px; margin-right: 10px;">
                        <option value="">All Stock Status</option>
                        <option value="in-stock">In Stock</option>
                        <option value="low-stock">Low Stock</option>
                        <option value="out-of-stock">Out of Stock</option>
                    </select>
                    <button onclick="filterTable()">Filter</button>
                </div>

                <table>
                    <thead>
                        <tr>
                            <th>Model</th>
                            <th>Category</th>
                            <th>Current Stock</th>
                            <th>Status</th>
                            <th>Price</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${inventory}" var="bike">
                            <tr class="stock-row" data-stock="${bike.stockQuantity}">
                                <td>${bike.modelName}</td>
                                <td>${bike.type}</td>
                                <td>${bike.stockQuantity}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${bike.stockQuantity == 0}">
                                            <span class="status-badge status-cancelled">Out of Stock</span>
                                        </c:when>
                                        <c:when test="${bike.stockQuantity < 5}">
                                            <span class="status-badge status-pending">Low Stock</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-completed">In Stock</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>₹${bike.price}</td>
                                <td>
                                    <form action="inventory" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="updateStock">
                                        <input type="hidden" name="bikeId" value="${bike.bikeId}">
                                        <input type="number" name="newStock" value="${bike.stockQuantity}" min="0" style="width: 60px; margin-right: 5px;">
                                        <button type="submit" style="padding: 5px 10px;">Update</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
        function filterTable() {
            const filter = document.getElementById('stockFilter').value;
            const rows = document.getElementsByClassName('stock-row');
            
            for (let row of rows) {
                const stock = parseInt(row.getAttribute('data-stock'));
                let show = true;
                
                switch(filter) {
                    case 'in-stock':
                        show = stock >= 5;
                        break;
                    case 'low-stock':
                        show = stock > 0 && stock < 5;
                        break;
                    case 'out-of-stock':
                        show = stock === 0;
                        break;
                }
                
                row.style.display = show ? '' : 'none';
            }
        }
    </script>
</body>
</html> 