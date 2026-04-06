const router = require('express').Router();
const db = require('../config/db');

// Lấy tất cả danh mục
router.get('/', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM categories ORDER BY sort_order');
    res.json(rows);
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

// Lấy món ăn theo danh mục
router.get('/:id/foods', async (req, res) => {
  try {
    const [rows] = await db.query(
      `SELECT f.*, r.name AS restaurant_name
       FROM foods f
       JOIN restaurants r ON f.restaurant_id = r.id
       WHERE f.category_id = ? AND f.is_available = 1
       ORDER BY f.name`,
      [req.params.id]
    );
    res.json(rows);
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

module.exports = router;
