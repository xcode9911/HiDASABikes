<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Message - Bike Showroom Admin</title>
    <link rel="stylesheet" href="../assets/css/adminStyle.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .main-content {
            padding: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #f0f0f0;
        }

        .page-title {
            font-size: 1.8rem;
            color: #2c3e50;
            font-weight: 600;
            margin: 0;
        }

        .back-button {
            display: inline-flex;
            align-items: center;
            padding: 0.8rem 1.5rem;
            background: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: 0 2px 4px rgba(52, 152, 219, 0.2);
        }

        .back-button i {
            margin-right: 8px;
        }

        .back-button:hover {
            background: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(52, 152, 219, 0.3);
        }

        .message-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .message-header {
            background: #f8f9fa;
            padding: 2rem;
            border-bottom: 1px solid #e9ecef;
        }

        .message-header h2 {
            color: #2c3e50;
            font-size: 1.5rem;
            font-weight: 600;
            margin: 0 0 1rem 0;
            line-height: 1.4;
        }

        .message-meta {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            color: #6c757d;
            font-size: 0.95rem;
        }

        .meta-item {
            display: flex;
            align-items: center;
        }

        .meta-item i {
            margin-right: 10px;
            color: #3498db;
            font-size: 1.1rem;
        }

        .meta-item strong {
            color: #495057;
            margin-right: 8px;
        }

        .message-content {
            padding: 2rem;
            line-height: 1.8;
            color: #2c3e50;
            font-size: 1.05rem;
            background: white;
        }

        .message-content p {
            margin: 0 0 1.5rem 0;
        }

        .message-content p:last-child {
            margin-bottom: 0;
        }

        .message-footer {
            background: #f8f9fa;
            padding: 1.5rem 2rem;
            border-top: 1px solid #e9ecef;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .message-actions {
            display: flex;
            gap: 1rem;
        }

        .action-button {
            padding: 0.6rem 1.2rem;
            border-radius: 6px;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            cursor: pointer;
            border: none;
        }

        .action-button i {
            font-size: 1rem;
        }

        .action-button.primary {
            background: #3498db;
            color: white;
        }

        .action-button.primary:hover {
            background: #2980b9;
        }

        .action-button.secondary {
            background: #e9ecef;
            color: #495057;
        }

        .action-button.secondary:hover {
            background: #dee2e6;
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 1rem;
            }

            .message-meta {
                grid-template-columns: 1fr;
            }

            .message-header, .message-content, .message-footer {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="adminsidebar.jsp" />

    <div class="container">
        <div class="main-content">
            <div class="page-header">
                <h1 class="page-title">Message Details</h1>
                <a href="${pageContext.request.contextPath}/admin/messages" class="back-button">
                    <i class="fas fa-arrow-left"></i> Back to Messages
                </a>
            </div>

            <div class="message-container">
                <div class="message-header">
                    <h2>${feedback.subject}</h2>
                    <div class="message-meta">
                        <div class="meta-item">
                            <i class="fas fa-user"></i>
                            <strong>From:</strong> ${user != null ? user.name : 'Guest'}
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-envelope"></i>
                            <strong>Email:</strong> ${user != null ? user.email : 'N/A'}
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-calendar"></i>
                            <strong>Date:</strong> <fmt:formatDate value="${messageDate}" pattern="MMMM dd, yyyy"/>
                        </div>
                    </div>
                </div>

                <div class="message-content">
                    <p>${feedback.message}</p>
                </div>

                <div class="message-footer">
                    <div class="message-actions">
                        <c:choose>
                            <c:when test="${user != null && not empty user.email}">
                                <button class="action-button primary" onclick="window.location.href='mailto:${user.email}?subject=Re: ${feedback.subject}'">
                                    <i class="fas fa-reply"></i> Reply via Email
                                </button>
                            </c:when>
                            <c:otherwise>
                                <button class="action-button primary" disabled title="No email address available">
                                    <i class="fas fa-reply"></i> Reply via Email
                                </button>
                            </c:otherwise>
                        </c:choose>
                        <button class="action-button secondary" onclick="window.print()">
                            <i class="fas fa-print"></i> Print Message
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html> 