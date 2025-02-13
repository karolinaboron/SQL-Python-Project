-- Menu Table - Stores details about menu items
CREATE OR REPLACE TABLE Menu (
    id INTEGER AUTO_INCREMENT PRIMARY KEY, # unique identifier for the menu item
    name TEXT NOT NULL, # name of the dish
    category TEXT NOT NULL, # category, e.g., "Main dish", "Beverage"
    price FLOAT NOT NULL, # price
    availability BOOLEAN NOT NULL # availability on a given day
);
 
-- Employees Table - Stores information about the staff
CREATE OR REPLACE TABLE Employees (
    id INTEGER AUTO_INCREMENT PRIMARY KEY, # unique identifier for the employee
    name TEXT NOT NULL, # full name
    role TEXT NOT NULL, # role in the restaurant, e.g., "Waiter", "Chef"
    hire_date DATE NOT NULL, # hire date
    type_of_employment TEXT NOT NULL # type of employment, e.g., employment contract, contract of mandate
);
 
-- Tables Table - Stores information about the tables in the restaurant
CREATE OR REPLACE TABLE Tables (
    id INTEGER AUTO_INCREMENT PRIMARY KEY, # unique table number
    seats INTEGER NOT NULL # number of seats at the table
);
 
 
-- Orders Table - Stores information about customer orders
CREATE OR REPLACE TABLE Orders (
    id INTEGER AUTO_INCREMENT PRIMARY KEY, # unique identifier for the order
    table_id INTEGER NOT NULL, # table number
    employee_id INTEGER NOT NULL, # waiter serving the order
    order_date DATETIME NOT NULL, # order date and time
    status TEXT NOT NULL, # order status, "Pending", "Ready", "Closed"
    FOREIGN KEY (table_id) REFERENCES Tables(id),
    FOREIGN KEY (employee_id) REFERENCES Employees(id)
);
 
-- Payments Table - Stores information about payments for orders
CREATE OR REPLACE TABLE Payments (
    id INTEGER AUTO_INCREMENT PRIMARY KEY, # unique payment identifier
    order_id INTEGER NOT NULL, # order number to which the payment is assigned
    payment_date DATETIME NOT NULL, # date and time of the payment
    amount FLOAT NOT NULL, # payment amount
    payment_method TEXT NOT NULL, # payment method: "cash", "card"
    FOREIGN KEY (order_id) REFERENCES Orders(id)
);
 
-- Reservations Table - Stores information about table reservations in the restaurant
CREATE OR REPLACE TABLE Reservations (
    id INTEGER AUTO_INCREMENT PRIMARY KEY, # unique reservation number
    table_id INTEGER NOT NULL, # table number that was reserved
    employee_id INTEGER NOT NULL, # waiter handling the reservation
    customer_name TEXT NOT NULL, # name of the person making the reservation
    reservation_date DATETIME NOT NULL, # reservation date and time
    status TEXT NOT NULL, # reservation status: "Confirmed", "Cancelled"
    FOREIGN KEY (table_id) REFERENCES Tables(id),
    FOREIGN KEY (employee_id) REFERENCES Employees(id)
);
 
 
 
