<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>${isSingleOrder ? 'Order Details' : 'Sales Report'} - HiDASA Bikes</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            color: #333;
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
            border-bottom: 2px solid #333;
            padding-bottom: 10px;
        }
        .header h1 {
            margin: 0;
            color: #333;
        }
        .header p {
            margin: 5px 0;
            color: #666;
        }
        .summary {
            margin-bottom: 20px;
            padding: 15px;
            background: #f9f9f9;
            border-radius: 5px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f5f5f5;
        }
        .footer {
            margin-top: 30px;
            text-align: center;
            font-size: 0.9em;
            color: #666;
        }
        @media print {
            .no-print {
                display: none;
            }
            body {
                margin: 0;
                padding: 15px;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>HiDASA Bikes</h1>
        <p>${isSingleOrder ? 'Order Details' : 'Sales Report'}</p>
        <p>Generated on: <fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy-MM-dd HH:mm:ss"/></p>
    </div>

    <c:if test="${!isSingleOrder}">
        <div class="summary">
            <h2>Sales Summary</h2>
            <p>Total Sales: ₹<fmt:formatNumber value="${summary.totalSales}" pattern="#,##0.00"/></p>
            <p>Total Orders: ${summary.totalOrders}</p>
            <p>Average Order Value: ₹<fmt:formatNumber value="${summary.avgOrderValue}" pattern="#,##0.00"/></p>
            <p>Monthly Sales: ₹<fmt:formatNumber value="${summary.monthlySales}" pattern="#,##0.00"/></p>
        </div>
    </c:if>

    <table>
        <thead>
            <tr>
                <th>Order ID</th>
                <th>Delivery Date</th>
                <th>Customer Name</th>
                <th>Bike Model</th>
                <th>Amount</th>
                <th>Payment Status</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${isSingleOrder}">
                    <tr>
                        <td>#${order.orderId}</td>
                        <td><fmt:formatDate value="${order.deliveryDate}" pattern="yyyy-MM-dd"/></td>
                        <td>${order.customerName}</td>
                        <td>${order.bikeModel}</td>
                        <td>₹<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></td>
                        <td>${order.paymentStatus}</td>
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
                            <td>${sale.paymentStatus}</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <div class="footer">
        <p>This is a computer-generated document. No signature is required.</p>
    </div>

    <div class="no-print" style="text-align: center; margin-top: 20px;">
        <button onclick="window.print()">Print</button>
        <button onclick="window.close()">Close</button>
    </div>
</body>
</html> 