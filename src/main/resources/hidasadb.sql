-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 12, 2025 at 04:06 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hidasadb`
--

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `AddressID` int(11) NOT NULL,
  `Street` varchar(255) DEFAULT NULL,
  `City` varchar(100) DEFAULT NULL,
  `State` varchar(100) DEFAULT NULL,
  `ZipCode` varchar(20) DEFAULT NULL,
  `Country` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`AddressID`, `Street`, `City`, `State`, `ZipCode`, `Country`) VALUES
(1, 'Hahahha', 'Kathmadu', '1', '56600', 'Nepal'),
(2, 'SundarHaraicha-9, Morang', 'Biratchowk', 'Koshi', '56600', 'Nepal'),
(3, 'SundarHaraicha-9, Morang', 'Biratchowk', '1', '56600', 'Nepal'),
(4, 'SundarHaraicha-9, Morang', 'Biratchowk', '', '56600', 'Nepal'),
(5, 'SundarHaraicha-9, Morang', 'Biratchowk', '1', '56600', 'Nepal');

-- --------------------------------------------------------

--
-- Table structure for table `bike`
--

CREATE TABLE `bike` (
  `BikeID` int(11) NOT NULL,
  `Brand_Name` varchar(100) DEFAULT NULL,
  `Model_Name` varchar(100) DEFAULT NULL,
  `Type` varchar(50) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `Engine_Capacity` varchar(50) DEFAULT NULL,
  `Fuel_Type` varchar(50) DEFAULT NULL,
  `Transmission` varchar(50) DEFAULT NULL,
  `Mileage` varchar(50) DEFAULT NULL,
  `Power` varchar(50) DEFAULT NULL,
  `Torque` varchar(50) DEFAULT NULL,
  `Cooling_System` varchar(50) DEFAULT NULL,
  `Brake_Type` varchar(50) DEFAULT NULL,
  `Suspension_Type` varchar(50) DEFAULT NULL,
  `Kerb_Weight` varchar(50) DEFAULT NULL,
  `Seat_Height` varchar(50) DEFAULT NULL,
  `Fuel_Tank_Capacity` varchar(50) DEFAULT NULL,
  `Top_Speed` varchar(50) DEFAULT NULL,
  `Warranty_Info` text DEFAULT NULL,
  `Stock_Quantity` int(11) DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `Color` varchar(50) DEFAULT NULL,
  `Bike_Image` longblob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bike`
--

