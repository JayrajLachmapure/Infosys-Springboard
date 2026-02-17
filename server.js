const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const bodyParser = require('body-parser');

const app = express();
app.use(cors());
app.use(bodyParser.json());

// --- DATABASE CONNECTION ---
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',      // Replace with your MySQL username
    password: '8520', // Replace with your MySQL password
    database: 'budgetwise_db'
});

db.connect(err => {
    if (err) console.error('Database Connection Failed:', err);
    else console.log('Connected to MySQL Database');
});

// --- API ENDPOINTS ---

// 1. Sign Up
app.post('/signup', (req, res) => {
    const { name, email, pass, phone } = req.body;
    const sql = 'insert into users (name, email, password, phone) VALUES (?, ?, ?, ?)';
    db.query(sql, [name, email, pass, phone], (err, result) => {
        if (err) return res.json({ success: false, message: 'Email already exists or DB error' });
        res.json({ success: true, message: 'User registered!' });
    });
});

// 2. Login
app.post('/login', (req, res) => {
    const { email, pass } = req.body;
    const sql = 'select * from users WHERE email = ? AND password = ?';
    db.query(sql, [email, pass], (err, results) => {
        if (err || results.length === 0) return res.json({ success: false });
        const user = results[0];
        res.json({ success: true, user });
    });
});

// 3. Get User Data (Reload Dashboard)
app.get('/get-data/:id', (req, res) => {
    const userId = req.params.id;
    // Get User Details
    db.query('select * from users where id = ?', [userId], (err, userResult) => {
        if (err) return res.json({ error: true });
        
        // Get User Expenses
        db.query('select * from expenses where user_id = ?', [userId], (err, expResult) => {
            const userData = userResult[0];
            userData.expenses = expResult; // Attach expenses to user object
            res.json(userData);
        });
    });
});

// 4. Update Budget
app.post('/update-budget', (req, res) => {
    const { id, budget } = req.body;
    db.query('update users set budget = ? WHERE id = ?', [budget, id], (err) => {
        if (err) return res.json({ success: false });
        res.json({ success: true });
    });
});

// 5. Add Expense
app.post('/add-expense', (req, res) => {
    const { userId, date, amount, note } = req.body;
    const sql = 'insert into expenses (user_id, date, amount, note) VALUES (?, ?, ?, ?)';
    db.query(sql, [userId, date, amount, note], (err) => {
        if (err) return res.json({ success: false });
        res.json({ success: true });
    });
});

// 6. Update Profile
app.post('/update-profile', (req, res) => {
    const { id, name, email, pass } = req.body;
    let sql = 'update users set name = ?, email = ? WHERE id = ?';
    let params = [name, email, id];
    
    // Only update password if provided
    if (pass) {
        sql = 'update users set name = ?, email = ?, password = ? WHERE id = ?';
        params = [name, email, pass, id];
    }
    
    db.query(sql, params, (err) => {
        if (err) return res.json({ success: false });
        res.json({ success: true });
    });
});

app.listen(3000, () => {
    console.log('Server running on port 3000');
});