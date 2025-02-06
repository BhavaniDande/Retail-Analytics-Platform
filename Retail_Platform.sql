Final Code:

-- Customer Table
CREATE TABLE Customer (
    Customer_ID SERIAL PRIMARY KEY,
    Customer_No VARCHAR(50),
    Gender VARCHAR(10),
    Age INTEGER,
    Frequency_Of_Purchases VARCHAR(50)
);

-- ShoppingMall Table
CREATE TABLE ShoppingMall (
    ShoppingMall_ID SERIAL PRIMARY KEY,
    Shopping_Mall VARCHAR(255),
    Store_Count INTEGER
);

--Associate Table
CREATE TABLE CustomerShoppingMall (
    Associate_ID SERIAL PRIMARY KEY,
    Customer_ID INTEGER REFERENCES Customer(Customer_ID),
    ShoppingMall_ID INTEGER REFERENCES ShoppingMall(ShoppingMall_ID)
);

-- Sales Table
CREATE TABLE Sales (
    Sales_ID SERIAL PRIMARY KEY,
    Customer_ID INTEGER REFERENCES Customer(Customer_ID),
    ShoppingMall_ID INTEGER REFERENCES ShoppingMall(ShoppingMall_ID),
    Invoice_No VARCHAR(200),
    Payment_Method VARCHAR(50),
    Quantity INTEGER,
    Category VARCHAR(255),
    Invoice_Date DATE,
    Price DECIMAL(10, 2),
    Item_Purchased VARCHAR(255),
    Color VARCHAR(50),
    Season VARCHAR(50),
    Previous_Purchases INTEGER
);



INSERT INTO Customer (Customer_No, Gender, Age, Frequency_Of_Purchases) VALUES 
('C241288', 'Female', 28, 'Weekly'), 
('C111565', 'Male', 21, 'Monthly'), 
('C266599', 'Male', 20, 'Bi-weekly'), 
('C988172', 'Female', 66, 'Weekly'), 
('C189076', 'Female', 53, 'Monthly'), 
('C657758', 'Female', 28, 'Weekly'), 
('C151197', 'Female', 49, 'Quarterly'), 
('C176086', 'Female', 32, 'Monthly'), 
('C159642', 'Male', 69, 'Weekly'), 
('C283361', 'Female', 60, 'Annually')
;

INSERT INTO ShoppingMall (Shopping_Mall, Store_Count) VALUES 
('Del Amo Fashion Center', 220), 
('The Grove', 140), 
('Westfield Valley Fair', 230), 
('Glendale Galleria', 190), 
('South Coast Plaza', 270)
;

INSERT INTO CustomerShoppingMall (Customer_ID, ShoppingMall_ID) VALUES 
(1, 1), 
(1, 3), 
(2, 1), 
(2, 4), 
(3, 2), 
(3, 5), 
(4, 1), 
(4, 2), 
(5, 3), 
(5, 4), 
(6, 2), 
(6, 5), 
(7, 1)
;



INSERT INTO Sales (Customer_ID, ShoppingMall_ID, Invoice_No, Payment_Method, Quantity, Category, Invoice_Date, Price, Item_Purchased, Color, Season, Previous_Purchases) VALUES
(1, 1, 'I138884', 'Debit Card', 5, 'Clothing', '2022-05-08', 37.00, 'Pants', 'Peach', 'Summer', 32),
(1, 3, 'I317333', 'Cash', 3, 'Clothing', '2021-12-12', 43.00, 'Shirt', 'White', 'Summer', 45),
(2, 1, 'I127801', 'Cash', 1, 'Outerwear', '2021-09-11', 83.00, 'Jacket', 'Pink', 'Fall', 15),
(2, 4, 'I173702', 'Venmo', 5, 'Clothing', '2021-05-16', 54.00, 'Shorts', 'Indigo', 'Winter', 45),
(3, 2, 'I337046', 'Credit Card', 4, 'Accessories', '2021-10-24', 32.00, 'Scarf', 'Gold', 'Spring', 21),
(3, 5, 'I227836', 'Debit Card', 5, 'Footwear', '2022-05-24', 96.00, 'Boots', 'Cyan', 'Fall', 17),
(4, 1, 'I121056', 'PayPal', 1, 'Accessories', '2022-03-13', 74.00, 'Sunglasses', 'Turquoise', 'Summer', 31),
(4, 2, 'I293112', 'Credit Card', 2, 'Clothing', '2021-01-13', 45.00, 'T-shirt', 'Magenta', 'Spring', 8),
(5, 3, 'I293455', 'Credit Card', 3, 'Clothing', '2021-04-11', 77.00, 'Jeans', 'Magenta', 'Winter', 21),
(5, 4, 'I326945', 'Venmo', 2, 'Accessories', '2021-08-22', 22.00, 'Handbag', 'Charcoal', 'Fall', 46),
(6, 2, 'I306368', 'PayPal', 2, 'Clothing', '2022-12-25', 76.00, 'Jeans', 'Peach', 'Winter', 47),
(6, 5, 'I139207', 'Venmo', 1, 'Clothing', '2022-10-28', 33.00, 'Sweater', 'Beige', 'Fall', 6),
(7, 1, 'I640508', 'PayPal', 4, 'Accessories', '2022-07-31', 78.00, 'Backpack', 'Cyan', 'Fall', 26);



