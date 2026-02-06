--====================== INSERT INTO office=======================
INSERT INTO office (name, city, street) VALUES
('Central Cairo Office', 'Cairo', '123 Tahrir St'),
('Maadi Branch', 'Cairo', '45 Road 9'),
('Heliopolis Office', 'Cairo', '67 Abbas St'),
('Nasr City Branch', 'Cairo', '89 El-Nasr St'),
('Giza Central Office', 'Giza', '12 6th October St'),
('Dokki Branch', 'Giza', '34 El-Galaa St'),
('Mohandessin Office', 'Giza', '56 El-Mohandessin St'),
('Alexandria Port Office', 'Alexandria', '78 Port Said St'),
('Sidi Gaber Branch', 'Alexandria', '90 El-Gaish St'),
('Smouha Office', 'Alexandria', '21 Smouha Blvd'),
('Mansoura Central Office', 'Mansoura', '15 El-Gomhoria St'),
('Tanta Branch', 'Tanta', '33 El-Shaheed St'),
('Ismailia Office', 'Ismailia', '44 Canal St'),
('Port Said Branch', 'Port Said', '55 El-Manakh St'),
('Suez Office', 'Suez', '66 El-Salam St'),
('Fayoum Branch', 'Fayoum', '77 El-Masry St'),
('Aswan Office', 'Aswan', '88 Nile St'),
('Luxor Branch', 'Luxor', '99 Karnak St'),
('Sharm El-Sheikh Office', 'Sharm El-Sheikh', '10 Naama Bay Rd'),
('Hurghada Branch', 'Hurghada', '20 El-Nasr St')

--====================== INSERT INTO office_phones =======================
INSERT INTO office_phones (office_id, phone_number) VALUES
(1, '022-1234567'),
(1, '022-7654321'),
(2, '022-2345678'),
(3, '022-3456789'),
(4, '022-4567890'),
(5, '020-12345678'),
(6, '020-23456789'),
(7, '020-34567890'),
(8, '03-1234567'),
(8, '03-7654321'),
(9, '03-2345678'),
(10, '03-3456789'),
(11, '050-1234567'),
(12, '040-2345678'),
(13, '064-3456789'),
(14, '066-4567890'),
(15, '062-1234567'),
(16, '062-2345678'),
(17, '097-3456789'),
(18, '095-4567890'),
(19, '069-1234567'),
(20, '065-2345678')

--====================== INSERT INTO employee=======================
INSERT INTO employee (name, job_title, hire_date, salary, office_id) VALUES
('Ahmed Ali', 'Manager', '2018-03-15', 12000.00, 1),
('Sara Mohamed', 'Receptionist', '2019-06-01', 5000.00, 1),
('Hany Ibrahim', 'Accountant', '2020-01-20', 7000.00, 2),
('Mona Khaled', 'Sales', '2021-07-10', 6500.00, 2),
('Omar Adel', 'Technician', '2017-09-05', 8000.00, 3),
('Laila Samir', 'HR', '2019-11-12', 6000.00, 3),
('Tamer Hassan', 'Manager', '2018-05-18', 13000.00, 4),
('Dina Youssef', 'Receptionist', '2020-02-01', 5200.00, 4),
('Mohamed Fathy', 'Sales', '2021-03-23', 6800.00, 5),
('Rania Magdy', 'Accountant', '2019-08-15', 7200.00, 5),
('Ali Mostafa', 'Technician', '2017-12-10', 7500.00, 6),
('Heba Samir', 'HR', '2020-04-05', 6100.00, 6),
('Khaled Fahmy', 'Manager', '2018-06-20', 12500.00, 7),
('Noha Tarek', 'Receptionist', '2019-09-12', 5300.00, 7),
('Mahmoud Hossam', 'Sales', '2021-05-18', 6900.00, 8),
('Mariam Ahmed', 'Accountant', '2019-07-25', 7100.00, 8),
('Youssef Nabil', 'Technician', '2017-10-30', 7800.00, 9),
('Salma Hany', 'HR', '2020-03-15', 6200.00, 9),
('Hossam Adel', 'Manager', '2018-08-10', 13500.00, 10),
('Rana Mostafa', 'Receptionist', '2021-01-05', 5400.00, 10),
('Karim Mohamed', 'Sales', '2019-11-20', 7000.00, 11),
('Dalia Mahmoud', 'Accountant', '2020-06-15', 7300.00, 11),
('Ibrahim Tamer', 'Technician', '2017-09-25', 7600.00, 12),
('Nada Hossam', 'HR', '2019-02-10', 6200.00, 12),
('Mohamed Saad', 'Manager', '2018-04-18', 12800.00, 13),
('Aya Fathy', 'Receptionist', '2021-03-12', 5500.00, 13),
('Omar Khaled', 'Sales', '2019-12-20', 7100.00, 14),
('Lamiaa Mostafa', 'Accountant', '2020-08-05', 7400.00, 14),
('Tamer Nabil', 'Technician', '2017-07-15', 7700.00, 15),
('Mona Adel', 'HR', '2019-05-18', 6300.00, 15),
('Hisham Fathy', 'Manager', '2018-09-10', 13200.00, 16),
('Salma Mohamed', 'Receptionist', '2021-04-01', 5600.00, 16),
('Adel Ahmed', 'Sales', '2019-06-25', 7200.00, 17),
('Rania Hossam', 'Accountant', '2020-02-18', 7500.00, 17),
('Omar Samir', 'Technician', '2017-11-05', 7800.00, 18),
('Mona Tamer', 'HR', '2019-08-10', 6400.00, 18),
('Mohamed Khaled', 'Manager', '2018-12-15', 13600.00, 19),
('Aya Samir', 'Receptionist', '2021-06-20', 5700.00, 19),
('Karim Hany', 'Sales', '2019-09-12', 7300.00, 20),
('Dalia Adel', 'Accountant', '2020-03-28', 7600.00, 20)

