const router = require('express').Router();
const db = require('../config/db');
const { verifyToken, isAdmin } = require('../middleware/auth');

// Lấy thông tin user hiện tại
router.get('/me', verifyToken, async (req, res) => {
  try {
    const [rows] = await db.query(
      'SELECT id, full_name, email, phone, avatar_url, role, created_at FROM users WHERE id = ?',
      [req.user.id]
    );
    if (rows.length === 0) return res.status(404).json({ message: 'Không tìm thấy user' });
    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

// Cập nhật thông tin user
router.put('/me', verifyToken, async (req, res) => {
  try {
    const { full_name, phone, avatar_url } = req.body;
    await db.query(
      'UPDATE users SET full_name = COALESCE(?, full_name), phone = COALESCE(?, phone), avatar_url = COALESCE(?, avatar_url) WHERE id = ?',
      [full_name, phone, avatar_url, req.user.id]
    );
    res.json({ message: 'Cập nhật thành công' });
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

// [ADMIN] Lấy danh sách tất cả users
router.get('/', verifyToken, isAdmin, async (req, res) => {
  try {
    const [rows] = await db.query(
      'SELECT id, full_name, email, phone, role, is_active, created_at FROM users ORDER BY id'
    );
    res.json(rows);
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

module.exports = router;
