-- Sample bike data for HidasaBikes
-- Make sure to run the hidasadb.sql script first to create the tables

-- Insert bike data
INSERT INTO bike (Brand_Name, Model_Name, Type, Price, Engine_Capacity, Fuel_Type, Transmission, Mileage, Power, Torque, Cooling_System, Brake_Type, Suspension_Type, Kerb_Weight, Seat_Height, Fuel_Tank_Capacity, Top_Speed, Warranty_Info, Stock_Quantity, Description, Color)
VALUES 
-- Cruiser Bikes
('Royal Enfield', 'Classic 350', 'Cruiser', 219000.00, '349cc', 'Petrol', 'Manual', '35 kmpl', '20.2 bhp @ 6100 rpm', '27 Nm @ 4000 rpm', 'Air Cooling', 'Disc', 'Telescopic', '195 kg', '805 mm', '13 L', '120 kmph', '3 Years', 12, 'The all-new Classic 350 continues to embody the traditions and craftsmanship of the past as it marries modern technology, making it the most coveted Royal Enfield motorcycle.', 'Chrome Bronze'),

('Jawa', '42', 'Cruiser', 189000.00, '293cc', 'Petrol', 'Manual', '40 kmpl', '27.33 PS @ 6800 rpm', '27.02 Nm @ 5000 rpm', 'Liquid Cooling', 'Disc', 'Telescopic', '172 kg', '795 mm', '14 L', '125 kmph', '2 Years', 8, 'The 42 from Jawa is a neo-retro motorcycle that combines classic design with modern technologies to provide an unmatched riding experience.', 'Deep Red'),

('Harley-Davidson', 'Iron 883', 'Cruiser', 1050000.00, '883cc', 'Petrol', 'Manual', '20 kmpl', '50 bhp @ 6000 rpm', '70 Nm @ 4750 rpm', 'Air Cooling', 'Disc', 'Telescopic', '256 kg', '760 mm', '12.5 L', '140 kmph', '2 Years', 5, 'The Iron 883 is a nimble urban machine that kicks asphalt. Low-slung, blacked-out and stripped-down, it brings raw, aggressive style to the street.', 'Black Denim'),

-- Sport Bikes
('Kawasaki', 'Ninja 400', 'Sport', 499000.00, '399cc', 'Petrol', 'Manual', '28 kmpl', '49 PS @ 10000 rpm', '38 Nm @ 8000 rpm', 'Liquid Cooling', 'Disc', 'Telescopic', '168 kg', '785 mm', '14 L', '190 kmph', '2 Years', 6, 'The Ninja 400 offers the largest displacement in its category, delivering greater power for more excitement. This lightweight, nimble motorcycle offers easy handling and a confidence-inspiring ride.', 'Lime Green'),

('Yamaha', 'R15 V4', 'Sport', 179000.00, '155cc', 'Petrol', 'Manual', '45 kmpl', '18.4 PS @ 10000 rpm', '14.2 Nm @ 7500 rpm', 'Liquid Cooling', 'Disc', 'Telescopic', '142 kg', '815 mm', '11 L', '145 kmph', '1 Year', 15, 'The R15 V4 is a super sport motorcycle that is the closest you can get to YZR-M1 MotoGP bike in terms of styling and design. A blend of aggressive styling and race-bred performance.', 'Racing Blue'),

('KTM', 'RC 390', 'Sport', 289000.00, '373cc', 'Petrol', 'Manual', '25 kmpl', '43.5 PS @ 9000 rpm', '37 Nm @ 7000 rpm', 'Liquid Cooling', 'Disc', 'WP APEX', '158 kg', '820 mm', '13.7 L', '179 kmph', '2 Years', 9, 'The RC 390 is KTM's full-faired sport bike with MotoGP styling, that delivers outstanding racetrack performance and everyday usability.', 'Orange'),

-- Commuter Bikes
('Hero', 'Splendor Plus', 'Commuter', 72000.00, '97.2cc', 'Petrol', 'Manual', '70 kmpl', '8.02 PS @ 8000 rpm', '8.05 Nm @ 6000 rpm', 'Air Cooling', 'Drum', 'Telescopic', '112 kg', '785 mm', '9.8 L', '90 kmph', '5 Years', 25, 'The Splendor Plus is India's most trusted motorcycle that offers incredible fuel efficiency, reliability and comfort for daily commuting.', 'Black with Silver'),

('Honda', 'Shine', 'Commuter', 78000.00, '124cc', 'Petrol', 'Manual', '65 kmpl', '10.7 bhp @ 7500 rpm', '11 Nm @ 6000 rpm', 'Air Cooling', 'Drum', 'Telescopic', '114 kg', '790 mm', '10.5 L', '95 kmph', '3 Years', 20, 'The Honda Shine is a 125cc motorcycle known for its reliability, comfort and excellent fuel efficiency, designed to meet the needs of daily commuters.', 'Imperial Red Metallic'),

('TVS', 'Raider', 'Commuter', 85000.00, '124.8cc', 'Petrol', 'Manual', '67 kmpl', '11.38 PS @ 7500 rpm', '11.2 Nm @ 6000 rpm', 'Air Cooling', 'Disc', 'Telescopic', '123 kg', '780 mm', '10 L', '99 kmph', '2 Years', 18, 'The TVS Raider is a stylish commuter motorcycle that offers a combination of performance, comfort and features not typically found in the 125cc segment.', 'Striking Red'),

-- Adventure Bikes
('Royal Enfield', 'Himalayan', 'Adventure', 249000.00, '411cc', 'Petrol', 'Manual', '30 kmpl', '24.3 bhp @ 6500 rpm', '32 Nm @ 4250 rpm', 'Air Cooling', 'Disc', 'Telescopic', '199 kg', '800 mm', '15 L', '130 kmph', '3 Years', 10, 'The Himalayan is purpose-built for adventure, with its rugged construction and terrain-conquering ability making it the ideal companion for all your explorations.', 'Granite Black'),

('Hero', 'XPulse 200', 'Adventure', 129000.00, '199.6cc', 'Petrol', 'Manual', '40 kmpl', '18.1 PS @ 8500 rpm', '16.15 Nm @ 6500 rpm', 'Oil Cooling', 'Disc', 'Telescopic', '157 kg', '825 mm', '13 L', '115 kmph', '5 Years', 12, 'The XPulse 200 is a dual-purpose motorcycle designed to tackle both city streets and off-road trails with ease. It's the perfect entry-level adventure bike for new riders.', 'Matte Green'),

-- Electric Bikes
('Ather', '450X', 'Electric', 140000.00, 'Electric', 'Electric', 'Automatic', '85 km/charge', '6 kW', '26 Nm', 'Liquid Cooling', 'Disc', 'Telescopic', '108 kg', '780 mm', 'N/A', '80 kmph', '3 Years', 7, 'The Ather 450X is an electric scooter that offers exceptional performance, smart features and a clean, zero-emission ride. Perfect for urban commuting.', 'Mint Green'),

('Revolt', 'RV400', 'Electric', 125000.00, 'Electric', 'Electric', 'Automatic', '150 km/charge', '3 kW', '170 Nm', 'Air Cooling', 'Disc', 'Telescopic', '108 kg', '814 mm', 'N/A', '85 kmph', '5 Years', 5, 'The RV400 is India's first AI-enabled electric motorcycle that offers impressive range, swappable batteries and connected features for a futuristic riding experience.', 'Cosmic Black'); 