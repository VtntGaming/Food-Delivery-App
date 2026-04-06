const router = require('express').Router();
const db = require('../config/db');
const { verifyToken } = require('../middleware/auth');

// Lấy tất cả nhà hàng (public)
router.get('/', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM restaurants WHERE is_open = 1 ORDER BY rating DESC');
    res.json(rows);
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

// Lấy chi tiết 1 nhà hàng + danh sách món
router.get('/:id', async (req, res) => {
  try {
    const [restaurant] = await db.query('SELECT * FROM restaurants WHERE id = ?', [req.params.id]);
    if (restaurant.length === 0) return res.status(404).json({ message: 'Không tìm thấy nhà hàng' });

    const [foods] = await db.query(
      'SELECT f.*, c.name AS category_name FROM foods f LEFT JOIN categories c ON f.category_id = c.id WHERE f.restaurant_id = ? AND f.is_available = 1 ORDER BY c.sort_order, f.name',
      [req.params.id]
    );

    res.json({ ...restaurant[0], foods });
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

// Tạo nhà hàng mới (cần đăng nhập)
router.post('/', verifyToken, async (req, res) => {
  try {
    const { name, description, phone, address, image_url } = req.body;
    const [result] = await db.query(
      'INSERT INTO restaurants (owner_id, name, description, phone, address, image_url) VALUES (?, ?, ?, ?, ?, ?)',
      [req.user.id, name, description, phone, address, image_url]
    );
    res.status(201).json({ message: 'Tạo nhà hàng thành công', restaurantId: result.insertId });
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

// Cập nhật nhà hàng
router.put('/:id', verifyToken, async (req, res) => {
  try {
    const { name, description, phone, address, image_url, is_open } = req.body;
    await db.query(
      `UPDATE restaurants SET
        name = COALESCE(?, name),
        description = COALESCE(?, description),
        phone = COALESCE(?, phone),
        address = COALESCE(?, address),
        image_url = COALESCE(?, image_url),
        is_open = COALESCE(?, is_open)
      WHERE id = ? AND owner_id = ?`,
      [name, description, phone, address, image_url, is_open, req.params.id, req.user.id]
    );
    res.json({ message: 'Cập nhật nhà hàng thành công' });
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

module.exports = router;