--====================== INSERT INTO emp_phones=======================
INSERT INTO emp_phones (emp_id, phone_number) VALUES
(1, '010-12345678'),
(2, '010-23456789'),
(3, '010-34567890'),
(4, '010-45678901'),
(5, '010-56789012'),
(6, '010-67890123'),
(7, '010-78901234'),
(8, '010-89012345'),
(9, '010-90123456'),
(10, '010-01234567'),
(11, '011-12345678'),
(12, '011-23456789'),
(13, '011-34567890'),
(14, '011-45678901'),
(15, '011-56789012'),
(16, '011-67890123'),
(17, '011-78901234'),
(18, '011-89012345'),
(19, '011-90123456'),
(20, '011-01234567'),
(21, '012-12345678'),
(22, '012-23456789'),
(23, '012-34567890'),
(24, '012-45678901'),
(25, '012-56789012'),
(26, '012-67890123'),
(27, '012-78901234'),
(28, '012-89012345'),
(29, '012-90123456'),
(30, '012-01234567'),
(31, '013-12345678'),
(32, '013-23456789'),
(33, '013-34567890'),
(34, '013-45678901'),
(35, '013-56789012'),
(36, '013-67890123'),
(37, '013-78901234'),
(38, '013-89012345'),
(39, '013-90123456'),
(40, '013-01234567')

--====================== INSERT INTO delivery=======================

