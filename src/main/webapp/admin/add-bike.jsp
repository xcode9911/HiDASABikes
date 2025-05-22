<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Bike - Bike Showroom Admin</title>
    <link rel="stylesheet" href="../assets/css/adminStyle.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .form-container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
        }
        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        .form-group textarea {
            resize: vertical;
        }
        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 15px;
        }
        .form-row .form-group {
            flex: 1;
        }
        button[type="submit"] {
            background: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        button[type="submit"]:hover {
            background: #0056b3;
        }
        
        /* Popup Styles */
        .popup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            z-index: 1000;
            text-align: center;
        }
        
        .popup-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 999;
        }
        
        .popup button {
            margin-top: 15px;
            padding: 8px 20px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        
        .popup button:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
    <jsp:include page="adminsidebar.jsp" />

    <!-- Popup HTML -->
    <div class="popup-overlay" id="popupOverlay"></div>
    <div class="popup" id="successPopup">
        <h3>Success!</h3>
        <p>Bike has been added successfully.</p>
        <button onclick="closePopup()">OK</button>
    </div>

    <div class="container">
    
        <!-- Main Content -->
        <div class="main-content">
            <h1>Add New Bike</h1>
            
            <div class="form-container">
                <form action="../AdminDashboardServlet" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="addBike">
                    
                    <!-- Basic Information -->
                    <h2>Basic Information</h2>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="brandName">Brand Name</label>
                            <input type="text" id="brandName" name="brandName" required>
                        </div>
                        <div class="form-group">
                            <label for="modelName">Model Name</label>
                            <input type="text" id="modelName" name="modelName" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="type">Type</label>
                            <select id="type" name="type" required>
                                <option value="">Select Type</option>
                                <option value="Cruiser">Cruiser</option>
                                <option value="Sports">Sports</option>
                                <option value="Adventure">Adventure</option>
                                <option value="Naked">Naked</option>
                                <option value="Scooter">Scooter</option>
                                <option value="Electric">Electric</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="price">Price (NPR)</label>
                            <input type="number" id="price" name="price" min="0" step="0.01" required>
                        </div>
                    </div>

                    <!-- Engine Specifications -->
                    <h2>Engine Specifications</h2>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="engineCapacity">Engine Capacity</label>
                            <input type="text" id="engineCapacity" name="engineCapacity" placeholder="e.g., 155cc" required>
                        </div>
                        <div class="form-group">
                            <label for="fuelType">Fuel Type</label>
                            <select id="fuelType" name="fuelType" required>
                                <option value="">Select Fuel Type</option>
                                <option value="Petrol">Petrol</option>
                                <option value="Electric">Electric</option>
                                <option value="Hybrid">Hybrid</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="transmission">Transmission</label>
                            <select id="transmission" name="transmission" required>
                                <option value="">Select Transmission</option>
                                <option value="Manual">Manual</option>
                                <option value="Automatic">Automatic</option>
                                <option value="Semi-Automatic">Semi-Automatic</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="mileage">Mileage</label>
                            <input type="text" id="mileage" name="mileage" placeholder="e.g., 45 km/l" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="power">Power</label>
                            <input type="text" id="power" name="power" placeholder="e.g., 15 HP" required>
                        </div>
                        <div class="form-group">
                            <label for="torque">Torque</label>
                            <input type="text" id="torque" name="torque" placeholder="e.g., 14 Nm" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="coolingSystem">Cooling System</label>
                        <select id="coolingSystem" name="coolingSystem" required>
                            <option value="">Select Cooling System</option>
                            <option value="Air">Air</option>
                            <option value="Liquid">Liquid</option>
                            <option value="Oil">Oil</option>
                        </select>
                    </div>

                    <!-- Hardware & Dimensions -->
                    <h2>Hardware & Dimensions</h2>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="brakeType">Brake Type</label>
                            <select id="brakeType" name="brakeType" required>
                                <option value="">Select Brake Type</option>
                                <option value="Disc">Disc</option>
                                <option value="Drum">Drum</option>
                                <option value="ABS">ABS</option>
                                <option value="CBS">CBS</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="suspensionType">Suspension Type</label>
                            <select id="suspensionType" name="suspensionType" required>
                                <option value="">Select Suspension Type</option>
                                <option value="Telescopic">Telescopic</option>
                                <option value="Monoshock">Monoshock</option>
                                <option value="Dual Shock">Dual Shock</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="kerbWeight">Kerb Weight (kg)</label>
                            <input type="text" id="kerbWeight" name="kerbWeight" required>
                        </div>
                        <div class="form-group">
                            <label for="seatHeight">Seat Height (mm)</label>
                            <input type="text" id="seatHeight" name="seatHeight" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="fuelTankCapacity">Fuel Tank Capacity (L)</label>
                            <input type="text" id="fuelTankCapacity" name="fuelTankCapacity" required>
                        </div>
                        <div class="form-group">
                            <label for="topSpeed">Top Speed (km/h)</label>
                            <input type="text" id="topSpeed" name="topSpeed" required>
                        </div>
                    </div>

                    <!-- Additional Information -->
                    <h2>Additional Information</h2>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="warrantyInfo">Warranty Info</label>
                            <input type="text" id="warrantyInfo" name="warrantyInfo" placeholder="e.g., 3 Years / 30,000km" required>
                        </div>
                        <div class="form-group">
                            <label for="stockQuantity">Stock Quantity</label>
                            <input type="number" id="stockQuantity" name="stockQuantity" min="0" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="color">Color</label>
                        <input type="text" id="color" name="color" required>
                    </div>

                    <div class="form-group">
                        <label for="description">Description</label>
                        <textarea id="description" name="description" rows="4" required></textarea>
                    </div>

                    <div class="form-group">
                        <label for="bikeImage">Bike Image</label>
                        <input type="file" id="bikeImage" name="bikeImage" accept="image/*" required>
                    </div>

                    <div class="form-group">
                        <button type="submit">Add Bike</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function showPopup() {
            document.getElementById('popupOverlay').style.display = 'block';
            document.getElementById('successPopup').style.display = 'block';
        }

        function closePopup() {
            document.getElementById('popupOverlay').style.display = 'none';
            document.getElementById('successPopup').style.display = 'none';
        }

        document.querySelector('form').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const formData = new FormData(this);
            
            fetch('../AdminDashboardServlet', {
                method: 'POST',
                body: formData
            })
            .then(response => response.text())
            .then(data => {
                showPopup();
                this.reset(); // Reset form after successful submission
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred while adding the bike. Please try again.');
            });
        });
    </script>
</body>
</html> 