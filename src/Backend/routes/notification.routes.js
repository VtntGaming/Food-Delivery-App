const router = require('express').Router();
const db = require('../config/db');
const { verifyToken } = require('../middleware/auth');

router.use(verifyToken);

// Danh sách thông báo
router.get('/', async (req, res) => {
  try {
    const [rows] = await db.query(
      'SELECT * FROM notifications WHERE user_id = ? ORDER BY created_at DESC LIMIT 50',
      [req.user.id]
    );
    res.json(rows);
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

// Đánh dấu đã đọc 1 thông báo
router.put('/:id/read', async (req, res) => {
  try {
    await db.query(
      'UPDATE notifications SET is_read = 1 WHERE id = ? AND user_id = ?',
      [req.params.id, req.user.id]
    );
    res.json({ message: 'Đã đánh dấu đã đọc' });
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

// Đánh dấu tất cả đã đọc
router.put('/read-all', async (req, res) => {
  try {
    await db.query(
      'UPDATE notifications SET is_read = 1 WHERE user_id = ? AND is_read = 0',
      [req.user.id]
    );
    res.json({ message: 'Đã đánh dấu tất cả đã đọc' });
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

// Đếm số thông báo chưa đọc
router.get('/unread-count', async (req, res) => {
  try {
    const [rows] = await db.query(
      'SELECT COUNT(*) AS count FROM notifications WHERE user_id = ? AND is_read = 0',
      [req.user.id]
    );
    res.json({ unreadCount: rows[0].count });
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

module.exports = router;