INSERT INTO delivery (license_number, emp_id) VALUES
('CA12345', 1),
('CA23456', 2),
('CA34567', 3),
('CA45678', 4),
('CA56789', 5),
('CA67890', 6),
('CA78901', 7),
('CA89012', 8),
('CA90123', 9),
('CA01234', 10),
('CB12345', 11),
('CB23456', 12),
('CB34567', 13),
('CB45678', 14),
('CB56789', 15),
('CB67890', 16),
('CB78901', 17),
('CB89012', 18),
('CB90123', 19),
('CB01234', 20),
('CC12345', 21),
('CC23456', 22),
('CC34567', 23),
('CC45678', 24),
('CC56789', 25),
('CC67890', 26),
('CC78901', 27),
('CC89012', 28),
('CC90123', 29),
('CC01234', 30),
('CD12345', 31),
('CD23456', 32),
('CD34567', 33),
('CD45678', 34),
('CD56789', 35),
('CD67890', 36),
('CD78901', 37),
('CD89012', 38),
('CD90123', 39),
('CD01234', 40);
--====================== INSERT INTO customer=======================
INSERT INTO customer (name, street, city) VALUES
('Ali Hassan', '12 Tahrir St', 'Cairo'),
('Sara Mahmoud', '45 Maadi Rd', 'Cairo'),
('Mohamed Adel', '67 Heliopolis St', 'Cairo'),
('Mona Khaled', '89 Nasr City St', 'Cairo'),
('Omar Fathy', '23 Dokki St', 'Giza'),
('Dina Samir', '34 Mohandessin Rd', 'Giza'),
('Ahmed Nabil', '56 El-Galaa St', 'Giza'),
('Rania Hossam', '78 Port Said St', 'Alexandria'),
('Karim Youssef', '90 Smouha Blvd', 'Alexandria'),
('Aya Mostafa', '21 El-Gaish St', 'Alexandria'),
('Tamer Ibrahim', '15 El-Gomhoria St', 'Mansoura'),
('Laila Fathy', '33 El-Shaheed St', 'Tanta'),
('Hany Salah', '44 Canal St', 'Ismailia'),
('Salma Adel', '55 El-Manakh St', 'Port Said'),
('Mohamed Gamal', '66 El-Salam St', 'Suez'),
('Dalia Samir', '77 El-Masry St', 'Fayoum'),
('Omar Khaled', '88 Nile St', 'Aswan'),
('Mona Ahmed', '99 Karnak St', 'Luxor'),
('Ahmed Fathy', '10 Naama Bay Rd', 'Sharm El-Sheikh'),
('Sara Tamer', '20 El-Nasr St', 'Hurghada'),
('Youssef Hany', '25 Tahrir St', 'Cairo'),
('Mariam Adel', '35 Maadi Rd', 'Cairo'),
('Hossam Khaled', '47 Heliopolis St', 'Cairo'),
('Rana Fathy', '59 Nasr City St', 'Cairo'),
('Mahmoud Samir', '26 Dokki St', 'Giza'),
('Dina Nabil', '38 Mohandessin Rd', 'Giza'),
('Tamer Ahmed', '50 El-Galaa St', 'Giza'),
('Noha Hossam', '72 Port Said St', 'Alexandria'),
('Karim Samir', '84 Smouha Blvd', 'Alexandria'),
('Mona Youssef', '96 El-Gaish St', 'Alexandria'),
('Heba Khaled', '16 El-Gomhoria St', 'Mansoura'),
('Omar Salah', '28 El-Shaheed St', 'Tanta'),
('Salma Fathy', '40 Canal St', 'Ismailia'),
('Mohamed Adel', '52 El-Manakh St', 'Port Said'),
('Aya Samir', '64 El-Salam St', 'Suez'),
('Karim Nabil', '76 El-Masry St', 'Fayoum'),
('Dalia Hany', '88 Nile St', 'Aswan'),
('Tamer Khaled', '90 Karnak St', 'Luxor'),
('Rana Ahmed', '12 Naama Bay Rd', 'Sharm El-Sheikh'),
('Hossam Fathy', '24 El-Nasr St', 'Hurghada');
--====================== INSERT INTO cust_phones=======================
INSERT INTO cust_phones (cust_id, phone_number) VALUES
(1, '010-20110001'),
(2, '010-20110002'),
(3, '010-20110003'),
(4, '010-20110004'),
(5, '010-20110005'),
(6, '010-20110006'),
(7, '010-20110007'),
(8, '010-20110008'),
(9, '010-20110009'),
(10, '010-20110010'),
(11, '011-20110111'),
(12, '011-20110112'),
(13, '011-20110113'),
(14, '011-20110114'),
(15, '011-20110115'),
(16, '011-20110116'),
(17, '011-20110117'),
(18, '011-20110118'),
(19, '011-20110119'),
(20, '011-20110120'),
(21, '012-20110201'),
(22, '012-20110202'),
(23, '012-20110203'),
(24, '012-20110204'),
(25, '012-20110205'),
(26, '012-20110206'),
(27, '012-20110207'),
(28, '012-20110208'),
(29, '012-20110209'),
(30, '012-20110210'),
(31, '013-20110301'),
(32, '013-20110302'),
(33, '013-20110303'),
(34, '013-20110304'),
(35, '013-20110305'),
(36, '013-20110306'),
(37, '013-20110307'),
(38, '013-20110308'),
(39, '013-20110309'),
(40, '013-20110310');