-- Inserting sample menu items
INSERT INTO Menu (name, category, price, availability) VALUES
('ESPRESSO', 'Beverage', 7.50, TRUE),
('AMERICANO', 'Beverage', 9.50, TRUE),
('CAPPUCCINO', 'Beverage', 12.00, TRUE),
('LATTE MACCHIATO', 'Beverage', 14.00, TRUE),
('MOCHA', 'Beverage', 16.00, TRUE),
('LEMONADE', 'Beverage', 12.00, TRUE),
('BLACK TEA', 'Beverage', 6.00, TRUE),
('HONEY TEA', 'Beverage', 9.00, TRUE),
('COMPOST 200ml', 'Beverage', 5.00, TRUE),
('JUG OF COMPOST 1L', 'Beverage', 20.00, TRUE),
('SPARKLING/NON-SPARKLING WATER 330ML', 'Beverage', 5.00, TRUE),
('JUG OF MINERAL WATER 1L', 'Beverage', 20.00, TRUE),
('FRIES WITH KETCHUP', 'Snack', 11.90, TRUE),
('BAKED NACHOS WITH CHEESE', 'Snack', 11.90, TRUE),
('RED BORSCHT', 'Soup', 16.99, TRUE),
('WHITE BORSCHT', 'Soup', 18.99, TRUE),
('CHICKEN BROTH', 'Soup', 14.99, TRUE),
('CHICKEN SALAD', 'Main Dish', 29.99, TRUE),
('SALMON SALAD', 'Main Dish', 33.99, TRUE),
('VEGETARIAN TORTILLA', 'Main Dish', 22.50, TRUE),
('CHICKEN TORTILLA', 'Main Dish', 24.50, TRUE),
('DUMPLINGS WITH POTATOES AND CHEESE', 'Main Dish', 24.99, TRUE),
('DUMPLINGS WITH CHEESE', 'Main Dish', 24.99, TRUE),
('DUMPLING WITH SPINACH ', 'Main Dish', 33.99, TRUE),
('CHICKEN POUCH', 'Main Dish', 36.99, TRUE),
('BRAISED RIBS', 'Main Dish', 39.99, TRUE),
('VEGETABLE GNOCCHI', 'Main Dish', 29.99, TRUE),
('CHICKEN GNOCCHI', 'Main Dish', 32.99, TRUE),
('CHICKEN TAGIATELLE', 'Main Dish', 33.50, TRUE),
('SPINACH TAGIATELLE', 'Main Dish', 31.50, TRUE),
('SALMON TAGIATELLE', 'Main Dish', 39.50, TRUE),
('WARM APPLE PIE', 'Dessert', 19.99, TRUE),
('CHEESECAKE WITH RASPBERRIES AND MINT', 'Dessert', 19.99, TRUE),
('CHOCOLATE CAKE', 'Dessert', 17.99, TRUE),
('WAFFLE WITH POWDERED SUGAR', 'Dessert', 9.99, TRUE),
('WAFFLE WITH FRUITS', 'Dessert', 13.99, TRUE),
('WAFFLE WITH WHIPPED CREAM, FRUITS, AND SYRUP', 'Dessert', 17.99, TRUE);
 
 
INSERT INTO Employees (name, role, hire_date, type_of_employment) VALUES
('Anna Kowalska', 'Waiter', '2024-01-15', 'Contract of mandate'),
('Jan Nowak', 'Waiter', '2024-06-10', 'Contract of mandate'),
('Maria Wiśniewska', 'Waiter', '2023-03-01', 'Contract of mandate'),
('Piotr Zieliński', 'Waiter', '2023-09-20', 'Contract of mandate'),
('Ewa Malinowska', 'Waiter', '2021-06-15', 'Employment contract'),
('Paweł Górski', 'Waiter', '2024-09-01', 'Contract of mandate'),
('Monika Jankowska', 'Waiter', '2021-11-20', 'Employment contract'),
('Krzysztof Baran', 'Waiter', '2023-01-10', 'Contract of mandate'),
('Beata Sobczak', 'Waiter', '2022-03-05', 'Employment contract'),
('Katarzyna Wójcik', 'Accountant', '2022-07-05', 'Employment contract'),
('Tomasz Lewandowski', 'Manager', '2022-12-01', 'Employment contract'),
('Aleksandra Kaczmarek', 'Cleaner', '2023-02-10', 'Contract of mandate'),
('Michał Dąbrowski', 'Chef', '2022-11-15', 'Employment contract'),
('Joanna Kamińska', 'Chef', '2021-08-01', 'Employment contract'),
('Adam Majewski', 'Chef', '2020-05-12', 'Employment contract');

 
 
INSERT INTO Tables (seats) VALUES
(2),  -- Table 1: 2 seats
(4),  -- Table 2: 4 seats
(6),  -- Table 3: 6 seats
(4),  -- Table 4: 4 seats
(2),  -- Table 5: 2 seats
(8),  -- Table 6: 8 seats
(4),  -- Table 7: 4 seats
(2),  -- Table 8: 2 seats
(6),  -- Table 9: 6 seats
(4),  -- Table 10: 4 seats
(10), -- Table 11: 10 seats
(2),  -- Table 12: 2 seats
(4),  -- Table 13: 4 seats
(6),  -- Table 14: 6 seats
(8);  -- Table 15: 8 seats

 
 
INSERT INTO Orders (table_id, employee_id, order_date, status) VALUES
(1, 1, '2025-01-10 12:30:00', 'Pending'),
(5, 1, '2025-01-10 12:35:00', 'Ready'),
(11, 5, '2025-01-10 12:40:00', 'Closed'),
(4, 8, '2025-01-10 13:00:00', 'Pending'),
(8, 8, '2025-01-10 13:10:00', 'Ready'),
(3, 2, '2025-01-10 13:20:00', 'Closed');
 
 
INSERT INTO Payments (order_id, payment_date, amount, payment_method) VALUES
(3, '2025-01-10 12:50:00', 450.50, 'Card'),
(1, '2025-01-10 13:25:00', 120.57, 'Cash');
 
 
SELECT * FROM menu;
 
SELECT * FROM employees;
 
SELECT * FROM tables;
 
SELECT * FROM orders;
 
SELECT * FROM payments;
 
