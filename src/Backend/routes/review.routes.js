const router = require('express').Router();
const db = require('../config/db');
const { verifyToken } = require('../middleware/auth');

// Lấy reviews của nhà hàng (public)
router.get('/restaurant/:restaurantId', async (req, res) => {
  try {
    const [rows] = await db.query(
      `SELECT rv.*, u.full_name, u.avatar_url
       FROM reviews rv
       JOIN users u ON rv.user_id = u.id
       WHERE rv.restaurant_id = ?
       ORDER BY rv.created_at DESC`,
      [req.params.restaurantId]
    );
    res.json(rows);
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

// Tạo review
router.post('/', verifyToken, async (req, res) => {
  try {
    const { restaurant_id, order_id, rating, comment } = req.body;

    const [result] = await db.query(
      'INSERT INTO reviews (user_id, restaurant_id, order_id, rating, comment) VALUES (?, ?, ?, ?, ?)',
      [req.user.id, restaurant_id, order_id || null, rating, comment]
    );

    // Cập nhật rating trung bình của nhà hàng
    await db.query(
      `UPDATE restaurants SET rating = (
        SELECT ROUND(AVG(rating), 1) FROM reviews WHERE restaurant_id = ?
      ) WHERE id = ?`,
      [restaurant_id, restaurant_id]
    );

    res.status(201).json({ message: 'Đánh giá thành công', reviewId: result.insertId });
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

module.exports = router;
