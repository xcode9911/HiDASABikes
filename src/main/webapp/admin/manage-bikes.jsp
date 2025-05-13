<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="modal.Bike" %>
<%@ page import="dao.BikeDAO" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Bikes - Bike Showroom Admin</title>
    <link rel="stylesheet" href="../assets/css/adminStyle.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <jsp:include page="adminsidebar.jsp" />

    <div class="container">
        <!-- Main Content -->
        <div class="main-content">
            <h1>Manage Bikes</h1>
            
            <!-- Search and Filter Section -->
            <div class="table-container">
                <form action="../ManageBikesServlet" method="get" style="margin-bottom: 20px;">
                    <input type="hidden" name="action" value="searchBikes">
                    <input type="text" name="searchQuery" placeholder="Search by model name..." style="width: 300px; margin-right: 10px;" value="<%= request.getParameter("searchQuery") != null ? request.getParameter("searchQuery") : "" %>">
                    <select name="type" style="width: 200px; margin-right: 10px;">
                        <option value="">All Categories</option>
                        <option value="Mountain" <%= "Mountain".equals(request.getParameter("type")) ? "selected" : "" %>>Mountain Bike</option>
                        <option value="Road" <%= "Road".equals(request.getParameter("type")) ? "selected" : "" %>>Road Bike</option>
                        <option value="Hybrid" <%= "Hybrid".equals(request.getParameter("type")) ? "selected" : "" %>>Hybrid Bike</option>
                        <option value="Electric" <%= "Electric".equals(request.getParameter("type")) ? "selected" : "" %>>Electric Bike</option>
                    </select>
                    <button type="submit">Search</button>
                </form>

                <!-- Message Display -->
                <%
                String message = request.getParameter("message");
                if (message != null) {
                    String messageClass = "";
                    String messageText = "";
                    
                    switch (message) {
                        case "updateSuccess":
                            messageClass = "success-message";
                            messageText = "Bike updated successfully!";
                            break;
                        case "deleteSuccess":
                            messageClass = "success-message";
                            messageText = "Bike deleted successfully!";
                            break;
                        case "updateFailed":
                            messageClass = "error-message";
                            messageText = "Failed to update bike. Please try again.";
                            break;
                        case "deleteFailed":
                            messageClass = "error-message";
                            messageText = "Failed to delete bike. Please try again.";
                            break;
                        case "bikeNotFound":
                            messageClass = "error-message";
                            messageText = "Bike not found.";
                            break;
                        case "error":
                            messageClass = "error-message";
                            messageText = "An error occurred. Please try again.";
                            break;
                    }
                %>
                    <div class="<%= messageClass %>">
                        <%= messageText %>
                    </div>
                <%
                }
                %>

                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Brand</th>
                            <th>Model</th>
                            <th>Type</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        BikeDAO bikeDAO = new BikeDAO();
                        List<Bike> bikes = bikeDAO.getAllBikes();
                        
                        if (bikes != null && !bikes.isEmpty()) {
                            for (Bike bike : bikes) {
                                String statusClass = "";
                                String statusText = "";
                                
                                if (bike.getStockQuantity() > 10) {
                                    statusClass = "status-completed";
                                    statusText = "In Stock";
                                } else if (bike.getStockQuantity() > 0) {
                                    statusClass = "status-pending";
                                    statusText = "Low Stock";
                                } else {
                                    statusClass = "status-cancelled";
                                    statusText = "Out of Stock";
                                }
                        %>
                            <tr>
                                <td><%= bike.getBikeId() %></td>
                                <td><%= bike.getBrandName() %></td>
                                <td><%= bike.getModelName() %></td>
                                <td><%= bike.getType() %></td>
                                <td>₹<%= String.format("%.2f", bike.getPrice()) %></td>
                                <td><%= bike.getStockQuantity() %></td>
                                <td><span class="status-badge <%= statusClass %>"><%= statusText %></span></td>
                                <td>
                                    <button type="button" onclick="openEditModal(<%= bike.getBikeId() %>)" class="btn-edit">Edit</button>
                                    <button onclick="deleteBike(<%= bike.getBikeId() %>)" class="btn-delete">Delete</button>
                                </td>
                            </tr>
                        <%
                            }
                        } else {
                        %>
                            <tr>
                                <td colspan="8" style="text-align: center;">No bikes found</td>
                            </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Edit Bike Modal -->
    <div id="editBikeModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>Edit Bike</h2>
            <form id="editBikeForm">
                <input type="hidden" name="action" value="updateBike">
                <input type="hidden" name="bikeId" id="editBikeId" readonly>
                
                <!-- Basic Information -->
                <div class="form-section">
                    <h3>Basic Information</h3>
                    <div class="form-group">
                        <label for="editBrandName">Brand Name:</label>
                        <input type="text" id="editBrandName" name="brandName" required>
                    </div>
                    <div class="form-group">
                        <label for="editModelName">Model Name:</label>
                        <input type="text" id="editModelName" name="modelName" required>
                    </div>
                    <div class="form-group">
                        <label for="editType">Type:</label>
                        <select id="editType" name="type" required>
                            <option value="Mountain">Mountain Bike</option>
                            <option value="Road">Road Bike</option>
                            <option value="Hybrid">Hybrid Bike</option>
                            <option value="Electric">Electric Bike</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="editPrice">Price (₹):</label>
                        <input type="number" id="editPrice" name="price" step="0.01" required>
                    </div>
                </div>

                <!-- Engine Specifications -->
                <div class="form-section">
                    <h3>Engine Specifications</h3>
                    <div class="form-group">
                        <label for="editEngineCapacity">Engine Capacity:</label>
                        <input type="text" id="editEngineCapacity" name="engineCapacity" required>
                    </div>
                    <div class="form-group">
                        <label for="editFuelType">Fuel Type:</label>
                        <input type="text" id="editFuelType" name="fuelType" required>
                    </div>
                    <div class="form-group">
                        <label for="editTransmission">Transmission:</label>
                        <input type="text" id="editTransmission" name="transmission" required>
                    </div>
                    <div class="form-group">
                        <label for="editMileage">Mileage:</label>
                        <input type="text" id="editMileage" name="mileage" required>
                    </div>
                    <div class="form-group">
                        <label for="editPower">Power:</label>
                        <input type="text" id="editPower" name="power" required>
                    </div>
                    <div class="form-group">
                        <label for="editTorque">Torque:</label>
                        <input type="text" id="editTorque" name="torque" required>
                    </div>
                    <div class="form-group">
                        <label for="editCoolingSystem">Cooling System:</label>
                        <input type="text" id="editCoolingSystem" name="coolingSystem" required>
                    </div>
                </div>

                <!-- Hardware & Dimensions -->
                <div class="form-section">
                    <h3>Hardware & Dimensions</h3>
                    <div class="form-group">
                        <label for="editBrakeType">Brake Type:</label>
                        <input type="text" id="editBrakeType" name="brakeType" required>
                    </div>
                    <div class="form-group">
                        <label for="editSuspensionType">Suspension Type:</label>
                        <input type="text" id="editSuspensionType" name="suspensionType" required>
                    </div>
                    <div class="form-group">
                        <label for="editKerbWeight">Kerb Weight:</label>
                        <input type="text" id="editKerbWeight" name="kerbWeight" required>
                    </div>
                    <div class="form-group">
                        <label for="editSeatHeight">Seat Height:</label>
                        <input type="text" id="editSeatHeight" name="seatHeight" required>
                    </div>
                    <div class="form-group">
                        <label for="editFuelTankCapacity">Fuel Tank Capacity:</label>
                        <input type="text" id="editFuelTankCapacity" name="fuelTankCapacity" required>
                    </div>
                    <div class="form-group">
                        <label for="editTopSpeed">Top Speed:</label>
                        <input type="text" id="editTopSpeed" name="topSpeed" required>
                    </div>
                </div>

                <!-- Additional Information -->
                <div class="form-section">
                    <h3>Additional Information</h3>
                    <div class="form-group">
                        <label for="editWarrantyInfo">Warranty Info:</label>
                        <textarea id="editWarrantyInfo" name="warrantyInfo" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="editStockQuantity">Stock Quantity:</label>
                        <input type="number" id="editStockQuantity" name="stockQuantity" required>
                    </div>
                    <div class="form-group">
                        <label for="editColor">Color:</label>
                        <input type="text" id="editColor" name="color" required>
                    </div>
                    <div class="form-group">
                        <label for="editDescription">Description:</label>
                        <textarea id="editDescription" name="description" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="editBikeImage">Bike Image:</label>
                        <input type="file" id="editBikeImage" name="bikeImage" accept="image/*">
                        <small>Leave empty to keep current image</small>
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn-save">Save Changes</button>
                    <button type="button" class="btn-cancel" onclick="closeEditModal()">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <style>
    /* Modal Styles */
    .modal {
        display: none;
        position: fixed;
        z-index: 1000;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0,0,0,0.5);
        overflow-y: auto;
    }

    .modal-content {
        background-color: #fefefe;
        margin: 5% auto;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        width: 90%;
        max-width: 1200px;
        position: relative;
    }

    .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
        cursor: pointer;
        position: absolute;
        right: 20px;
        top: 10px;
    }

    .close:hover,
    .close:focus {
        color: black;
        text-decoration: none;
    }

    .modal h2 {
        margin-top: 0;
        margin-bottom: 20px;
        color: #2c3e50;
        padding-bottom: 10px;
        border-bottom: 2px solid #e9ecef;
    }

    .modal .form-section {
        margin-bottom: 20px;
        padding: 20px;
        background: #f8f9fa;
        border-radius: 8px;
        border: 1px solid #e9ecef;
    }

    .modal .form-section h3 {
        margin-top: 0;
        color: #2c3e50;
        font-size: 1.2em;
        margin-bottom: 15px;
    }

    .modal .form-group {
        margin-bottom: 15px;
    }

    .modal .form-group label {
        display: block;
        margin-bottom: 5px;
        color: #495057;
        font-weight: 500;
    }

    .modal .form-group input,
    .modal .form-group select,
    .modal .form-group textarea {
        width: 100%;
        padding: 8px 12px;
        border: 1px solid #ced4da;
        border-radius: 4px;
        font-size: 14px;
    }

    .modal .form-group textarea {
        height: 100px;
        resize: vertical;
    }

    .modal .form-actions {
        margin-top: 20px;
        text-align: right;
    }

    .modal .btn-save,
    .modal .btn-cancel {
        padding: 10px 20px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 14px;
        margin-left: 10px;
    }

    .modal .btn-save {
        background-color: #28a745;
        color: white;
    }

    .modal .btn-cancel {
        background-color: #dc3545;
        color: white;
    }

    .loading {
        text-align: center;
        padding: 20px;
        font-size: 1.2em;
        color: #666;
    }

    .error-message {
        text-align: center;
        padding: 20px;
    }

    .error-message h3 {
        color: #dc3545;
        margin-bottom: 10px;
    }

    .error-message p {
        color: #666;
        margin-bottom: 20px;
    }
    

    @media (min-width: 768px) {
        .modal .form-section {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
        }

        .modal .form-section h3 {
            grid-column: 1 / -1;
        }
    }
    </style>

    <script>
    // Global variable to store the current bike ID
    let currentBikeId = null;

    function openEditModal(bikeId) {
        console.log("Opening modal for bike ID:", bikeId);
        
        // Validate bikeId
        if (!bikeId || isNaN(bikeId)) {
            console.error("Invalid bike ID:", bikeId);
            showErrorInModal("Invalid bike ID");
            return;
        }
        
        currentBikeId = bikeId;
        
        // Show loading state
        const modal = document.getElementById("editBikeModal");
        modal.style.display = "block";
        
        // Show loading message
            modal.querySelector('.modal-content').innerHTML = `
                <span class="close">&times;</span>
            <div class="loading">
                <h3>Loading Bike Data...</h3>
                <p>Please wait while we fetch the bike details.</p>
                </div>
            `;
            attachModalEventListeners();
        
        // Fetch bike data with proper URL encoding
        const url = new URL('../ManageBikesServlet', window.location.href);
        url.searchParams.append('action', 'getBike');
        url.searchParams.append('bikeId', bikeId.toString());
        
        console.log("Fetching bike data from:", url.toString());
        
        fetch(url)
            .then(response => {
                console.log("Response status:", response.status);
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                return response.json();
            })
            .then(bike => {
                console.log("Received bike data:", bike);
                if (!bike || !bike.bikeId) {
                    throw new Error("Invalid bike data received");
                }
                populateModalForm(bike);
            })
            .catch(error => {
                console.error('Error:', error);
                showErrorInModal(error.message);
            });
    }

    function showErrorInModal(message) {
        const modal = document.getElementById("editBikeModal");
        modal.querySelector('.modal-content').innerHTML = `
            <span class="close">&times;</span>
            <div class="error-message">
                <h3>Error Loading Bike Data</h3>
                <p>${message}</p>
                <button onclick="closeEditModal()" class="btn-cancel">Close</button>
            </div>
        `;
        attachModalEventListeners();
    }

    function populateModalForm(bike) {
        const modal = document.getElementById("editBikeModal");
        
        // Restore the original form content
        modal.querySelector('.modal-content').innerHTML = `
            <span class="close">&times;</span>
            <h2>Edit Bike</h2>
            <form id="editBikeForm">
                <input type="hidden" name="action" value="updateBike">
                <input type="hidden" name="bikeId" id="editBikeId" readonly>
                
                <!-- Basic Information -->
                <div class="form-section">
                    <h3>Basic Information</h3>
                    <div class="form-group">
                        <label for="editBrandName">Brand Name:</label>
                        <input type="text" id="editBrandName" name="brandName" required>
                    </div>
                    <div class="form-group">
                        <label for="editModelName">Model Name:</label>
                        <input type="text" id="editModelName" name="modelName" required>
                    </div>
                    <div class="form-group">
                        <label for="editType">Type:</label>
                        <select id="editType" name="type" required>
                            <option value="Mountain">Mountain Bike</option>
                            <option value="Road">Road Bike</option>
                            <option value="Hybrid">Hybrid Bike</option>
                            <option value="Electric">Electric Bike</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="editPrice">Price (₹):</label>
                        <input type="number" id="editPrice" name="price" step="0.01" required>
                    </div>
                </div>

                <!-- Engine Specifications -->
                <div class="form-section">
                    <h3>Engine Specifications</h3>
                    <div class="form-group">
                        <label for="editEngineCapacity">Engine Capacity:</label>
                        <input type="text" id="editEngineCapacity" name="engineCapacity" required>
                    </div>
                    <div class="form-group">
                        <label for="editFuelType">Fuel Type:</label>
                        <input type="text" id="editFuelType" name="fuelType" required>
                    </div>
                    <div class="form-group">
                        <label for="editTransmission">Transmission:</label>
                        <input type="text" id="editTransmission" name="transmission" required>
                    </div>
                    <div class="form-group">
                        <label for="editMileage">Mileage:</label>
                        <input type="text" id="editMileage" name="mileage" required>
                    </div>
                    <div class="form-group">
                        <label for="editPower">Power:</label>
                        <input type="text" id="editPower" name="power" required>
                    </div>
                    <div class="form-group">
                        <label for="editTorque">Torque:</label>
                        <input type="text" id="editTorque" name="torque" required>
                    </div>
                    <div class="form-group">
                        <label for="editCoolingSystem">Cooling System:</label>
                        <input type="text" id="editCoolingSystem" name="coolingSystem" required>
                    </div>
                </div>

                <!-- Hardware & Dimensions -->
                <div class="form-section">
                    <h3>Hardware & Dimensions</h3>
                    <div class="form-group">
                        <label for="editBrakeType">Brake Type:</label>
                        <input type="text" id="editBrakeType" name="brakeType" required>
                    </div>
                    <div class="form-group">
                        <label for="editSuspensionType">Suspension Type:</label>
                        <input type="text" id="editSuspensionType" name="suspensionType" required>
                    </div>
                    <div class="form-group">
                        <label for="editKerbWeight">Kerb Weight:</label>
                        <input type="text" id="editKerbWeight" name="kerbWeight" required>
                    </div>
                    <div class="form-group">
                        <label for="editSeatHeight">Seat Height:</label>
                        <input type="text" id="editSeatHeight" name="seatHeight" required>
                    </div>
                    <div class="form-group">
                        <label for="editFuelTankCapacity">Fuel Tank Capacity:</label>
                        <input type="text" id="editFuelTankCapacity" name="fuelTankCapacity" required>
                    </div>
                    <div class="form-group">
                        <label for="editTopSpeed">Top Speed:</label>
                        <input type="text" id="editTopSpeed" name="topSpeed" required>
                    </div>
                </div>

                <!-- Additional Information -->
                <div class="form-section">
                    <h3>Additional Information</h3>
                    <div class="form-group">
                        <label for="editWarrantyInfo">Warranty Info:</label>
                        <textarea id="editWarrantyInfo" name="warrantyInfo" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="editStockQuantity">Stock Quantity:</label>
                        <input type="number" id="editStockQuantity" name="stockQuantity" required>
                    </div>
                    <div class="form-group">
                        <label for="editColor">Color:</label>
                        <input type="text" id="editColor" name="color" required>
                    </div>
                    <div class="form-group">
                        <label for="editDescription">Description:</label>
                        <textarea id="editDescription" name="description" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="editBikeImage">Bike Image:</label>
                        <input type="file" id="editBikeImage" name="bikeImage" accept="image/*">
                        <small>Leave empty to keep current image</small>
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn-save">Save Changes</button>
                    <button type="button" class="btn-cancel" onclick="closeEditModal()">Cancel</button>
                </div>
            </form>
        `;
                
                // Helper function to safely set form field values
                const setFieldValue = (fieldId, value) => {
                    const field = document.getElementById(fieldId);
                    if (field) {
                        field.value = value || '';
                        console.log(`Setting ${fieldId} to:`, value);
                    } else {
                        console.warn(`Field not found: ${fieldId}`);
                    }
                };
        
        // Set the bike ID (readonly)
        setFieldValue("editBikeId", bike.bikeId);
                
                // Populate form fields
                setFieldValue("editBrandName", bike.brandName);
                setFieldValue("editModelName", bike.modelName);
                setFieldValue("editType", bike.type);
                setFieldValue("editPrice", bike.price);
                setFieldValue("editEngineCapacity", bike.engineCapacity);
                setFieldValue("editFuelType", bike.fuelType);
                setFieldValue("editTransmission", bike.transmission);
                setFieldValue("editMileage", bike.mileage);
                setFieldValue("editPower", bike.power);
                setFieldValue("editTorque", bike.torque);
                setFieldValue("editCoolingSystem", bike.coolingSystem);
                setFieldValue("editBrakeType", bike.brakeType);
                setFieldValue("editSuspensionType", bike.suspensionType);
                setFieldValue("editKerbWeight", bike.kerbWeight);
                setFieldValue("editSeatHeight", bike.seatHeight);
                setFieldValue("editFuelTankCapacity", bike.fuelTankCapacity);
                setFieldValue("editTopSpeed", bike.topSpeed);
                setFieldValue("editWarrantyInfo", bike.warrantyInfo);
                setFieldValue("editStockQuantity", bike.stockQuantity);
                setFieldValue("editColor", bike.color);
                setFieldValue("editDescription", bike.description);

                // Reattach event listeners
                attachModalEventListeners();
    }

    function attachModalEventListeners() {
        const modal = document.getElementById("editBikeModal");
        const span = document.getElementsByClassName("close")[0];
        
        // Close modal when clicking (x)
        if (span) {
        span.onclick = function() {
            closeEditModal();
            }
        }

        // Handle form submission
        const form = document.getElementById("editBikeForm");
        if (form) {
            form.onsubmit = function(e) {
                e.preventDefault();
                
                const formData = new FormData(this);
                formData.append("bikeId", currentBikeId);
                
                fetch('../ManageBikesServlet', {
                    method: 'POST',
                    body: formData
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error(`HTTP error! status: ${response.status}`);
                    }
                    return response.text();
                })
                .then(result => {
                    closeEditModal();
                    // Reload the page to show updated data
                    window.location.reload();
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Error updating bike: ' + error.message);
                });
            };
        }
    }

    function closeEditModal() {
        const modal = document.getElementById("editBikeModal");
        modal.style.display = "none";
        currentBikeId = null;
    }

    // Close modal when clicking outside
    window.onclick = function(event) {
        const modal = document.getElementById("editBikeModal");
        if (event.target == modal) {
            closeEditModal();
        }
    }

    function deleteBike(bikeId) {
        if (confirm('Are you sure you want to delete this bike?')) {
            window.location.href = '../ManageBikesServlet?action=deleteBike&bikeId=' + bikeId;
        }
    }

    // Initialize modal event listeners when the page loads
    document.addEventListener('DOMContentLoaded', function() {
        attachModalEventListeners();
    });
    </script>
</body>
</html> 