SELECT * FROM reservations;
 
 
-- EmployeeRatings Table - Stores employee ratings
CREATE TABLE EmployeeRatings (
    id INT AUTO_INCREMENT PRIMARY KEY,             
    employee_id INT NOT NULL,                      
    rating_date DATETIME NOT NULL DEFAULT NOW(),   
    rating_text VARCHAR(255),                     
    rating_score TINYINT NOT NULL,                
    FOREIGN KEY (employee_id) REFERENCES Employees(id)
);
 
 
INSERT INTO EmployeeRatings (employee_id, rating_text, rating_score)
VALUES
    (1, 'Great service, very polite!', 10),
    (2, 'The service was average, but quick.', 7),
    (3, 'The employee showed a lack of professionalism.', 4),
    (1, 'Always punctual and helpful.', 9),
    (2, 'Could engage more in their work.', 6);

SELECT * FROM EmployeeRatings;

INSERT INTO EmployeeRatings (employee_id, rating_text, rating_score)
VALUES
    (1, 'Great service, very polite!', 10),
    (1, 'Always punctual and helpful.', 9),
    (1, 'Excellent menu knowledge and fast service.', 10),
    (1, 'Smiling, helpful, and professional.', 9),
    (1, 'An employee with exceptional dedication.', 10),
    (2, 'The service was average, but quick.', 7),
    (2, 'Could engage more in their work.', 6),
    (2, 'The employee was helpful, but sometimes too slow.', 7),
    (2, 'Polite, but lacks initiative.', 6),
    (2, 'Does well, but could be more precise.', 7),
    (3, 'The employee showed a lack of professionalism.', 4),
    (3, 'Frequently absent from table service.', 3),
    (3, 'Needs more training to improve their skills.', 5),
    (3, 'Doesn’t show initiative in problem-solving.', 4),
    (3, 'The service was careless and not very polite.', 3);

 
   
   SELECT * FROM EmployeeRatings;
  
  
-- EmployeeAverageRatings Table - Stores the average rating for each employee
CREATE OR REPLACE TABLE EmployeeAverageRatings (
    employee_id INT PRIMARY KEY,
    average_rating DECIMAL(4, 2) NOT NULL,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES Employees(id)
);
 
 
-- Last10RatingsAverage View - Calculates the average rating for the last 10 ratings of each employee
CREATE OR REPLACE VIEW Last10RatingsAverage AS
SELECT
    employee_id,
    ROUND(AVG(rating_score), 2) AS average_rating
FROM (
    SELECT
        employee_id,
        rating_score,
        ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY rating_date DESC) AS row_num
    FROM EmployeeRatings
) AS subquery
WHERE row_num <= 10
GROUP BY employee_id;
 
 
-- UpdateAverageRatings Procedure - Updates the EmployeeAverageRatings table based on data from the Last10RatingsAverage view
CREATE OR REPLACE PROCEDURE UpdateAverageRatings()
BEGIN
    DELETE FROM EmployeeAverageRatings;
    INSERT INTO EmployeeAverageRatings (employee_id, average_rating)
    SELECT
        employee_id,
        average_rating
    FROM
        Last10RatingsAverage;
END
 
 
-- UpdateRatingsAfterInsert Trigger - Automatically updates the average ratings in EmployeeAverageRatings after a new rating is added to EmployeeRatings
CREATE OR REPLACE TRIGGER UpdateRatingsAfterInsert
AFTER INSERT ON EmployeeRatings
FOR EACH ROW
BEGIN
    CALL UpdateAverageRatings();
END
 
CALL UpdateAverageRatings();
 
SELECT * FROM EmployeeAverageRatings;
 
-- Inserting new ratings
INSERT INTO EmployeeRatings (employee_id, rating_text, rating_score)
VALUES (1, 'Very professional service, helpful employee.', 10);

CALL UpdateAverageRatings();

SELECT * FROM EmployeeAverageRatings;

INSERT INTO EmployeeRatings (employee_id, rating_text, rating_score)
VALUES (3, 'Very professional service.', 10);

INSERT INTO EmployeeRatings (employee_id, rating_text, rating_score)
VALUES (2, 'Average service level.', 5);
 
 
-- EmployeeRatingHistory Table - Stores the history of changes to the average ratings for employees
CREATE OR REPLACE TABLE EmployeeRatingHistory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    change_date DATETIME NOT NULL DEFAULT NOW(),
    average_rating DECIMAL(4, 2) NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES Employees(id)
);
 
 
-- Update the UpdateAverageRatings procedure to save data to the rating history table (EmployeeRatingHistory)
CREATE OR REPLACE PROCEDURE UpdateAverageRatings()
BEGIN
    DELETE FROM EmployeeAverageRatings;
    INSERT INTO EmployeeAverageRatings (employee_id, average_rating)
    SELECT
        employee_id,
        average_rating
    FROM
        Last10RatingsAverage;      
