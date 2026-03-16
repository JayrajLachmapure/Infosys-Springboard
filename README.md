# 💰 BudgetWise - AI-Based Budget Prediction & Financial Analytics

## 📋 Project Overview

**BudgetWise** is an intelligent financial management web application that helps users track expenses, set budgets, and predict future spending patterns using AI-based forecasting. Built during the Infosys Springboard Internship 2026, this project demonstrates full-stack development skills including frontend design, backend API development, database management, and data visualization.

### 🎯 Key Features

- **User Authentication**: Secure signup/login with password validation
- **Expense Tracking**: Add, edit, and delete expenses with categories
- **Budget Management**: Set monthly budgets and track spending limits
- **AI-Based Forecasting**: Predicts monthly expenses based on current spending patterns
- **Real-Time Analytics**: 
  - Budget usage percentage with visual progress bars
  - Category-wise spending distribution (Pie Chart)
  - Expense analysis by category (Bar Chart)
- **Responsive Design**: Works seamlessly on desktop and mobile devices
- **Profile Management**: Update user details and password
- **Interactive Dashboard**: Visual insights with Google Charts integration

---

## 🛠️ Technology Stack

### Frontend
- **HTML5**: Structure and semantic markup
- **CSS3**: Custom styling with CSS variables, flexbox, and grid
- **JavaScript (ES6+)**: Client-side logic and API integration
- **Google Charts API**: Data visualization

### Backend
- **Node.js**: Runtime environment
- **Express.js**: Web framework for REST API
- **MySQL2**: Database connector

### Database
- **MySQL**: Relational database for data persistence

### Dependencies
- `express`: ^5.2.1
- `mysql2`: ^3.16.3
- `cors`: ^2.8.6
- `body-parser`: ^2.2.2

---

## 📁 Project Structure

```
Infosys-Springboard/
│
├── web.html              # Frontend (HTML + CSS + JavaScript)
├── server.js             # Backend API (Express.js + MySQL)
├── package.json          # Node.js dependencies
├── package-lock.json     # Dependency lock file
├── database.sql          # Database schema
└── README.md            # Project documentation
```

### File Descriptions

**1. web.html**
- Complete single-page application
- Authentication system (Login/Signup)
- Dashboard with expense management
- Charts and analytics visualization
- Profile editing functionality

**2. server.js**
- RESTful API endpoints
- Database connection handling
- Password validation logic
- CRUD operations for users and expenses

**3. database.sql**
- MySQL database schema
- Table structures for `users` and `expenses`
- Foreign key relationships

---

## 🚀 Setup and Installation

### Prerequisites

Before you begin, ensure you have the following installed:

1. **Node.js** (v18 or higher)
   - Download from: https://nodejs.org/
   - Verify installation: `node --version`

2. **MySQL Server** (v8.0 or higher)
   - Download from: https://dev.mysql.com/downloads/mysql/
   - Verify installation: `mysql --version`

3. **Text Editor/IDE** (Optional but recommended)
   - VS Code, Sublime Text, or any code editor

### Step-by-Step Installation Guide

#### Step 1: Clone the Repository

```bash
# Clone the repository
git clone https://github.com/JayrajLachmapure/Infosys-Springboard.git

# Navigate to project directory
cd Infosys-Springboard
```

#### Step 2: Install Node.js Dependencies

```bash
# Install all required packages
npm install
```

This will install:
- express
- mysql2
- cors
- body-parser

#### Step 3: Setup MySQL Database

**Option A: Using MySQL Command Line**

```bash
# Login to MySQL (enter your MySQL root password when prompted)
mysql -u root -p
```

**Option B: Using MySQL Workbench**
- Open MySQL Workbench
- Connect to your local MySQL server
- Open a new SQL tab

**Execute the following SQL commands:**

```sql
-- Create the database
CREATE DATABASE budgetwisedb;

-- Use the database
USE budgetwisedb;

-- Create users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    profession VARCHAR(100),
    budget DECIMAL(10, 2) DEFAULT 0
);

-- Create expenses table
CREATE TABLE expenses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userid INT,
    date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    note VARCHAR(255),
    category VARCHAR(50) DEFAULT 'General',
    FOREIGN KEY (userid) REFERENCES users(id) ON DELETE CASCADE
);
```

#### Step 4: Configure Database Connection

Open `server.js` and update the MySQL connection settings (lines 8-13):

```javascript
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',           // Your MySQL username
    password: '8520',       // Your MySQL password (CHANGE THIS)
    database: 'budgetwisedb'
});
```

**⚠️ Important**: Replace `'8520'` with your actual MySQL password!

---

## ▶️ Running the Application

### Step 1: Start the Backend Server

Open a terminal in the project directory and run:

```bash
node server.js
```

You should see:
```
Connected to MySQL Database
Server running on port 3000
```

**Troubleshooting:**
- If you see "Database Connection Failed", check your MySQL credentials in `server.js`
- Ensure MySQL server is running
- Verify the database `budgetwisedb` exists

### Step 2: Open the Frontend

**Option A: Using Live Server (Recommended)**

If you're using VS Code:
1. Install "Live Server" extension
2. Right-click on `web.html`
3. Select "Open with Live Server"
4. Application opens at `http://127.0.0.1:5500/web.html`

**Option B: Direct File Open**

