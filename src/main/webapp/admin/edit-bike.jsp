<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="modal.Bike" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Bike - Bike Showroom Admin</title>
    <link rel="stylesheet" href="../assets/css/adminStyle.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <jsp:include page="adminsidebar.jsp" />

    <div class="container">
        <!-- Main Content -->
        <div class="main-content">
            <h1>Edit Bike</h1>
            
            <%
            Bike bike = (Bike) request.getAttribute("bike");
            if (bike != null) {
            %>
            <form action="ManageBikesServlet" method="post" enctype="multipart/form-data" class="edit-form">
                <input type="hidden" name="action" value="updateBike">
                <input type="hidden" name="bikeId" value="<%= bike.getBikeId() %>">
                
                <!-- Basic Information -->
                <div class="form-section">
                    <h2>Basic Information</h2>
                    <div class="form-group">
                        <label for="brandName">Brand Name:</label>
                        <input type="text" id="brandName" name="brandName" value="<%= bike.getBrandName() %>" required>
                    </div>
                    <div class="form-group">
                        <label for="modelName">Model Name:</label>
                        <input type="text" id="modelName" name="modelName" value="<%= bike.getModelName() %>" required>
                    </div>
                    <div class="form-group">
                        <label for="type">Type:</label>
                        <select id="type" name="type" required>
                            <option value="Mountain" <%= "Mountain".equals(bike.getType()) ? "selected" : "" %>>Mountain Bike</option>
                            <option value="Road" <%= "Road".equals(bike.getType()) ? "selected" : "" %>>Road Bike</option>
                            <option value="Hybrid" <%= "Hybrid".equals(bike.getType()) ? "selected" : "" %>>Hybrid Bike</option>
                            <option value="Electric" <%= "Electric".equals(bike.getType()) ? "selected" : "" %>>Electric Bike</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="price">Price (₹):</label>
                        <input type="number" id="price" name="price" value="<%= bike.getPrice() %>" step="0.01" required>
                    </div>
                </div>

                <!-- Engine Specifications -->
                <div class="form-section">
                    <h2>Engine Specifications</h2>
                    <div class="form-group">
                        <label for="engineCapacity">Engine Capacity:</label>
                        <input type="text" id="engineCapacity" name="engineCapacity" value="<%= bike.getEngineCapacity() %>" required>
                    </div>
                    <div class="form-group">
                        <label for="fuelType">Fuel Type:</label>
                        <input type="text" id="fuelType" name="fuelType" value="<%= bike.getFuelType() %>" required>
                    </div>
                    <div class="form-group">
                        <label for="transmission">Transmission:</label>
                        <input type="text" id="transmission" name="transmission" value="<%= bike.getTransmission() %>" required>
                    </div>
                    <div class="form-group">
                        <label for="mileage">Mileage:</label>
                        <input type="text" id="mileage" name="mileage" value="<%= bike.getMileage() %>" required>
                    </div>
                    <div class="form-group">
                        <label for="power">Power:</label>
                        <input type="text" id="power" name="power" value="<%= bike.getPower() %>" required>
                    </div>
                    <div class="form-group">
                        <label for="torque">Torque:</label>
                        <input type="text" id="torque" name="torque" value="<%= bike.getTorque() %>" required>
                    </div>
                    <div class="form-group">
                        <label for="coolingSystem">Cooling System:</label>
                        <input type="text" id="coolingSystem" name="coolingSystem" value="<%= bike.getCoolingSystem() %>" required>
                    </div>
                </div>

                <!-- Hardware & Dimensions -->
                <div class="form-section">
                    <h2>Hardware & Dimensions</h2>
                    <div class="form-group">
                        <label for="brakeType">Brake Type:</label>
                        <input type="text" id="brakeType" name="brakeType" value="<%= bike.getBrakeType() %>" required>
                    </div>
                    <div class="form-group">
                        <label for="suspensionType">Suspension Type:</label>
                        <input type="text" id="suspensionType" name="suspensionType" value="<%= bike.getSuspensionType() %>" required>
                    </div>
                    <div class="form-group">
                        <label for="kerbWeight">Kerb Weight:</label>
                        <input type="text" id="kerbWeight" name="kerbWeight" value="<%= bike.getKerbWeight() %>" required>
                    </div>
                    <div class="form-group">
                        <label for="seatHeight">Seat Height:</label>
                        <input type="text" id="seatHeight" name="seatHeight" value="<%= bike.getSeatHeight() %>" required>
                    </div>
                    <div class="form-group">
                        <label for="fuelTankCapacity">Fuel Tank Capacity:</label>
                        <input type="text" id="fuelTankCapacity" name="fuelTankCapacity" value="<%= bike.getFuelTankCapacity() %>" required>
                    </div>
                    <div class="form-group">
                        <label for="topSpeed">Top Speed:</label>
                        <input type="text" id="topSpeed" name="topSpeed" value="<%= bike.getTopSpeed() %>" required>
                    </div>
                </div>

                <!-- Additional Information -->
                <div class="form-section">
                    <h2>Additional Information</h2>
                    <div class="form-group">
                        <label for="warrantyInfo">Warranty Info:</label>
                        <textarea id="warrantyInfo" name="warrantyInfo" required><%= bike.getWarrantyInfo() %></textarea>
                    </div>
                    <div class="form-group">
                        <label for="stockQuantity">Stock Quantity:</label>
                        <input type="number" id="stockQuantity" name="stockQuantity" value="<%= bike.getStockQuantity() %>" required>
                    </div>
                    <div class="form-group">
                        <label for="color">Color:</label>
                        <input type="text" id="color" name="color" value="<%= bike.getColor() %>" required>
                    </div>
                    <div class="form-group">
                        <label for="description">Description:</label>
                        <textarea id="description" name="description" required><%= bike.getDescription() %></textarea>
                    </div>
                    <div class="form-group">
                        <label for="bikeImage">Bike Image:</label>
                        <input type="file" id="bikeImage" name="bikeImage" accept="image/*">
                        <small>Leave empty to keep current image</small>
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn-save">Save Changes</button>
                    <a href="manage-bikes.jsp" class="btn-cancel">Cancel</a>
                </div>
            </form>
            <%
            } else {
            %>
            <div class="error-message">
                <p>Bike not found. Please try again.</p>
                <a href="manage-bikes.jsp" class="btn-back">Back to Manage Bikes</a>
            </div>
            <%
            }
            %>
        </div>
    </div>

    <style>
    .edit-form {
        max-width: 1200px;
        margin: 20px auto;
        padding: 30px;
        background: #fff;
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    }

    .form-section {
        margin-bottom: 30px;
        padding: 25px;
        background: #f8f9fa;
        border-radius: 8px;
        border: 1px solid #e9ecef;
    }

    .form-section h2 {
        margin-top: 0;
        color: #2c3e50;
        font-size: 1.4em;
        margin-bottom: 25px;
        padding-bottom: 10px;
        border-bottom: 2px solid #e9ecef;
    }

    .form-group {
        margin-bottom: 20px;
        display: flex;
        flex-direction: column;
    }

    .form-group label {
        display: block;
        margin-bottom: 8px;
        color: #495057;
        font-weight: 500;
        font-size: 0.95em;
    }

    .form-group input,
    .form-group select,
    .form-group textarea {
        width: 100%;
        padding: 12px 15px;
        border: 1px solid #ced4da;
        border-radius: 6px;
        font-size: 0.95em;
        transition: border-color 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
    }

    .form-group input:focus,
    .form-group select:focus,
    .form-group textarea:focus {
        border-color: #80bdff;
        outline: 0;
        box-shadow: 0 0 0 0.2rem rgba(0,123,255,0.25);
    }

    .form-group textarea {
        height: 120px;
        resize: vertical;
        line-height: 1.5;
    }

    .form-group small {
        display: block;
        margin-top: 8px;
        color: #6c757d;
        font-size: 0.85em;
    }

    .form-actions {
        margin-top: 40px;
        padding-top: 20px;
        border-top: 1px solid #e9ecef;
        text-align: right;
        display: flex;
        justify-content: flex-end;
        gap: 15px;
    }

    .btn-save,
    .btn-cancel,
    .btn-back {
        padding: 12px 25px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-size: 0.95em;
        font-weight: 500;
        text-decoration: none;
        display: inline-block;
        transition: all 0.2s ease-in-out;
    }

    .btn-save {
        background-color: #28a745;
        color: white;
    }

    .btn-save:hover {
        background-color: #218838;
        transform: translateY(-1px);
    }

    .btn-cancel,
    .btn-back {
        background-color: #dc3545;
        color: white;
    }

    .btn-cancel:hover,
    .btn-back:hover {
        background-color: #c82333;
        transform: translateY(-1px);
    }

    .error-message {
        text-align: center;
        padding: 50px;
        background: #fff;
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        margin: 20px auto;
        max-width: 600px;
    }

    .error-message p {
        color: #dc3545;
        margin-bottom: 25px;
        font-size: 1.1em;
    }

    /* Responsive Grid Layout */
    @media (min-width: 768px) {
        .form-section {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .form-section h2 {
            grid-column: 1 / -1;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }
    }

    /* File Input Styling */
    input[type="file"] {
        padding: 10px;
        background: #f8f9fa;
        border: 1px dashed #ced4da;
        border-radius: 6px;
        cursor: pointer;
    }

    input[type="file"]:hover {
        border-color: #80bdff;
    }

    /* Number Input Styling */
    input[type="number"] {
        -moz-appearance: textfield;
    }

    input[type="number"]::-webkit-outer-spin-button,
    input[type="number"]::-webkit-inner-spin-button {
        -webkit-appearance: none;
        margin: 0;
    }

    /* Select Input Styling */
    select {
        appearance: none;
        background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
        background-repeat: no-repeat;
        background-position: right 10px center;
        background-size: 1em;
    }
    </style>
</body>
</html> 