--SELECT Statements
--Retrieve Customers and Their Most Frequently Purchased Category

SELECT 
    C.Customer_ID, 
    C.Customer_No, 
    S.Category, 
    COUNT(*) AS Number_Of_Purchases
FROM 
    Customer C
JOIN 
    Sales S ON C.Customer_ID = S.Customer_ID
GROUP BY 
    C.Customer_ID, C.Customer_No, S.Category
ORDER BY 
    C.Customer_ID, Number_Of_Purchases DESC;


--Retrieve Shopping Malls and the Total Sales Amount
SELECT 
    SM.ShoppingMall_ID, 
    SM.Shopping_Mall, 
    SUM(S.Price * S.Quantity) AS Total_Sales_Amount
FROM 
    ShoppingMall SM
JOIN 
    Sales S ON SM.ShoppingMall_ID = S.ShoppingMall_ID
GROUP BY 
    SM.ShoppingMall_ID, SM.Shopping_Mall
ORDER BY 
    Total_Sales_Amount DESC;

--Retrieve Customers Who Purchased in Multiple Shopping Malls

SELECT 
    C.Customer_ID, 
    C.Customer_No, 
    COUNT(DISTINCT S.ShoppingMall_ID) AS Number_Of_ShoppingMalls
FROM 
    Customer C
JOIN 
    Sales S ON C.Customer_ID = S.Customer_ID
GROUP BY 
    C.Customer_ID, C.Customer_No
HAVING 
    COUNT(DISTINCT S.ShoppingMall_ID) > 1
ORDER BY 
    Number_Of_ShoppingMalls DESC;


--Retrieve Sales Details by Payment Method
SELECT 
    S.Payment_Method, 
    SUM(S.Price * S.Quantity) AS Total_Sales_Amount, 
    COUNT(*) AS Number_Of_Transactions
FROM 
    Sales S
GROUP BY 
    S.Payment_Method
ORDER BY 
    Total_Sales_Amount DESC;


--Update statements
UPDATE Customer
SET Age = 32, Gender = 'Male'
WHERE Customer_ID = 1;

UPDATE ShoppingMall
SET Store_Count = 280, Shopping_Mall = 'The Great Mall'
WHERE ShoppingMall_ID = 1;

UPDATE Sales
SET Price = 50.00, Quantity = 4, Payment_Method = 'Credit Card'
WHERE Sales_ID = 1;

UPDATE CustomerShoppingMall
SET ShoppingMall_ID = 5
WHERE Customer_ID = 1 AND ShoppingMall_ID = 1;

--DELETE Operation

--Delete a Specific Customer and All Related Records



-- Delete related records from CustomerShoppingMall
BEGIN;
DELETE FROM CustomerShoppingMall
WHERE Customer_ID = 1;

-- Delete related records from Sales
DELETE FROM Sales
WHERE Customer_ID = 1;

-- Delete the customer record
DELETE FROM Customer
WHERE Customer_ID = 1;
COMMIT;

BEGIN;
-- Delete related records from CustomerShoppingMall
DELETE FROM CustomerShoppingMall
WHERE ShoppingMall_ID = 1;

-- Delete related records from Sales
DELETE FROM Sales
WHERE ShoppingMall_ID = 1;

-- Delete the shopping mall record
DELETE FROM ShoppingMall
WHERE ShoppingMall_ID = 1;
COMMIT;


-- Delete sales records older than a specific date
DELETE FROM Sales
WHERE Invoice_Date < '2022-01-01';



-- First delete from CustomerShoppingMall where the Customer_ID exists
DELETE FROM CustomerShoppingMall
WHERE Customer_ID IN (
    SELECT Customer_ID FROM CustomerShoppingMall
    WHERE ShoppingMall_ID IN (
        SELECT ShoppingMall_ID FROM ShoppingMall
        WHERE Store_Count <= 200
    )
    GROUP BY Customer_ID
    HAVING COUNT(*) = (SELECT COUNT(*) FROM CustomerShoppingMall cs
                       WHERE cs.Customer_ID = CustomerShoppingMall.Customer_ID)
);

-- Then delete from Customer table
DELETE FROM Customer
WHERE Customer_ID IN (
    SELECT Customer_ID FROM CustomerShoppingMall
    WHERE ShoppingMall_ID IN (
        SELECT ShoppingMall_ID FROM ShoppingMall
        WHERE Store_Count <= 200
    )
    GROUP BY Customer_ID
    HAVING COUNT(*) = (SELECT COUNT(*) FROM CustomerShoppingMall cs
                       WHERE cs.Customer_ID = CustomerShoppingMall.Customer_ID)
);




SELECT * from Customer;
SELECT * from ShoppingMall;
SELECT * from Sales;
SELECT * from CustomerShoppingMall;




DROP TABLE Sales;
DROP TABLE CustomerShoppingMall;
DROP TABLE ShoppingMall;
DROP TABLE Customer;