1. Navigate to the project folder
2. Double-click `web.html`
3. Opens in your default browser

**Option C: Using Python HTTP Server**

```bash
# For Python 3
python -m http.server 8000

# Then open browser and navigate to:
http://localhost:8000/web.html
```

---

## 📖 How to Use the Application

### 1. Create an Account

1. Click "New here? Create Account" on the login page
2. Fill in all required fields:
   - Full Name
   - Profession (e.g., Engineer, Student, Doctor)
   - Phone Number
   - Email
   - Password (min 8 chars, 1 uppercase, 1 number/symbol)
   - Confirm Password
3. Click "Create Account"
4. You'll be redirected to login

### 2. Login

1. Enter your registered email and password
2. Click "Login"
3. Dashboard will load with your data

### 3. Set Monthly Budget

1. In the "Monthly Budget" section
2. Enter your budget limit (e.g., 50000)
3. Click "Update Budget"
4. Budget usage will be displayed with progress bar

### 4. Add Expenses

1. Select date from the date picker
2. Choose category (Food, Travel, Utilities, etc.)
3. Enter amount
4. Add a description note
5. Click "Add Record"
6. Expense appears in "Recent Transactions" table
7. Charts update automatically

### 5. Edit/Delete Expenses

- Click "Edit" button on any expense to modify details
- Click "Delete" button to remove an expense
- Confirm deletion when prompted

### 6. View Analytics

- **Budget Usage**: Shows percentage and remaining budget
- **AI Projection**: Forecasts month-end spending
- **Pie Chart**: Category-wise distribution
- **Bar Chart**: Expense analysis by category

### 7. Edit Profile

1. Click "Profile" button in navbar
2. Update name, profession, or email
3. Change password (leave blank to keep current)
4. Click "Update"

---

## 🔌 API Endpoints

### Authentication

**POST** `/signup`
- Creates new user account
- Body: `{ name, email, pass, phone, profession }`
- Response: `{ success: true/false, message }`

**POST** `/login`
- Authenticates user
- Body: `{ email, pass }`
- Response: `{ success: true/false, user: {...} }`

### User Management

**GET** `/get-data/:id`
- Fetches user data and expenses
- Returns: User object with expenses array

**POST** `/update-profile`
- Updates user profile
- Body: `{ id, name, email, pass, profession }`

**POST** `/update-budget`
- Sets monthly budget
- Body: `{ id, budget }`

### Expense Management

**POST** `/add-expense`
- Creates new expense
- Body: `{ userId, date, amount, note, category }`

**POST** `/edit-expense`
- Updates existing expense
- Body: `{ id, date, amount, note, category }`

**DELETE** `/delete-expense/:id`
- Deletes expense by ID

---

## 🔐 Security Features

- **Password Validation**: Minimum 8 characters, requires uppercase, lowercase, and number/symbol
- **Email Uniqueness**: Prevents duplicate accounts
- **SQL Injection Protection**: Parameterized queries
- **CORS Enabled**: Secure cross-origin requests
- **Session Management**: Client-side session storage

---

## 🎨 Design Features

- **Color Scheme**: Professional blue theme with accent colors
- **Responsive Layout**: CSS Grid and Flexbox
- **Interactive UI**: Hover effects and smooth transitions
- **Progress Indicators**: Visual budget tracking
- **Alert System**: Color-coded budget warnings (green/yellow/red)

---

## 🐛 Troubleshooting

### Common Issues and Solutions

**1. Server won't start**
```
Error: Cannot find module 'express'
```
**Solution**: Run `npm install`

**2. Database connection failed**
```
Database Connection Failed: ER_ACCESS_DENIED_ERROR
```
**Solution**: 
- Check MySQL credentials in `server.js`
- Ensure MySQL server is running
- Verify database exists: `SHOW DATABASES;`

**3. CORS errors in browser console**
```
Access to fetch at 'http://localhost:3000/login' has been blocked by CORS policy
```
**Solution**: 
- Verify `cors` package is installed
- Check `app.use(cors())` is present in `server.js`

**4. Charts not displaying**
**Solution**:
- Check internet connection (Google Charts loads from CDN)
- Clear browser cache
- Check browser console for errors

**5. Password validation fails**
```
Password must be at least 8 chars...
```
**Solution**: Ensure password has:
- Minimum 8 characters
- At least 1 uppercase letter
- At least 1 lowercase letter
- At least 1 number or symbol

---

## 🔮 Future Enhancements

- [ ] Machine Learning integration for better predictions
- [ ] Monthly/yearly expense reports (PDF export)
- [ ] Budget recommendations based on income
- [ ] Multi-currency support
- [ ] Recurring expense tracking
- [ ] Email notifications for budget alerts
- [ ] Dark mode theme
- [ ] Mobile app version

---

## 👨‍💻 Developer

**Jayraj Lachmapure**  
Infosys Springboard Internship 2026

---

## 📄 License

This project is created for educational purposes as part of the Infosys Springboard Internship program.

---

## 🙏 Acknowledgments

- Infosys Springboard for the internship opportunity
- Google Charts for visualization library
- Node.js and Express.js communities

---

## 📞 Support

For issues or questions:
1. Check the Troubleshooting section above
2. Review the code comments in `server.js` and `web.html`
3. Create an issue on GitHub repository

---

**Made with ❤️ during Infosys Springboard Internship 2026**
