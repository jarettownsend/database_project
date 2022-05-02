-- Insert Values into branch --

INSERT INTO branch (branch_name, branch_city, assets)
VALUES ('Brooklyn Bank','Brooklyn','2506789.00');

INSERT INTO branch (branch_name, branch_city, assets)
VALUES ('First Bank of Brooklyn','Brooklyn','4738291.00');

INSERT INTO branch (branch_name, branch_city, assets)
VALUES ('Brooklyn Bridge Bank','Brooklyn','3216549.00');

INSERT INTO branch (branch_name, branch_city, assets)
VALUES ('Bronx Federal Credit Union','Bronx','1425365.00');

INSERT INTO branch (branch_name, branch_city, assets)
VALUES ('Big Bronx Bank','Bronx','5632897.00');

INSERT INTO branch (branch_name, branch_city, assets)
VALUES ('Upper East Federal Credit Union','Manhatten','9385274.00');

INSERT INTO branch (branch_name, branch_city, assets)
VALUES ('Yonkahs Bankahs','Yonkers','2356967.00');

-- Insert Values into customer --

INSERT INTO customer (cust_ID, customer_name, customer_street, customer_city)
VALUES ('12345', 'Billy Boi', '123 Easy Street', 'Bronx');

INSERT INTO customer (cust_ID, customer_name, customer_street, customer_city)
VALUES ('54321', 'Teddy Tiger', '56 East Baltimore Road', 'Brooklyn');

INSERT INTO customer (cust_ID, customer_name, customer_street, customer_city)
VALUES ('98524', 'Betty Bench', '123 Easy Street', 'Bronx');

INSERT INTO customer (cust_ID, customer_name, customer_street, customer_city)
VALUES ('24357', 'Walter Halter', '67 Stupid Street', 'Brooklyn');

INSERT INTO customer (cust_ID, customer_name, customer_street, customer_city)
VALUES ('73194', 'Wendy Winks', '78 Gold Street', 'Harrison');

INSERT INTO customer (cust_ID, customer_name, customer_street, customer_city)
VALUES ('74185', 'Lauren Lawn', '3 Gravy Avenue', 'Yonkers');

INSERT INTO customer (cust_ID, customer_name, customer_street, customer_city)
VALUES ('95124', 'Peter Pretender', '85 West Fourth Road', 'Manhattan');

INSERT INTO customer (cust_ID, customer_name, customer_street, customer_city)
VALUES ('86753', 'Susan Sits', '123 Easy Street', 'Bronx');

INSERT INTO customer (cust_ID, customer_name, customer_street, customer_city)
VALUES ('77776', 'Hank Handles', '2 Ford Drive', 'Harrison');

-- Insert Values into loan

INSERT INTO loan (loan_number, branch_name, amount)
VALUES ('462882645', 'Brooklyn Bridge Bank', '7500.00');

INSERT INTO loan (loan_number, branch_name, amount)
VALUES ('888512347', 'Bronx Federal Credit Union', '11500.00');

INSERT INTO loan (loan_number, branch_name, amount)
VALUES ('646469321', 'Upper East Federal Credit Union', '8550.00');

INSERT INTO loan (loan_number, branch_name, amount)
VALUES ('774485962', 'Yonkahs Bankahs', '2000.00');

INSERT INTO loan (loan_number, branch_name, amount)
VALUES ('919137375', 'Brooklyn Bank', '5000.00');

-- Insert Values into borrower

INSERT INTO borrower (cust_ID, loan_number)
VALUES ('54321','888512347');

INSERT INTO borrower (cust_ID, loan_number)
VALUES ('95124','888512347');

INSERT INTO borrower (cust_ID, loan_number)
VALUES ('24357','919137375');

INSERT INTO borrower (cust_ID, loan_number)
VALUES ('77776','462882645');

INSERT INTO borrower (cust_ID, loan_number)
VALUES ('98524','774485962');

-- Insert Values into account

INSERT INTO account (account_number, branch_name, balance)
VALUES ('142375689', 'First Bank of Brooklyn', '2003.64');

INSERT INTO account (account_number, branch_name, balance)
VALUES ('741852963', 'Yonkahs Bankahs', '5263.23');

INSERT INTO account (account_number, branch_name, balance)
VALUES ('159263487', 'Brooklyn Bank', '1425.98');

INSERT INTO account (account_number, branch_name, balance)
VALUES ('963852741', 'Upper East Federal Credit Union', '2598.36');

INSERT INTO account (account_number, branch_name, balance)
VALUES ('846275315', 'Brooklyn Bridge Bank', '688.12');

INSERT INTO account (account_number, branch_name, balance)
VALUES ('258258963', 'Bronx Federal Credit Union', '3256.21');

INSERT INTO account (account_number, branch_name, balance)
VALUES ('232154689', 'Big Bronx Bank', '4152.87');

INSERT INTO account (account_number, branch_name, balance)
VALUES ('222456197', 'Bronx Federal Credit Union', '1234.56');

INSERT INTO account (account_number, branch_name, balance)
VALUES ('774436581', 'Brooklyn Bank', '8259.34');

-- Insert Values into depositor

INSERT INTO depositor (cust_ID, account_number)
VALUES ('77776', '774436581');

INSERT INTO depositor (cust_ID, account_number)
VALUES ('24357', '222456197');

INSERT INTO depositor (cust_ID, account_number)
VALUES ('86753', '232154689');

INSERT INTO depositor (cust_ID, account_number)
VALUES ('74185', '258258963');

INSERT INTO depositor (cust_ID, account_number)
VALUES ('12345', '142375689');

INSERT INTO depositor (cust_ID, account_number)
VALUES ('73194', '741852963');

INSERT INTO depositor (cust_ID, account_number)
VALUES ('12345', '846275315');

INSERT INTO depositor (cust_ID, account_number)
VALUES ('77776', '963852741');

INSERT INTO depositor (cust_ID, account_number)
VALUES ('12345', '159263487');
