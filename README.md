# Transaction Banking System

## Project Overview
The **Transaction Banking System** is a database system designed to handle customer accounts, transactions, and banking operations efficiently. It consists of tables for customers, accounts, and transactions, as well as stored procedures for depositing and withdrawing funds.

## Features
- **Customer Management**: Store and retrieve customer details.
- **Account Management**: Support for savings and checking accounts.
- **Transaction Handling**: Secure processing of deposits and withdrawals.
- **Stored Procedures**: Automate withdrawal and deposit operations.
- **Query Support**: Retrieve, update, and manipulate data using SQL queries.

## Database Schema
### Tables
1. **Customers**
   - `CustomerID` (Primary Key, Auto-incremented)
   - `Name`
   - `Address`
   - `PhoneNumber`

2. **Accounts**
   - `AccountID` (Primary Key, Auto-incremented)
   - `CustomerID` (Foreign Key references Customers)
   - `AccountType` (Savings, Checking)
   - `Balance`

3. **Transactions**
   - `TransactionID` (Primary Key, Auto-incremented)
   - `AccountID` (Foreign Key references Accounts)
   - `TransactionType` (Deposit, Withdrawal)
   - `Amount`
   - `TransactionDate`

### Sequences
- `customer_seq` for Customers table
- `account_seq` for Accounts table
- `transaction_seq` for Transactions table

## Stored Procedures
1. **Withdraw Procedure**
   - Checks if the account has sufficient funds before allowing withdrawal.
   - Updates account balance and records the transaction.
   
2. **Deposit Procedure**
   - Increases account balance with the deposited amount.
   - Records the transaction.

## Sample Data Insertion
- Adding sample customers.
- Creating accounts for customers.
- Performing transactions using stored procedures.

## SQL Queries
1. **Retrieve customer accounts with balance > 1000**
2. **Count number of accounts per customer with total balance**
3. **Update balances for accounts with balance < 2000**
4. **Insert a new account for an existing customer**
5. **Display customer details and balances for accounts > 2000**
6. **Retrieve customer and account details using implicit joins**

## How to Use
1. **Set up the database**: Execute the provided SQL scripts to create tables and sequences.
2. **Insert initial data**: Run the sample data insertion queries.
3. **Perform transactions**: Use the stored procedures for deposits and withdrawals.
4. **Execute queries**: Run the predefined SQL queries for data retrieval and updates.

## Author
Mikhael Edman P. Gomez