--=========================== INSERT INTO office ============================
INSERT INTO office (name, city, street)
VALUES
('Main Office', 'Cairo', 'Tahrir St'),
('Branch Alex', 'Alexandria', 'Corniche Rd'),
('Branch Giza', 'Giza', 'Pyramids St');

--=========================== INSERT INTO office_phones ============================
INSERT INTO office_phones (office_id, phone_number)
VALUES
(1, '0223456789'),
(1, '01011112222'),
(2, '0345678901'),
(3, '0233344455');

--=========================== INSERT INTO employee ============================
INSERT INTO employee (name, job_title, hire_date, salary, office_id)
VALUES
('Ahmed Ali', 'Manager', '2020-01-10', 12000, 1),
('Mohamed Hassan', 'Accountant', '2021-03-15', 8000, 1),
('Sara Mahmoud', 'HR', '2022-05-20', 7500, 2),
('Omar Fathy', 'Driver', '2019-07-01', 6000, 2),
('Youssef Adel', 'Driver', '2020-09-12', 6200, 3),
('Mona Ashraf', 'Driver', '2021-11-30', 6100, 1);

--=========================== INSERT INTO emp_phones ============================
INSERT INTO emp_phones (emp_id, phone_number)
VALUES
(1, '01022223333'),
(2, '01144445555'),
(3, '01266667777'),
(4, '01088889999'),
(5, '01199990000'),
(6, '01511112222');

--=========================== INSERT INTO delivery ============================
INSERT INTO delivery (license_number, emp_id)
VALUES
('LIC1001', 4),
('LIC1002', 5),
('LIC1003', 6);

--=========================== INSERT INTO customer ============================
INSERT INTO customer (name, street, city)
VALUES
('Karim Nabil', 'Nasr City', 'Cairo'),
('Hala Samir', 'Stanley', 'Alexandria'),
('Tamer Adel', 'Dokki', 'Giza'),
('Nour Hassan', 'Talkha', 'Mansoura');

--=========================== INSERT INTO cust_phones ============================
INSERT INTO cust_phones (cust_id, phone_number)
VALUES
(1, '01012345678'),
(1, '01187654321'),
(2, '01255556666'),
(3, '01099998888'),
(4, '01544443333');

--=========================== INSERT INTO Vehicle ============================
INSERT INTO Vehicle (plate_number, model, vehicle_type, capacity)
VALUES
('CAR001', 'Toyota Corolla', 'car', 450),
('CAR002', 'Hyundai Elantra', 'car', 470),
('TRK001', 'Isuzu NQR', 'truck', 7000),
('BUS001', 'Toyota Coaster', 'bus', 8000),
('MOT001', 'Honda CG', 'motorcycle', 120);

--=========================== INSERT INTO Orders ============================
INSERT INTO Orders
(order_number, order_date, total_cost, cust_id, driver_id, office_id,
 pay_date, pay_method, amount, order_status)
VALUES
(1001, '2024-07-01', 300, 1, 1, 1, '2024-07-01', 'cash', 300, 'paid'),
(1002, '2024-07-02', 450, 2, 2, 2, '2024-07-02', 'card', 450, 'delivered'),
(1003, '2024-07-03', 200, 3, 3, 3, NULL, 'cash', 200, 'pending'),
(1004, '2024-07-04', 600, 4, 1, 1, '2024-07-04', 'online', 600, 'paid');


--=========================== INSERT INTO deliveryItem ============================
INSERT INTO deliveryItem
(item_id, description, item_weight, delivery_fee, order_number)
VALUES
(1, 'Mobile Phones', 5.5, 40, 1001),
(2, 'Laptop', 2.3, 30, 1001),
(1, 'Office Chairs', 25, 120, 1002),
(1, 'Documents', 1, 10, 1003),
(1, 'TV Screen', 18, 150, 1004);

--=========================== INSERT INTO VehicleAssignment ============================
INSERT INTO VehicleAssignment
(driver_id, plate_number, startDate, endDate)
VALUES
(1, 'CAR001', '2024-01-01', '2024-06-30'),
(2, 'TRK001', '2024-02-01', NULL),
(3, 'BUS001', '2024-03-01', '2024-09-30'),
(1, 'MOT001', '2024-07-01', NULL);



