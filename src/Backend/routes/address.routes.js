const router = require('express').Router();
const db = require('../config/db');
const { verifyToken } = require('../middleware/auth');

router.use(verifyToken);

// Danh sách địa chỉ của user
router.get('/', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM addresses WHERE user_id = ? ORDER BY is_default DESC', [req.user.id]);
    res.json(rows);
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

// Thêm địa chỉ
router.post('/', async (req, res) => {
  try {
    const { label, address_line, ward, district, city, is_default } = req.body;

    // Nếu đặt làm mặc định thì bỏ mặc định cũ
    if (is_default) {
      await db.query('UPDATE addresses SET is_default = 0 WHERE user_id = ?', [req.user.id]);
    }

    const [result] = await db.query(
      'INSERT INTO addresses (user_id, label, address_line, ward, district, city, is_default) VALUES (?, ?, ?, ?, ?, ?, ?)',
      [req.user.id, label || 'Nhà', address_line, ward, district, city, is_default ? 1 : 0]
    );
    res.status(201).json({ message: 'Thêm địa chỉ thành công', addressId: result.insertId });
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

// Cập nhật địa chỉ
router.put('/:id', async (req, res) => {
  try {
    const { label, address_line, ward, district, city, is_default } = req.body;

    if (is_default) {
      await db.query('UPDATE addresses SET is_default = 0 WHERE user_id = ?', [req.user.id]);
    }

    await db.query(
      `UPDATE addresses SET
        label = COALESCE(?, label),
        address_line = COALESCE(?, address_line),
        ward = COALESCE(?, ward),
        district = COALESCE(?, district),
        city = COALESCE(?, city),
        is_default = COALESCE(?, is_default)
      WHERE id = ? AND user_id = ?`,
      [label, address_line, ward, district, city, is_default, req.params.id, req.user.id]
    );
    res.json({ message: 'Cập nhật địa chỉ thành công' });
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

// Xoá địa chỉ
router.delete('/:id', async (req, res) => {
  try {
    await db.query('DELETE FROM addresses WHERE id = ? AND user_id = ?', [req.params.id, req.user.id]);
    res.json({ message: 'Xoá địa chỉ thành công' });
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

module.exports = router;
