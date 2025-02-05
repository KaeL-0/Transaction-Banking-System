--Create Sequences

CREATE SEQUENCE customer_seq
    START with 1
    INCREMENT by 1
    NOCACHE
    NOCYCLE;
CREATE SEQUENCE account_seq
    START with 1
    INCREMENT by 1
    NOCACHE
    NOCYCLE;
CREATE SEQUENCE transaction_seq
    START with 1
    INCREMENT by 1
    NOCACHE
    NOCYCLE;

--Create Tables
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL
);

CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    AccountType VARCHAR(20)  CHECK (AccountType IN ('Savings', 'Checking')) NOT NULL,
    Balance DECIMAL(15, 2) DEFAULT 0 NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    AccountID INT NOT NULL ,
    TransactionType VARCHAR(20) CHECK (TransactionType IN ('Deposit', 'Withdrawal')) NOT NULL,
    Amount DECIMAL(15, 2) NOT NULL,
    TransactionDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

--Create Procedures

CREATE OR REPLACE PROCEDURE withdraw(
    acct_id IN accounts.ACCOUNTID%TYPE,
    v_amount IN transactions.AMOUNT%TYPE )
IS
    v_balance accounts.BALANCE%TYPE; 
BEGIN

   SELECT balance
    INTO v_balance
    FROM accounts
    WHERE ACCOUNTID = acct_id;


   IF v_amount > v_balance THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: Insufficient funds.' || CHR(10));
 
        RETURN;
    END IF;
 
    UPDATE Accounts
    SET balance = balance - v_amount
    where ACCOUNTID = acct_id;

    INSERT INTO Transactions (TransactionID, AccountID, TransactionType, Amount)
    VALUES (transaction_seq.NEXTVAL, acct_id, 'Withdrawal', v_amount);


    DBMS_OUTPUT.PUT_LINE('TRANSACTION ' || transaction_seq.CURRVAL || CHR(10));
    DBMS_OUTPUT.PUT_LINE('Entered Account ID         : ' || acct_id);
    DBMS_OUTPUT.PUT_LINE('Entered amount to withdraw : PHP ' || v_amount);
    DBMS_OUTPUT.PUT_LINE('______________________________________________________' || CHR(10));
   
END withdraw;
/

CREATE OR REPLACE PROCEDURE deposit(
    acct_id IN accounts.ACCOUNTID%TYPE,
    v_amount IN transactions.AMOUNT%TYPE )
IS
BEGIN
 
    
    UPDATE Accounts
    SET balance = balance + v_amount
    where ACCOUNTID = acct_id;

    INSERT INTO Transactions (TransactionID, AccountID, TransactionType, Amount)
    VALUES (transaction_seq.NEXTVAL, acct_id, 'Deposit', v_amount);

    DBMS_OUTPUT.PUT_LINE('TRANSACTION ' || transaction_seq.CURRVAL || CHR(10));
    DBMS_OUTPUT.PUT_LINE('Entered Account ID         : ' || acct_id);
    DBMS_OUTPUT.PUT_LINE('Entered amount to withdraw : PHP ' || v_amount);
    DBMS_OUTPUT.PUT_LINE('______________________________________________________' || CHR(10));
   
END deposit;
/

--Insert Customer Data

INSERT INTO Customers (CustomerID, Name, Address, PhoneNumber) VALUES
(customer_seq.NEXTVAL, 'John Doe', '123 Maple Street', '123-456-7890');

INSERT INTO Customers (CustomerID, Name, Address, PhoneNumber) VALUES
(customer_seq.NEXTVAL, 'Jane Smith', '456 Oak Avenue', '987-654-3210');



--Insert Accounts Data

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance) VALUES
(account_seq.NEXTVAL, 1, 'Savings', 1500.00);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance) VALUES
(account_seq.NEXTVAL, 1, 'Checking', 8000.00);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance) VALUES
(account_seq.NEXTVAL, 2, 'Savings', 2000.00);


--Insert Transactions Data


BEGIN

WITHDRAW(1, 500);

DEPOSIT(1, 313);

WITHDRAW(2, 4245);

DEPOSIT(2, 452);

WITHDRAW(3, 400);

COMMIT;

END;

/

