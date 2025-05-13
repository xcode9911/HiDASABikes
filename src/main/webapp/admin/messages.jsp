<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Messages - Bike Showroom Admin</title>
    <link rel="stylesheet" href="../assets/css/adminStyle.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .btn-view {
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            padding: 6px 12px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            transition: background-color 0.2s;
        }
        .btn-view:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <jsp:include page="adminsidebar.jsp" />

    <div class="container">
        <!-- Main Content -->
        <div class="main-content">
            <h1>Customer Messages</h1>
            


            <!-- Messages Table -->
            <div class="table-container">
                <form action="${pageContext.request.contextPath}/admin/messages" method="post" style="margin-bottom: 20px;">
       
                </form>

                <table>
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Customer Name</th>
                            <th>Email</th>
                            <th>Subject</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${messageList}" var="message">
                            <tr>
                                <td><fmt:formatDate value="${message.messageDate}" pattern="yyyy-MM-dd"/></td>
                                <td>${message.userName}</td>
                                <td>${message.userEmail}</td>
                                <td>${message.feedback.subject}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/messages?action=view&id=${message.feedback.feedbackId}" 
                                       class="btn-view">
                                       <i class="fas fa-eye"></i> View
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html> 