INSERT INTO `bike` (`BikeID`, `Brand_Name`, `Model_Name`, `Type`, `Price`, `Engine_Capacity`, `Fuel_Type`, `Transmission`, `Mileage`, `Power`, `Torque`, `Cooling_System`, `Brake_Type`, `Suspension_Type`, `Kerb_Weight`, `Seat_Height`, `Fuel_Tank_Capacity`, `Top_Speed`, `Warranty_Info`, `Stock_Quantity`, `Description`, `Color`, `Bike_Image`) VALUES
(8, 'Royal Enfieldss', 'Haina ', 'Hybrid', 259000.00, '411', 'Petrol', 'Manual', '30', '24.3', '32Nm', 'Air', 'Disc', 'Monoshock', '199kg', '800', '15', '13', '3 Years', 10, 'Purposeful adventure tourer built for the Himalayas', 'Granite Black',NULL);
INSERT INTO `bike` (`BikeID`, `Brand_Name`, `Model_Name`, `Type`, `Price`, `Engine_Capacity`, `Fuel_Type`, `Transmission`, `Mileage`, `Power`, `Torque`, `Cooling_System`, `Brake_Type`, `Suspension_Type`, `Kerb_Weight`, `Seat_Height`, `Fuel_Tank_Capacity`, `Top_Speed`, `Warranty_Info`, `Stock_Quantity`, `Description`, `Color`, `Bike_Image`) VALUES
(9, 'Royal Enfield', 'Classic 350', 'Cruiser', 239000.00, '349cc', 'Petrol', 'Manual', '35km/l', '20.2bhp', '27Nm', 'Air', 'Disc', 'Dual Shock', '195kg', '790mm', '13L', '120km/h', '3 Years', 50, 'Iconic retro design with modern reliability', 'Gunmetal Grey',NULL);
INSERT INTO `bike` (`BikeID`, `Brand_Name`, `Model_Name`, `Type`, `Price`, `Engine_Capacity`, `Fuel_Type`, `Transmission`, `Mileage`, `Power`, `Torque`, `Cooling_System`, `Brake_Type`, `Suspension_Type`, `Kerb_Weight`, `Seat_Height`, `Fuel_Tank_Capacity`, `Top_Speed`, `Warranty_Info`, `Stock_Quantity`, `Description`, `Color`, `Bike_Image`) VALUES
(10, 'Honda', 'CB Hornet 2.0', 'Naked', 170000.00, '184cc', 'Petrol', 'Manual', '42km/l', '17bhp', '16.1Nm', 'Air', 'Disc', 'Monoshock', '142kg', '795mm', '12L', '126km/h', '3 Years', 50, 'Aggressive naked streetfighter with digital instrumentation', 'Pearl Igneous Black',NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_address`
--

CREATE TABLE `user_address` (
  `UserID` int(11) NOT NULL,
  `AddressID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_address`
--

INSERT INTO `user_address` (`UserID`, `AddressID`) VALUES
(1, 1),
(2, 2),
(70, 3),
(71, 4),
(72, 5);

-- --------------------------------------------------------

--
-- Table structure for table `user_feedback`
--

CREATE TABLE `user_feedback` (
  `UserID` int(11) NOT NULL,
  `FeedbackID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_feedback`
--

INSERT INTO `user_feedback` (`UserID`, `FeedbackID`) VALUES
(2, 1),
(2, 2),
(2, 3),
(2, 4);

-- --------------------------------------------------------

--
-- Table structure for table `user_order`
--

CREATE TABLE `user_order` (
  `UserID` int(11) NOT NULL,
  `OrderID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_order`
--

INSERT INTO `user_order` (`UserID`, `OrderID`) VALUES
(2, 34),
(2, 35),
(2, 36),
(2, 37),
(70, 40),
(70, 41),
(70, 42);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`AddressID`);

--
-- Indexes for table `bike`
--
ALTER TABLE `bike`
  ADD PRIMARY KEY (`BikeID`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`FeedbackID`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`OrderID`);

--
-- Indexes for table `orderdetail`
--
ALTER TABLE `orderdetail`
  ADD PRIMARY KEY (`OrderDetailID`),
  ADD KEY `OrderID` (`OrderID`),
  ADD KEY `BikeID` (`BikeID`);

--
-- Indexes for table `order_payment`
--
ALTER TABLE `order_payment`
  ADD PRIMARY KEY (`OrderID`,`PaymentID`),
  ADD KEY `PaymentID` (`PaymentID`);

--
-- Indexes for table `order_sale`
--
ALTER TABLE `order_sale`
  ADD PRIMARY KEY (`OrderID`,`SaleID`),
  ADD KEY `SaleID` (`SaleID`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`PaymentID`);

--
-- Indexes for table `sale`
--
ALTER TABLE `sale`
  ADD PRIMARY KEY (`SaleID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`UserID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `user_address`
--
ALTER TABLE `user_address`
  ADD PRIMARY KEY (`UserID`,`AddressID`),
  ADD KEY `AddressID` (`AddressID`);

--
-- Indexes for table `user_feedback`
--
ALTER TABLE `user_feedback`
  ADD PRIMARY KEY (`UserID`,`FeedbackID`),
  ADD KEY `FeedbackID` (`FeedbackID`);

--
-- Indexes for table `user_order`
--
ALTER TABLE `user_order`
  ADD PRIMARY KEY (`UserID`,`OrderID`),
  ADD KEY `OrderID` (`OrderID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `AddressID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `bike`
--
ALTER TABLE `bike`
  MODIFY `BikeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `FeedbackID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `OrderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `orderdetail`
--
ALTER TABLE `orderdetail`
  MODIFY `OrderDetailID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `PaymentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `sale`
--
ALTER TABLE `sale`
  MODIFY `SaleID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orderdetail`
--
ALTER TABLE `orderdetail`
  ADD CONSTRAINT `orderdetail_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `order` (`OrderID`),
  ADD CONSTRAINT `orderdetail_ibfk_2` FOREIGN KEY (`BikeID`) REFERENCES `bike` (`BikeID`);

--
-- Constraints for table `order_payment`
--
ALTER TABLE `order_payment`
  ADD CONSTRAINT `order_payment_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `order` (`OrderID`),
  ADD CONSTRAINT `order_payment_ibfk_2` FOREIGN KEY (`PaymentID`) REFERENCES `payment` (`PaymentID`);

--
-- Constraints for table `order_sale`
--
ALTER TABLE `order_sale`
  ADD CONSTRAINT `order_sale_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `order` (`OrderID`),
  ADD CONSTRAINT `order_sale_ibfk_2` FOREIGN KEY (`SaleID`) REFERENCES `sale` (`SaleID`);

--
-- Constraints for table `user_address`
--
ALTER TABLE `user_address`
  ADD CONSTRAINT `user_address_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`),
  ADD CONSTRAINT `user_address_ibfk_2` FOREIGN KEY (`AddressID`) REFERENCES `address` (`AddressID`);

--
-- Constraints for table `user_feedback`
--
ALTER TABLE `user_feedback`
  ADD CONSTRAINT `user_feedback_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`),
  ADD CONSTRAINT `user_feedback_ibfk_2` FOREIGN KEY (`FeedbackID`) REFERENCES `feedback` (`FeedbackID`);

--
-- Constraints for table `user_order`
--
ALTER TABLE `user_order`
  ADD CONSTRAINT `user_order_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`),
  ADD CONSTRAINT `user_order_ibfk_2` FOREIGN KEY (`OrderID`) REFERENCES `order` (`OrderID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
