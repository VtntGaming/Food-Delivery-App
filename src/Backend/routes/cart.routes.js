const router = require('express').Router();
const db = require('../config/db');
const { verifyToken } = require('../middleware/auth');

// Tất cả route giỏ hàng đều cần đăng nhập
router.use(verifyToken);

// Lấy giỏ hàng của user
router.get('/', async (req, res) => {
  try {
    const [cart] = await db.query('SELECT id FROM carts WHERE user_id = ?', [req.user.id]);
    if (cart.length === 0) return res.json({ items: [], total: 0 });

    const [items] = await db.query(
      `SELECT ci.id, ci.food_id, ci.quantity, ci.note,
              f.name, f.price, f.image_url, f.restaurant_id,
              r.name AS restaurant_name
       FROM cart_items ci
       JOIN foods f ON ci.food_id = f.id
       JOIN restaurants r ON f.restaurant_id = r.id
       WHERE ci.cart_id = ?`,
      [cart[0].id]
    );

    const total = items.reduce((sum, item) => sum + item.price * item.quantity, 0);
    res.json({ cartId: cart[0].id, items, total });
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

// Thêm món vào giỏ
router.post('/items', async (req, res) => {
  try {
    const { food_id, quantity, note } = req.body;

    // Đảm bảo user có giỏ hàng
    await db.query('INSERT IGNORE INTO carts (user_id) VALUES (?)', [req.user.id]);
    const [cart] = await db.query('SELECT id FROM carts WHERE user_id = ?', [req.user.id]);

    // Thêm hoặc cập nhật số lượng
    await db.query(
      `INSERT INTO cart_items (cart_id, food_id, quantity, note)
       VALUES (?, ?, ?, ?)
       ON DUPLICATE KEY UPDATE quantity = quantity + VALUES(quantity), note = COALESCE(VALUES(note), note)`,
      [cart[0].id, food_id, quantity || 1, note || null]
    );

    res.json({ message: 'Đã thêm vào giỏ hàng' });
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

// Cập nhật số lượng
router.put('/items/:itemId', async (req, res) => {
  try {
    const { quantity, note } = req.body;
    if (quantity <= 0) {
      await db.query('DELETE FROM cart_items WHERE id = ?', [req.params.itemId]);
      return res.json({ message: 'Đã xoá khỏi giỏ hàng' });
    }
    await db.query(
      'UPDATE cart_items SET quantity = ?, note = COALESCE(?, note) WHERE id = ?',
      [quantity, note, req.params.itemId]
    );
    res.json({ message: 'Đã cập nhật giỏ hàng' });
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

// Xoá 1 món khỏi giỏ
router.delete('/items/:itemId', async (req, res) => {
  try {
    await db.query('DELETE FROM cart_items WHERE id = ?', [req.params.itemId]);
    res.json({ message: 'Đã xoá khỏi giỏ hàng' });
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

// Xoá toàn bộ giỏ hàng
router.delete('/', async (req, res) => {
  try {
    const [cart] = await db.query('SELECT id FROM carts WHERE user_id = ?', [req.user.id]);
    if (cart.length > 0) {
      await db.query('DELETE FROM cart_items WHERE cart_id = ?', [cart[0].id]);
    }
    res.json({ message: 'Đã xoá toàn bộ giỏ hàng' });
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

module.exports = router;
