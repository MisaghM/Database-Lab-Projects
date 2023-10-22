-- Part 1.1
CREATE DATABASE REB;

-- Part 1.2
CREATE SCHEMA general;

-- Part 1.3
CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    customer_details TEXT
);
CREATE TABLE Staff (
    staff_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    role VARCHAR(50),
    other_details TEXT
);
CREATE TABLE Menus (
    menu_id SERIAL PRIMARY KEY,
    menu_name VARCHAR(50),
    other_details TEXT
);
CREATE TABLE Meals (
    meal_id SERIAL PRIMARY KEY,
    date_of_meal DATE,
    other_details TEXT,
    eg_entree VARCHAR(50)
);
CREATE TABLE Menu_Meals (
    menu_id INT REFERENCES Menus(menu_id),
    meal_id INT REFERENCES Meals(meal_id),
    PRIMARY KEY (menu_id, meal_id)
);
CREATE TABLE Bookings (
    booking_id SERIAL PRIMARY KEY,
    booking_taken_by_staff_id INT REFERENCES Staff(staff_id),
    customer_id INT REFERENCES Customers(customer_id),
    date_booked DATE,
    date_of_event DATE,
    other_details TEXT
);
CREATE TABLE Menus_Booked (
    menu_id INT REFERENCES Menus(menu_id),
    booking_id INT REFERENCES Bookings(booking_id),
    PRIMARY KEY (menu_id, booking_id)
);
CREATE TABLE Menu_Changes (
    change_id SERIAL PRIMARY KEY,
    menu_id INT,
    booking_id INT,
    FOREIGN KEY (menu_id, booking_id) REFERENCES Menus_Booked(menu_id, booking_id),
    change_details TEXT
);
CREATE TABLE Booking_Notes (
    booking_notes_id SERIAL PRIMARY KEY,
    booking_id INT REFERENCES Bookings(booking_id),
    date_of_notes DATE,
    details_of_notes TEXT
);

-- Part 2.1.1
CREATE DATABASE REB1;
CREATE SCHEMA general;

-- Part 2.1.2
CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    customer_details TEXT
);
CREATE TABLE Staff (
    staff_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    role VARCHAR(50),
    other_details TEXT
);
CREATE INDEX staff_name ON Staff (first_name);
CREATE TABLE Bookings (
    booking_id SERIAL PRIMARY KEY,
    booking_taken_by_staff_id INT,
    customer_id INT,
    date_booked DATE,
    date_of_event DATE,
    other_details TEXT
);

-- Part 2.1.3
ALTER TABLE Bookings
    ADD CONSTRAINT fk_staff_id
    FOREIGN KEY (booking_taken_by_staff_id)
    REFERENCES Staff(staff_id);

ALTER TABLE Bookings
    ADD CONSTRAINT fk_customer_id
    FOREIGN KEY (customer_id)
    REFERENCES Customers(customer_id);

-- Part 2.1.4
ALTER TABLE Bookings
    DROP COLUMN other_details,
    ADD COLUMN "desc" TEXT;

-- Part 2.2.1
INSERT INTO Customers (customer_details)
    VALUES ('Patrick');
INSERT INTO Staff (first_name, last_name, role, other_details)
    VALUES ('SpongeBob', 'SquarePants', 'Chef', 'Lives in a pineapple under the sea');
INSERT INTO Bookings (booking_taken_by_staff_id, customer_id, date_booked, date_of_event, "desc")
    VALUES (1, 1, '2019-01-01', '2019-01-02', 'Other details');

-- Part 2.2.2
UPDATE Bookings
    SET "desc" = 'The Reunion'
    WHERE booking_id = 1;

-- Part 2.2.3
DELETE FROM Bookings
    WHERE booking_taken_by_staff_id = 1;
DELETE FROM Staff
    WHERE staff_id = 1;

ALTER TABLE Bookings
    DROP CONSTRAINT fk_staff_id,
    DROP CONSTRAINT fk_customer_id;
DROP TABLE Staff;
DROP DATABASE REB1;

-- Part 2.3

DROP SCHEMA public CASCADE;
DROP SCHEMA general CASCADE;
-- Run dump.sql

-- Part 2.3.1
SELECT date_booked
    FROM Bookings INNER JOIN Customers
    ON Bookings.customer_id = Customers.customer_id
    WHERE customer_details = 'shahab';

-- Part 2.3.2
SELECT first_name
    FROM Staff
        INNER JOIN Bookings B on Staff.staff_id = B.booking_taken_by_staff_id
        INNER JOIN Customers C on B.customer_id = C.customer_id
    WHERE customer_details = 'fateme';

-- Part 2.3.3
SELECT customer_details
    FROM Customers
        INNER JOIN Bookings B on Customers.customer_id = B.customer_id
    GROUP BY customer_details
    ORDER BY COUNT(*) DESC
    LIMIT 1;

-- Part 2.3.4
SELECT menu_name
    FROM Menus
        LEFT JOIN Menus_Booked MB on Menus.menu_id = MB.menu_id
    WHERE MB.menu_id IS NULL;

-- Part 2.3.5
SELECT booking_id, details_of_notes
    FROM Booking_Notes;

-- Part 2.3.6
SELECT menu_name
    FROM Menus
        INNER JOIN Menus_Booked MB on Menus.menu_id = MB.menu_id
        INNER JOIN Bookings B on MB.booking_id = B.booking_id
        INNER JOIN Customers C on B.customer_id = C.customer_id
    WHERE C.customer_id = 3;
