-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 21, 2025 at 05:15 PM
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
  `Bike_Image` blob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `FeedbackID` int(11) NOT NULL,
  `Subject` varchar(255) DEFAULT NULL,
  `Message` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `OrderID` int(11) NOT NULL,
  `Order_Date` date DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orderdetail`
--

CREATE TABLE `orderdetail` (
  `OrderDetailID` int(11) NOT NULL,
  `OrderID` int(11) DEFAULT NULL,
  `BikeID` int(11) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_payment`
--

CREATE TABLE `order_payment` (
  `OrderID` int(11) NOT NULL,
  `PaymentID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_sale`
--

CREATE TABLE `order_sale` (
  `OrderID` int(11) NOT NULL,
  `SaleID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `PaymentID` int(11) NOT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  `Payment_Method` varchar(50) DEFAULT NULL,
  `Payment_Status` varchar(50) DEFAULT NULL,
  `Payment_Date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sale`
--

CREATE TABLE `sale` (
  `SaleID` int(11) NOT NULL,
  `Sale_Date` date DEFAULT NULL,
  `Total_Sale_Amount` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `UserID` int(11) NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `Profile_Image` LONGBLOB DEFAULT NULL,
  `Role` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_address`
--

CREATE TABLE `user_address` (
  `UserID` int(11) NOT NULL,
  `AddressID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_feedback`
--

CREATE TABLE `user_feedback` (
  `UserID` int(11) NOT NULL,
  `FeedbackID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_order`
--

CREATE TABLE `user_order` (
  `UserID` int(11) NOT NULL,
  `OrderID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  MODIFY `AddressID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bike`
--
ALTER TABLE `bike`
  MODIFY `BikeID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `FeedbackID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `OrderID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orderdetail`
--
ALTER TABLE `orderdetail`
  MODIFY `OrderDetailID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `PaymentID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sale`
--
ALTER TABLE `sale`
  MODIFY `SaleID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT;

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
