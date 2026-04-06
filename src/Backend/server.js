const express = require('express');
const cors = require('cors');
require('dotenv').config();

const app = express();

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Routes
app.use('/api/auth',          require('./routes/auth.routes'));

app.use('/api/categories',    require('./routes/category.routes'));


// Health check
app.get('/', (req, res) => {
  res.json({ message: 'Food Ordering API is running!' });
});

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server đang chạy tại http://localhost:${PORT}`);
});