-- Extension of the UpdateAverageRatings procedure - Adds a record of the rating history change to the EmployeeRatingHistory table
    INSERT INTO EmployeeRatingHistory (employee_id, change_date, average_rating)
    SELECT
        employee_id,
        NOW(),
        average_rating
    FROM Last10RatingsAverage;
END;
 
 
-- Update the UpdateRatingsAfterInsert trigger to track rating history
CREATE OR REPLACE TRIGGER UpdateRatingsAfterInsert
AFTER INSERT ON EmployeeRatings
FOR EACH ROW
BEGIN
    CALL UpdateAverageRatings();
END;
 
 
INSERT INTO EmployeeRatings (employee_id, rating_text, rating_score)
VALUES
    (1, 'The employee is always smiling and engaged.', 9),
    (1, 'Professional service, great communication.', 10);

INSERT INTO EmployeeRatings (employee_id, rating_text, rating_score)
VALUES
    (2, 'The service was fast, but lacked engagement.', 7),
    (2, 'Helpful and kind, but could be more precise.', 8);

INSERT INTO EmployeeRatings (employee_id, rating_text, rating_score)
VALUES
    (3, 'Significant improvement, the service was professional.', 9),
    (3, 'Great progress in communication with clients.', 8);

   
   SELECT * FROM EmployeeAverageRatings;
 
  
  SELECT * FROM EmployeeRatingHistory ORDER BY employee_id, change_date;
 
 
 
INSERT INTO EmployeeRatings (employee_id, rating_text, rating_score)
VALUES
    (4, 'Definitely improved customer contact, though there is still room for improvement.', 7),
    (5, 'Very professional service, well-organized.', 10),
    (6, 'Needs more experience, but nice service.', 6),
    (7, 'Very engaged in their work, though sometimes a bit nervous.', 8),
    (8, 'Good customer contact, but sometimes lacks confidence.', 7),
    (9, 'Definitely one of the best approaches to customer service.', 10),
    (13, 'Delicious dishes.', 9),
    (14, 'Creative chef, but sometimes too chaotic.', 7),
    (15, 'Excellent quality of dishes, but sometimes too slow in responding to orders.', 8);

   
   
INSERT INTO employeeratings (employee_id,rating_score)
VALUES
    (4,5),
    (4,6),
    (5,9),
    (6,7),
    (6,6.5),
    (7,8),
    (8,8),
    (5, 9),
    (5, 7),
    (6, 7),
    (6, 6),
    (7, 8),
    (7, 7),
    (8, 6),
    (8, 7),
    (9, 10),
    (13,9),
    (14,8),
    (15,9);
   
 
INSERT INTO Menu (name, category, price, availability) 
VALUES
('ICE CREAM DESSERT', 'Dessert', 17.50, TRUE);

-- Table MenuAvailabilityHistory - Stores the history of availability changes for menu items
CREATE OR REPLACE TABLE MenuAvailabilityHistory (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,              
    menu_id INTEGER NOT NULL,                           
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,                            
    FOREIGN KEY (menu_id) REFERENCES Menu(id) ON DELETE CASCADE         
);

 
 
SELECT * FROM MenuAvailabilityHistory;
 
-- Trigger MenuAvailabilityChange - Automatically records availability changes in the history table
CREATE OR REPLACE TRIGGER MenuAvailabilityChange
AFTER UPDATE ON Menu
FOR EACH ROW
BEGIN
    IF OLD.availability = TRUE AND NEW.availability = FALSE THEN
        INSERT INTO MenuAvailabilityHistory (menu_id)
        VALUES (OLD.id);
    END IF;
 
    IF OLD.availability = FALSE AND NEW.availability = TRUE THEN
        DELETE FROM MenuAvailabilityHistory
        WHERE menu_id = OLD.id;
    END IF;
END;
 
 
SELECT * FROM Menu;
 
 
-- Procedure RemoveOldUnavailableItems - Removes items from the menu that have been unavailable for more than 3 months
CREATE OR REPLACE PROCEDURE RemoveOldUnavailableItems()
BEGIN
    DELETE FROM Menu
    WHERE id IN (
        SELECT menu_id
        FROM MenuAvailabilityHistory
        GROUP BY menu_id
        HAVING MAX(change_date) < NOW() - INTERVAL 3 MONTH
    );
END;
 
 
CALL RemoveOldUnavailableItems();
 
 
-- Event AutoRemoveOldItems - Automatically calls the RemoveOldUnavailableItems procedure once a day
CREATE EVENT IF NOT EXISTS AutoRemoveOldItems
ON SCHEDULE EVERY 1 DAY 
DO
	CALL RemoveOldUnavailableItems();
 
 
SET GLOBAL event_scheduler = ON;

INSERT INTO MenuAvailabilityHistory (menu_id, change_date)
VALUES
    (38, '2023-09-01');
 
SELECT * FROM MenuAvailabilityHistory;
 
SELECT * FROM Menu;

SHOW EVENTS;




 