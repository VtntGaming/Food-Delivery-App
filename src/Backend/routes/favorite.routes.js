const router = require('express').Router();
const db = require('../config/db');
const { verifyToken } = require('../middleware/auth');

router.use(verifyToken);

// Danh sách yêu thích
router.get('/', async (req, res) => {
  try {
    const [rows] = await db.query(
      `SELECT fav.id, fav.food_id, fav.created_at,
              f.name, f.price, f.image_url, f.restaurant_id,
              r.name AS restaurant_name
       FROM favorites fav
       JOIN foods f ON fav.food_id = f.id
       JOIN restaurants r ON f.restaurant_id = r.id
       WHERE fav.user_id = ?
       ORDER BY fav.created_at DESC`,
      [req.user.id]
    );
    res.json(rows);
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

// Thêm yêu thích (toggle)
router.post('/', async (req, res) => {
  try {
    const { food_id } = req.body;

    // Kiểm tra đã yêu thích chưa
    const [existing] = await db.query(
      'SELECT id FROM favorites WHERE user_id = ? AND food_id = ?',
      [req.user.id, food_id]
    );

    if (existing.length > 0) {
      // Đã yêu thích → bỏ yêu thích
      await db.query('DELETE FROM favorites WHERE id = ?', [existing[0].id]);
      return res.json({ message: 'Đã bỏ yêu thích', isFavorite: false });
    }

    // Chưa có → thêm
    await db.query('INSERT INTO favorites (user_id, food_id) VALUES (?, ?)', [req.user.id, food_id]);
    res.json({ message: 'Đã thêm yêu thích', isFavorite: true });
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

// Xoá yêu thích
router.delete('/:foodId', async (req, res) => {
  try {
    await db.query('DELETE FROM favorites WHERE user_id = ? AND food_id = ?', [req.user.id, req.params.foodId]);
    res.json({ message: 'Đã bỏ yêu thích' });
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

module.exports = router;
