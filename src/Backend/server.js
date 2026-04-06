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
// app.use('/api/users',         require('./routes/user.routes'));
app.use('/api/restaurants',   require('./routes/restaurant.routes'));
// app.use('/api/categories',    require('./routes/category.routes'));
app.use('/api/foods',         require('./routes/food.routes'));
app.use('/api/cart',           require('./routes/cart.routes'));
// app.use('/api/orders',        require('./routes/order.routes'));
// app.use('/api/addresses',     require('./routes/address.routes'));
// app.use('/api/favorites',     require('./routes/favorite.routes'));
// app.use('/api/reviews',       require('./routes/review.routes'));
// app.use('/api/notifications', require('./routes/notification.routes'));
// app.use('/api/promocodes',    require('./routes/promocode.routes'));
// Health check
app.get('/', (req, res) => {
  res.json({ message: 'Food Ordering API is running!' });
});

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server đang chạy tại http://localhost:${PORT}`);
});
