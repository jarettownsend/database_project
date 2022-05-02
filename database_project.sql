--------------------------------------------------------------------------------
/*				                 Banking DDL                   		  		          */
--------------------------------------------------------------------------------
/* Write the DDL for the data that is given in database_project_data.sql    */

		CREATE TABLE branch (
		branch_name	varchar(40),
		branch_city	varchar(40),
		assets	numeric(20,2),
		CONSTRAINT branch_pkey PRIMARY KEY (branch_name)
	);

		CREATE TABLE customer (
		cust_ID	varchar(20),
		customer_name varchar(40),
		customer_street	varchar(40),
		customer_city varchar(40),
		CONSTRAINT customer_pkey PRIMARY KEY (cust_ID)
	);


		CREATE TABLE loan (
		loan_number varchar(20),
		branch_name varchar(40),
		amount numeric(20, 2),
		CONSTRAINT loan_pkey PRIMARY KEY (loan_number),
		CONSTRAINT loan_fkey FOREIGN KEY (branch_name) REFERENCES branch (branch_name)
			ON DELETE SET NULL
	);

		CREATE TABLE borrower (
		cust_ID varchar(20),
		loan_number varchar(20),
		CONSTRAINT borrower_pkey PRIMARY KEY (cust_ID, loan_number),
		CONSTRAINT borrower_fkey_1 FOREIGN KEY (cust_ID) REFERENCES customer (cust_ID)
			ON DELETE SET NULL,
		CONSTRAINT borrower_fkey_2 FOREIGN KEY (loan_number) REFERENCES loan (loan_number)
			ON DELETE SET NULL
	);

		CREATE TABLE account (
		account_number varchar(20),
		branch_name varchar(40),
		balance	numeric(20, 2),
		CONSTRAINT account_pkey PRIMARY KEY (account_number),
		CONSTRAINT account_fkey FOREIGN KEY (branch_name) REFERENCES branch (branch_name)
			ON DELETE SET NULL
	);

		CREATE TABLE depositor (
		cust_ID varchar(20),
		account_number varchar(20),
		CONSTRAINT depositor_pkey PRIMARY KEY (cust_ID, account_number),
		CONSTRAINT depositor_fkey FOREIGN KEY (cust_ID) REFERENCES customer (cust_ID)
			ON DELETE SET NULL
	);

--------------------------------------------------------------------------------
/*				                  Question 1                                            */
--------------------------------------------------------------------------------
/*Write a SQL function that accepts a principal mortgage amount, an annual percentage
rate (APR), and the number of years a mortgage will be paid back over. Calculate the
associated monthly mortgage payment                                               */

   	CREATE OR REPLACE FUNCTION Townsend_29_monthlyPayment(principle NUMERIC(12,2), APR NUMERIC(9,8), years INTEGER)
		RETURNS NUMERIC(8,2)
		LANGUAGE plpgsql
		AS
		$$
			DECLARE
				MonthlyPayment NUMERIC(8,2);

			BEGIN
				SELECT principle*((APR/12) + ((APR/12)/(POWER(1 + (APR/12), (years*12)) -1)))
				INTO MonthlyPayment;

				RETURN MonthlyPayment;
			END;
		$$;

--------------------------------------------------------------------------------
/*				                  Question 2           		  		          */
--------------------------------------------------------------------------------

    ------------------------------- Part (a) ------------------------------
/*Write a query to find the ID and customer name of each customer at the bank
who only has a loan at the bank, and no account.                               */
	SELECT DISTINCT customer.cust_id, customer.customer_name
	FROM customer, borrower
	WHERE customer.cust_id = borrower.cust_id AND
	customer.cust_id NOT IN (SELECT customer.cust_id
							FROM customer, depositor
							WHERE customer.cust_id = depositor.cust_id);

    ------------------------------- Part (b) ------------------------------
/* Write a query to find the ID and customer name of each customer
who lives on the same street and in the same city as customer ‘12345’*/
	 SELECT cust_ID, customer_name
	 FROM customer
	 WHERE customer_street IN (SELECT customer_street
							  FROM customer
							  WHERE cust_id = '12345')
		AND customer_city IN (SELECT customer_city
							 FROM customer
							 WHERE cust_id = '12345');


    ------------------------------- Part (c) ------------------------------
/* Write a query to find the name of each branch that has at least one customer
 who has an account in the bank and who lives in “Harrison”.              */
	 SELECT branch_name
	 FROM account
	 WHERE account_number IN (SELECT account_number
							 FROM depositor, customer
							 WHERE depositor.cust_id = customer.cust_id
							 AND customer_city = 'Harrison');


    ------------------------------- Part (d) ------------------------------
/*Write a query to find each customer who has an account at every branch located
 in “Brooklyn                                                             */
	SELECT customer.customer_name
	FROM customer, depositor, account, branch
	WHERE customer.cust_id = depositor.cust_id
	AND depositor.account_number = account.account_number
	AND account.branch_name = branch.branch_name
	AND branch_city = 'Brooklyn'
	GROUP BY customer.customer_name
	HAVING COUNT(DISTINCT(account.branch_name)) =
	(select count(branch_name) from branch where branch_city = 'Brooklyn');


--------------------------------------------------------------------------------
/*				                  Question 3           		  		          */
--------------------------------------------------------------------------------
/*Create the following Function and Trigger
Function:
Create a function where as a result of the account being deleted it
goes to a dependent table and removes entries there for the same account in the depositor table
Trigger:
On delete of an account, execute the function
 */
 	CREATE OR REPLACE FUNCTION Townsend_29_bankTriggerFunction()
			RETURNS TRIGGER
			LANGUAGE plpgsql
			AS
			$$
				BEGIN

					DELETE FROM depositor
					WHERE depositor.account_number = OLD.account_number;

				RETURN OLD;

				END;
			$$;

			CREATE OR REPLACE TRIGGER Townsend_29_bankTrigger
			AFTER DELETE ON account
			FOR EACH ROW
			EXECUTE PROCEDURE Townsend_29_bankTriggerFunction();

--------------------------------------------------------------------------------
/*				                  Question 4           		  		          */
--------------------------------------------------------------------------------
/* Create a new table that includes instructor_id, instructor_name, and the
number of courses that they teach. You will need to create a new variable for
the number of courses they teach called tot_courses                        */
		CREATE TABLE instructor_course_nums (
		ID	varchar(20),
		name varchar(40),
		tot_courses	INTEGER,
		CONSTRAINT instructor_course_nums_pkey PRIMARY KEY (ID, name)
	);


		CREATE OR REPLACE PROCEDURE Townsend_29_insCourse(IN id VARCHAR(20), INOUT tot_courses INTEGER DEFAULT 0)
		LANGUAGE plpgsql
		AS
		$$
			DECLARE
				record_count integer;

			BEGIN
			SELECT COUNT(*) INTO record_count
			FROM instructor_course_nums
			WHERE instructor_course_nums.id = Townsend_29_insCourse.id;

			SELECT COUNT(*) INTO Townsend_29_insCourse.tot_courses
			FROM teaches
			WHERE teaches.ID = Townsend_29_insCourse.id;

			IF record_count > 0 THEN
				UPDATE instructor_course_nums
				SET tot_courses = Townsend_29_insCourse.tot_courses
				WHERE instructor_course_nums.id = Townsend_29_insCourse.id;

			ELSE
				INSERT INTO instructor_course_nums (ID, name, tot_courses)
					SELECT instructor.id, name, Townsend_29_insCourse.tot_courses
					FROM instructor
					WHERE instructor.id = Townsend_29_insCourse.id;

			END IF;
			END;
		$$;
