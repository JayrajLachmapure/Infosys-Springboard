-- =================================================================
-- BudgetWise Database Schema
-- AI-Based Budget Prediction & Financial Analytics Application
-- Created: Infosys Springboard Internship 2026
-- =================================================================

-- Drop existing database if it exists (use with caution in production)
-- DROP DATABASE IF EXISTS budgetwisedb;

-- Create the database
CREATE DATABASE IF NOT EXISTS budgetwisedb;

-- Use the database
USE budgetwisedb;

-- =================================================================
-- Table 1: users
-- Stores user account information
-- =================================================================

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    profession VARCHAR(100),
    budget DECIMAL(10, 2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add index on email for faster login queries
CREATE INDEX idx_email ON users(email);

-- =================================================================
-- Table 2: expenses
-- Stores all user expense records
-- =================================================================

CREATE TABLE IF NOT EXISTS expenses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userid INT NOT NULL,
    date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    note VARCHAR(255),
    category VARCHAR(50) DEFAULT 'General',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (userid) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add indexes for better query performance
CREATE INDEX idx_userid ON expenses(userid);
CREATE INDEX idx_date ON expenses(date);
CREATE INDEX idx_category ON expenses(category);

-- =================================================================
-- Insert Sample Data (Optional - for testing)
-- Comment out this section if you don't want sample data
-- =================================================================

-- Sample User 1
INSERT INTO users (name, email, password, phone, profession, budget) VALUES
('John Doe', 'john.doe@example.com', 'Pass@123', '+91-9876543210', 'Software Engineer', 50000.00);

-- Sample User 2
INSERT INTO users (name, email, password, phone, profession, budget) VALUES
('Jane Smith', 'jane.smith@example.com', 'Secure#456', '+91-9876543211', 'Product Manager', 60000.00);

-- Sample Expenses for User 1 (userid = 1)
INSERT INTO expenses (userid, date, amount, note, category) VALUES
(1, '2026-03-01', 250.00, 'Grocery shopping at Walmart', 'Food'),
(1, '2026-03-02', 50.00, 'Uber ride to office', 'Travel'),
(1, '2026-03-03', 1500.00, 'Monthly electricity bill', 'Utilities'),
(1, '2026-03-05', 800.00, 'New headphones', 'Shopping'),
(1, '2026-03-07', 300.00, 'Movie and dinner', 'Entertainment'),
(1, '2026-03-10', 500.00, 'Doctor consultation', 'Health'),
(1, '2026-03-12', 200.00, 'Restaurant lunch', 'Food'),
(1, '2026-03-15', 100.00, 'Metro card recharge', 'Travel');

-- Sample Expenses for User 2 (userid = 2)
INSERT INTO expenses (userid, date, amount, note, category) VALUES
(2, '2026-03-01', 350.00, 'Weekly groceries', 'Food'),
(2, '2026-03-04', 2000.00, 'Internet and phone bill', 'Utilities'),
(2, '2026-03-08', 1200.00, 'New shoes', 'Shopping'),
(2, '2026-03-10', 450.00, 'Concert tickets', 'Entertainment');

-- =================================================================
-- Useful Queries for Testing
-- =================================================================

-- View all users
-- SELECT * FROM users;

-- View all expenses
-- SELECT * FROM expenses;

-- View expenses with user information
-- SELECT e.id, u.name, e.date, e.amount, e.note, e.category 
-- FROM expenses e 
-- JOIN users u ON e.userid = u.id;

-- Get total expenses by category for a user
-- SELECT category, SUM(amount) as total 
-- FROM expenses 
-- WHERE userid = 1 
-- GROUP BY category;

-- Get monthly total for a user
-- SELECT YEAR(date) as year, MONTH(date) as month, SUM(amount) as total 
-- FROM expenses 
-- WHERE userid = 1 
-- GROUP BY YEAR(date), MONTH(date);

-- =================================================================
-- End of Database Schema
-- =================================================================

-- Display success message
SELECT 'BudgetWise database created successfully!' AS Status;
