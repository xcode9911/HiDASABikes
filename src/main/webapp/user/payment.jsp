<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page import="java.sql.*" %>
<%@ page import="modal.Bike" %>
<%@ page import="util.DatabaseUtil" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>

<%
    // Get bike ID from request parameter
    int bikeId = 0;
    try {
        bikeId = Integer.parseInt(request.getParameter("bikeId"));
    } catch(NumberFormatException e) {
        response.sendRedirect(request.getContextPath() + "/user/bikes.jsp");
        return;
    }
    
    // Fetch bike details from database
    Bike bike = null;
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    
    try {
        conn = DatabaseUtil.getConnection();
        
        String sql = "SELECT * FROM bike WHERE BikeID = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, bikeId);
        
        rs = stmt.executeQuery();
        
        if (rs.next()) {
            bike = new Bike();
            bike.setBikeId(rs.getInt("BikeID"));
            bike.setBrandName(rs.getString("Brand_Name"));
            bike.setModelName(rs.getString("Model_Name"));
            bike.setPrice(rs.getDouble("Price"));
            bike.setStockQuantity(rs.getInt("Stock_Quantity"));
            
            // Handle image
            byte[] imageData = rs.getBytes("Bike_Image");
            if (imageData != null) {
                request.setAttribute("bikeImage", Base64.getEncoder().encodeToString(imageData));
            }
            
            // Set bike object as request attribute
            request.setAttribute("bike", bike);
            
            // Format price for display
            double price = rs.getDouble("Price");
            NumberFormat formatter = NumberFormat.getCurrencyInstance(new Locale("en", "IN"));
            String formattedPrice = formatter.format(price).replace("₹", "").trim();
            request.setAttribute("formattedPrice", formattedPrice);
        } else {
            // Bike not found
            response.sendRedirect(request.getContextPath() + "/user/bikes.jsp");
            return;
        }
    } catch(SQLException e) {
        e.printStackTrace();
        response.sendRedirect(request.getContextPath() + "/error.jsp");
        return;
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
    
    // Check if user is logged in
    if (session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/user/login.jsp?redirect=payment&bikeId=" + bikeId);
        return;
    }
    
    // Check if bike is in stock
    if (bike.getStockQuantity() <= 0) {
        response.sendRedirect(request.getContextPath() + "/bike-details?id=" + bikeId + "&outOfStock=true");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payment | HIDASA Bikes</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: #f6f7fb;
            font-family: 'Inter', sans-serif;
            color: #222;
            margin: 0;
        }
       
        .main-container {
            max-width: 950px;
            margin: 0 auto 3rem auto;
            display: flex;
            gap: 2.5rem;
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.08);
            padding: 2.5rem 2rem;
            position: relative;
               margin-top: 5rem;
        }
        @media (max-width: 900px) {
            .main-container {
                flex-direction: column;
                padding: 1.2rem 0.5rem;
            }
        }
        .payment-section {
            flex: 1.2;
            padding-right: 1.5rem;
        }
        .order-summary-section {
            flex: 1;
            background: #fafbfc;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            padding: 1.5rem 1.2rem;
            min-width: 270px;
        }
        .section-title {
            font-size: 1.4rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            color: #222;
        }
        .payment-methods-list {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
        }
        .pay-method-btn {
            flex: 1;
            background: #f3f3f7;
            border: 2px solid #eee;
            border-radius: 8px;
            padding: 1rem 0.5rem;
            text-align: center;
            cursor: pointer;
            font-weight: 500;
            color: #555;
            transition: all 0.2s;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 0.5rem;
        }
        .pay-method-btn.selected, .pay-method-btn:hover {
            border-color: #FF0B55;
            background: #fff0f6;
            color: #FF0B55;
        }
        .pay-method-btn i {
            font-size: 1.5rem;
        }
        .pay-form {
            display: none;
            margin-top: 1.5rem;
        }
        .pay-form.active {
            display: block;
        }
        .form-group {
            margin-bottom: 1.2rem;
        }
        .form-label {
            display: block;
            margin-bottom: 0.4rem;
            font-weight: 500;
            color: #444;
        }
        .form-control {
            width: 100%;
            padding: 0.7rem 1rem;
            border: 1.5px solid #e0e0e0;
            border-radius: 6px;
            font-size: 1rem;
            transition: border 0.2s;
        }
        .form-control:focus {
            border-color: #FF0B55;
            outline: none;
        }
        .pay-btn {
            width: 100%;
            background: linear-gradient(90deg, #FF0B55 60%, #ff5e8e 100%);
            color: #fff;
            border: none;
            padding: 1rem 0;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 600;
            margin-top: 1.5rem;
            cursor: pointer;
            box-shadow: 0 2px 8px rgba(255,11,85,0.08);
            transition: background 0.2s, transform 0.2s;
        }
        .pay-btn:hover {
            background: linear-gradient(90deg, #e0094a 60%, #ff5e8e 100%);
            transform: translateY(-2px);
        }
        .secure-badge {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #4CAF50;
            font-size: 0.95rem;
            margin-top: 1rem;
        }
        .order-summary-section h3 {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 1.2rem;
        }
        .bike-summary {
            display: flex;
            gap: 1rem;
            align-items: center;
            margin-bottom: 1.2rem;
        }
        .bike-summary img {
            width: 80px;
            height: 60px;
            object-fit: cover;
            border-radius: 6px;
            background: #eee;
        }
        .bike-summary-details {
            flex: 1;
        }
        .bike-summary-details .bike-name {
            font-weight: 600;
            font-size: 1.05rem;
            margin-bottom: 0.2rem;
        }
        .bike-summary-details .bike-price {
            color: #888;
            font-size: 0.98rem;
        }
        .summary-table {
            width: 100%;
            margin-bottom: 1.2rem;
        }
        .summary-table tr {
            height: 2.2rem;
        }
        .summary-table td {
            color: #555;
        }
        .summary-table .label {
            text-align: left;
        }
        .summary-table .value {
            text-align: right;
            font-weight: 500;
        }
        .summary-table .total-row td {
            font-weight: 700;
            color: #222;
            border-top: 1.5px solid #eee;
            padding-top: 0.7rem;
        }
        .cancel-link {
            display: block;
            text-align: center;
            margin-top: 1.2rem;
            color: #FF0B55;
            text-decoration: none;
            font-weight: 500;
            border-radius: 6px;
            padding: 0.7rem 0;
            background: #fff0f6;
            transition: background 0.2s;
        }
        .cancel-link:hover {
            background: #ffe3ef;
        }
        @media (max-width: 700px) {
            .main-container {
                flex-direction: column;
                padding: 0.5rem 0.2rem;
            }
            .order-summary-section {
                margin-top: 2rem;
            }
        }
    </style>
</head>
<body>
    <%@ include file="navigationBar.jsp" %>



    <div class="main-container">
        <div class="payment-section">
            <div class="section-title">Choose Payment Method</div>
            <div class="payment-methods-list">
                <div class="pay-method-btn selected" id="pm-card" onclick="selectPayMethod('card')">
                    <i class="fas fa-credit-card"></i>
                    Card
                </div>
                <div class="pay-method-btn" id="pm-upi" onclick="selectPayMethod('upi')">
                    <i class="fas fa-mobile-alt"></i>
                    UPI
                </div>
                <div class="pay-method-btn" id="pm-netbanking" onclick="selectPayMethod('netbanking')">
                    <i class="fas fa-university"></i>
                    Netbanking
                </div>
                <div class="pay-method-btn" id="pm-wallet" onclick="selectPayMethod('wallet')">
                    <i class="fas fa-wallet"></i>
                    Wallet
                </div>
            </div>
            <form action="${pageContext.request.contextPath}/process-payment" method="post" id="paymentForm">
                <input type="hidden" name="bikeId" value="${param.bikeId}">
                <input type="hidden" name="paymentMethod" id="paymentMethod" value="card">
                <input type="hidden" name="totalAmount" id="hiddenTotalAmount">
                <input type="hidden" name="quantity" id="hiddenQuantity" value="1">
                <!-- Card Form -->
                <div class="pay-form active" id="form-card">
                    <div class="form-group">
                        <label class="form-label">Card Number</label>
                        <input type="text" class="form-control" placeholder="1234 5678 9012 3456" maxlength="19" id="cardNumber">
                    </div>
                    <div class="form-group" style="display: flex; gap: 1rem;">
                        <div style="flex:1;">
                            <label class="form-label">Expiry Date</label>
                            <input type="text" class="form-control" placeholder="MM/YY" maxlength="5" id="expiryDate">
                        </div>
                        <div style="flex:1;">
                            <label class="form-label">CVV</label>
                            <input type="text" class="form-control" placeholder="123" maxlength="3" id="cvv">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Card Holder Name</label>
                        <input type="text" class="form-control" placeholder="John Doe" id="cardName">
                    </div>
                    <div class="secure-badge">
                        <i class="fas fa-lock"></i>
                        Your payment is secure
                    </div>
                </div>
                <!-- UPI Form -->
                <div class="pay-form" id="form-upi">
                    <div class="form-group">
                        <label class="form-label">UPI ID</label>
                        <input type="text" class="form-control" placeholder="yourname@upi" id="upiId">
                    </div>
                    <div class="secure-badge">
                        <i class="fas fa-lock"></i>
                        Your payment is secure
                    </div>
                </div>
                <!-- Netbanking Form -->
                <div class="pay-form" id="form-netbanking">
                    <div class="form-group">
                        <label class="form-label">Select Bank</label>
                        <select class="form-control" id="bankSelect">
                            <option value="">Select your bank</option>
                            <option value="sbi">State Bank of India</option>
                            <option value="hdfc">HDFC Bank</option>
                            <option value="icici">ICICI Bank</option>
                            <option value="axis">Axis Bank</option>
                            <option value="pnb">Punjab National Bank</option>
                            <option value="other">Other Bank</option>
                        </select>
                    </div>
                    <div class="secure-badge">
                        <i class="fas fa-lock"></i>
                        You'll be redirected to your bank's website
                    </div>
                </div>
                <!-- Wallet Form -->
                <div class="pay-form" id="form-wallet">
                    <div class="form-group">
                        <label class="form-label">Select Wallet</label>
                        <select class="form-control" id="walletSelect">
                            <option value="">Select your wallet</option>
                            <option value="paytm">Paytm</option>
                            <option value="amazonpay">Amazon Pay</option>
                            <option value="phonepe">PhonePe</option>
                            <option value="mobikwik">MobiKwik</option>
                            <option value="other">Other Wallet</option>
                        </select>
                    </div>
                    <div class="secure-badge">
                        <i class="fas fa-lock"></i>
                        You'll be redirected to complete payment
                    </div>
                </div>
                <button type="button" class="pay-btn" onclick="validateAndPay()">Pay Now</button>
            </form>
        </div>
        <div class="order-summary-section">
            <h3>Order Summary</h3>
            <div class="bike-summary">
                <img src="data:image/jpeg;base64,${bikeImage}" alt="${bike.brandName} ${bike.modelName}" onerror="this.src='${pageContext.request.contextPath}/assets/images/bike-placeholder.jpg'">
                <div class="bike-summary-details">
                    <div class="bike-name">${bike.brandName} ${bike.modelName}</div>
                    <div class="bike-price">₹<span id="unitPrice">${formattedPrice}</span></div>
                </div>
            </div>
            <div style="display: flex; align-items: center; gap: 1rem; margin-bottom: 1.2rem;">
                <span style="font-weight: 500;">Quantity:</span>
                <button type="button" id="decreaseQty" style="width:32px;height:32px;border:none;background:#eee;border-radius:50%;font-size:1.2rem;cursor:pointer;">-</button>
                <input type="number" id="quantity" value="1" min="1" max="${bike.stockQuantity}" style="width:50px;text-align:center;font-size:1rem;padding:0.3rem 0.2rem;border:1px solid #ccc;border-radius:6px;" onchange="updateQuantity(this.value)">
                <button type="button" id="increaseQty" style="width:32px;height:32px;border:none;background:#eee;border-radius:50%;font-size:1.2rem;cursor:pointer;">+</button>
                <span style="color:#888;font-size:0.95rem;">(In stock: ${bike.stockQuantity})</span>
            </div>
            <table class="summary-table">
                <tr>
                    <td class="label">Bike Price</td>
                    <td class="value" id="bikeSubtotal"></td>
                </tr>
                <tr>
                    <td class="label">GST (18%)</td>
                    <td class="value" id="gstAmount"></td>
                </tr>
                <tr>
                    <td class="label">Delivery Charges</td>
                    <td class="value">₹999</td>
                </tr>
                <tr class="total-row">
                    <td class="label">Total Amount</td>
                    <td class="value" id="totalAmount"></td>
                </tr>
            </table>
            <a href="${pageContext.request.contextPath}/bike-details?id=${param.bikeId}" class="cancel-link">Cancel</a>
        </div>
    </div>

    <script>
        // Payment method selection
        function selectPayMethod(method) {
            // Remove selected from all
            document.querySelectorAll('.pay-method-btn').forEach(btn => btn.classList.remove('selected'));
            document.querySelectorAll('.pay-form').forEach(form => form.classList.remove('active'));
            // Add selected to current
            document.getElementById('pm-' + method).classList.add('selected');
            document.getElementById('form-' + method).classList.add('active');
            document.getElementById('paymentMethod').value = method;
        }
        // Card input formatting
        document.getElementById('cardNumber').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\s+/g, '');
            if (value.length > 0) {
                value = value.match(/.{1,4}/g)?.join(' ') || value;
            }
            e.target.value = value;
        });
        document.getElementById('expiryDate').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length > 2) {
                value = value.slice(0, 2) + '/' + value.slice(2);
            }
            e.target.value = value;
        });
        document.getElementById('cvv').addEventListener('input', function(e) {
            e.target.value = e.target.value.replace(/\D/g, '');
        });
        // Amount calculation
        const unitPrice = parseFloat('${bike.price}');
        const gstRate = 0.18;
        const deliveryCharge = 999;
        const maxStock = parseInt('${bike.stockQuantity}', 10);
        const formattedUnitPrice = document.getElementById('unitPrice').textContent;
        const quantityInput = document.getElementById('quantity');
        const decreaseBtn = document.getElementById('decreaseQty');
        const increaseBtn = document.getElementById('increaseQty');
        function updateAmounts() {
            const qty = parseInt(quantityInput.value);
            const subtotal = unitPrice * qty;
            const gstAmount = subtotal * gstRate;
            const totalAmount = subtotal + gstAmount + deliveryCharge;
            document.getElementById('bikeSubtotal').textContent = '₹' + subtotal.toLocaleString('en-IN');
            document.getElementById('gstAmount').textContent = '₹' + gstAmount.toLocaleString('en-IN');
            document.getElementById('totalAmount').textContent = '₹' + totalAmount.toLocaleString('en-IN');
            document.getElementById('hiddenTotalAmount').value = totalAmount;
        }
        decreaseBtn.addEventListener('click', function() {
            let qty = parseInt(quantityInput.value);
            if (qty > 1) {
                quantityInput.value = qty - 1;
                document.getElementById('hiddenQuantity').value = qty - 1;
                updateAmounts();
            }
        });
        increaseBtn.addEventListener('click', function() {
            let qty = parseInt(quantityInput.value);
            if (qty < maxStock) {
                quantityInput.value = qty + 1;
                document.getElementById('hiddenQuantity').value = qty + 1;
                updateAmounts();
            }
        });
        // Initial calculation
        updateAmounts();
        // Validation
        function validateAndPay() {
            const method = document.getElementById('paymentMethod').value;
            let isValid = false;
            
            // Log the current quantity value
            console.log("Quantity being submitted:", document.getElementById('hiddenQuantity').value);
            
            // Remove previous errors
            document.querySelectorAll('.form-control').forEach(input => input.style.borderColor = '#e0e0e0');
            switch(method) {
                case 'card':
                    const cardNumber = document.getElementById('cardNumber').value.replace(/\s+/g, '');
                    const expiryDate = document.getElementById('expiryDate').value;
                    const cvv = document.getElementById('cvv').value;
                    const cardName = document.getElementById('cardName').value;
                    if (cardNumber.length !== 16) {
                        document.getElementById('cardNumber').style.borderColor = '#FF0B55';
                        document.getElementById('cardNumber').focus();
                        return;
                    }
                    if (!expiryDate.match(/^\d{2}\/\d{2}$/)) {
                        document.getElementById('expiryDate').style.borderColor = '#FF0B55';
                        document.getElementById('expiryDate').focus();
                        return;
                    }
                    if (cvv.length !== 3) {
                        document.getElementById('cvv').style.borderColor = '#FF0B55';
                        document.getElementById('cvv').focus();
                        return;
                    }
                    if (cardName.trim() === '') {
                        document.getElementById('cardName').style.borderColor = '#FF0B55';
                        document.getElementById('cardName').focus();
                        return;
                    }
                    isValid = true;
                    break;
                case 'upi':
                    const upiId = document.getElementById('upiId').value;
                    if (!upiId.includes('@')) {
                        document.getElementById('upiId').style.borderColor = '#FF0B55';
                        document.getElementById('upiId').focus();
                        return;
                    }
                    isValid = true;
                    break;
                case 'netbanking':
                    const bank = document.getElementById('bankSelect').value;
                    if (bank === '') {
                        document.getElementById('bankSelect').style.borderColor = '#FF0B55';
                        document.getElementById('bankSelect').focus();
                        return;
                    }
                    isValid = true;
                    break;
                case 'wallet':
                    const wallet = document.getElementById('walletSelect').value;
                    if (wallet === '') {
                        document.getElementById('walletSelect').style.borderColor = '#FF0B55';
                        document.getElementById('walletSelect').focus();
                        return;
                    }
                    isValid = true;
                    break;
            }
            if (isValid) {
                // Ensure quantity is correctly set before submission
                const finalQty = document.getElementById('hiddenQuantity').value;
                console.log("Final quantity being submitted:", finalQty);
                
                // Submit the form
                document.getElementById('paymentForm').submit();
            }
        }
        // Update quantity when manually changed
        function updateQuantity(value) {
            const qty = parseInt(value);
            console.log("Updating quantity to:", qty);
            
            // Validate range
            if (qty < 1) {
                quantityInput.value = 1;
                document.getElementById('hiddenQuantity').value = 1;
                console.log("Quantity too low, set to 1");
            } else if (qty > maxStock) {
                quantityInput.value = maxStock;
                document.getElementById('hiddenQuantity').value = maxStock;
                console.log("Quantity too high, set to max:", maxStock);
            } else {
                document.getElementById('hiddenQuantity').value = qty;
                console.log("Quantity set to:", qty);
            }
            updateAmounts();
        }
        
        // Make quantity field non-readonly to allow manual input
        quantityInput.removeAttribute('readonly');

        document.addEventListener('DOMContentLoaded', function() {
            // Set up references to existing elements
            const quantityInput = document.getElementById('quantity');
            const increaseBtn = document.getElementById('increaseQty');
            const decreaseBtn = document.getElementById('decreaseQty');
            
            console.log("Initial setup - Max stock:", maxStock);
            console.log("Initial quantity input value:", quantityInput.value);
            
            // Initialize hidden quantity field with the visible quantity input value
            document.getElementById('hiddenQuantity').value = quantityInput.value || 1;
            console.log("Initial hidden quantity value:", document.getElementById('hiddenQuantity').value);
            
            // Ensure the initial quantity is valid
            if (parseInt(quantityInput.value) > maxStock) {
                quantityInput.value = maxStock;
                document.getElementById('hiddenQuantity').value = maxStock;
                console.log("Initial quantity adjusted to max stock:", maxStock);
            }
            
            // Update amount calculations based on initial quantity
            updateAmounts();
        });
    </script>
</body>
</html>