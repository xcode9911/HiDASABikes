<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sales History - HiDASA Bikes</title>
    <link rel="stylesheet" href="../assets/css/adminStyle.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .action-btn {
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            background: #f0f0f0;
            transition: all 0.3s ease;
        }
        
        .action-btn:hover {
            background: #e0e0e0;
        }
        
        .action-btn.delete {
            color: #dc3545;
        }
        
        .action-btn.delete:hover {
            background: #dc3545;
            color: white;
        }
        
        .status-badge {
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 0.9em;
        }
        
        .status-completed {
            background: #28a745;
            color: white;
        }
        
        .status-pending {
            background: #ffc107;
            color: black;
        }
        
        .status-failed {
            background: #dc3545;
            color: white;
        }
    </style>
</head>
<body>
    <jsp:include page="adminsidebar.jsp" />

    <div class="container">
        <!-- Main Content -->
        <div class="main-content">
            <div class="welcome-header">
                <h1>Sales History</h1>
                <p>Track your business performance and sales analytics</p>
            </div>
            
            <!-- Debug Information -->
            <c:if test="${empty totalSales || totalSales == 0}">
                <div style="color: red; padding: 10px; margin: 10px 0; background: #ffeeee;">
                    Warning: No sales data available. Please check database connection.
                </div>
            </c:if>
            
            <!-- Sales Summary Cards -->
            <div class="dashboard-cards">
                <div class="card">
                    <h3>Total Sales</h3>
                    <div class="value">₹<fmt:formatNumber value="${totalSales}" pattern="#,##0.00"/></div>
                </div>
                <div class="card">
                    <h3>Monthly Sales</h3>
                    <div class="value">₹<fmt:formatNumber value="${monthlySales}" pattern="#,##0.00"/></div>
                </div>
                <div class="card">
                    <h3>Total Orders</h3>
                    <div class="value">${totalOrders}</div>
                </div>
                <div class="card">
                    <h3>Average Order Value</h3>
                    <div class="value">₹<fmt:formatNumber value="${avgOrderValue}" pattern="#,##0.00"/></div>
                </div>
            </div>

            <!-- Sales History Table -->
            <div class="table-container">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                    <h2>Sales Records</h2>
                    <div style="display: flex; gap: 10px;">
                        <button onclick="printAllSales()" class="action-btn" style="background: #28a745; color: white;">
                            <i class="fas fa-print"></i> Print All Sales
                        </button>
                        <input type="date" id="filterDate" style="padding: 8px; margin-right: 10px; border: 1px solid var(--border-color); border-radius: 5px;">
                        <button onclick="filterSales()">Filter</button>
                    </div>
                </div>

                <table>
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Delivery Date</th>
                            <th>Customer Name</th>
                            <th>Bike Model</th>
                            <th>Amount</th>
                            <th>Payment Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty salesList}">
                                <tr>
                                    <td colspan="7" style="text-align: center; padding: 20px;">
                                        No sales records found
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${salesList}" var="sale">
                                    <tr>
                                        <td>#${sale.orderId}</td>
                                        <td><fmt:formatDate value="${sale.deliveryDate}" pattern="yyyy-MM-dd"/></td>
                                        <td>${sale.customerName}</td>
                                        <td>${sale.bikeModel}</td>
                                        <td>₹<fmt:formatNumber value="${sale.totalAmount}" pattern="#,##0.00"/></td>
                                        <td>
                                            <span class="status-badge status-${sale.paymentStatus.toLowerCase()}">
                                                ${sale.paymentStatus}
                                            </span>
                                        </td>
                                        <td>
                                            <div style="display: flex; gap: 10px;">
                                                <button onclick="printOrder(${sale.orderId})" class="action-btn" title="Print Order">
                                                    <i class="fas fa-print"></i>
                                                </button>
                                                <button onclick="deleteOrder(${sale.orderId})" class="action-btn delete" title="Delete Order">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

            <!-- Monthly Sales Chart -->
            <div class="table-container">
                <h2>Monthly Sales Analysis</h2>
                <div style="height: 300px;">
                    <canvas id="salesChart"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!-- Chart.js Script -->
    <script>
        const ctx = document.getElementById('salesChart').getContext('2d');
        const monthlyData = [
            <c:forEach items="${monthlySalesData}" var="sales" varStatus="status">
                ${sales.total}${!status.last ? ',' : ''}
            </c:forEach>
        ];
        
        // Initialize chart with empty data if no data available
        const chartData = monthlyData.length > 0 ? monthlyData : Array(12).fill(0);
        
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                datasets: [{
                    label: 'Sales Revenue',
                    data: chartData,
                    borderColor: '#ff0066',
                    backgroundColor: 'rgba(255, 0, 102, 0.1)',
                    fill: true,
                    tension: 0.4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: value => '₹' + value.toLocaleString()
                        }
                    }
                }
            }
        });

        function printOrder(orderId) {
            window.open('${pageContext.request.contextPath}/admin/print/order/' + orderId, '_blank', 'width=800,height=600');
        }

        function printAllSales() {
            window.open('${pageContext.request.contextPath}/admin/print/all', '_blank', 'width=800,height=600');
        }

        function deleteOrder(orderId) {
            if (confirm('Are you sure you want to delete this order?')) {
                fetch('${pageContext.request.contextPath}/admin/orders/delete?id=' + orderId, {
                    method: 'POST'
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('Order deleted successfully');
                        location.reload();
                    } else {
                        alert('Error deleting order: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Error deleting order');
                });
            }
        }

        function filterSales() {
            const date = document.getElementById('filterDate').value;
            if (date) {
                window.location.href = '${pageContext.request.contextPath}/admin/sales?action=list&date=' + date;
            }
        }
    </script>
</body>
</html>
