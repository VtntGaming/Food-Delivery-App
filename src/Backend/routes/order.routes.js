const router = require('express').Router();
const db = require('../config/db');
const { verifyToken } = require('../middleware/auth');

router.use(verifyToken);

// Tạo đơn hàng từ giỏ hàng
router.post('/', async (req, res) => {
  const connection = await db.getConnection();
  try {
    await connection.beginTransaction();

    const { address_id, promocode, payment_method, note } = req.body;

    // Lấy giỏ hàng
    const [cart] = await connection.query('SELECT id FROM carts WHERE user_id = ?', [req.user.id]);
    if (cart.length === 0) throw new Error('Giỏ hàng trống');

    const [items] = await connection.query(
      `SELECT ci.food_id, ci.quantity, ci.note, f.name, f.price, f.restaurant_id
       FROM cart_items ci JOIN foods f ON ci.food_id = f.id
       WHERE ci.cart_id = ?`,
      [cart[0].id]
    );
    if (items.length === 0) throw new Error('Giỏ hàng trống');

    // Tính tiền
    const restaurant_id = items[0].restaurant_id;
    const subtotal = items.reduce((sum, i) => sum + i.price * i.quantity, 0);
    const delivery_fee = 15000;
    let discount_amount = 0;
    let promocode_id = null;

    // Kiểm tra mã giảm giá
    if (promocode) {
      const [codes] = await connection.query(
        `SELECT * FROM promocodes WHERE code = ? AND is_active = 1
         AND (start_date IS NULL OR start_date <= CURDATE())
         AND (end_date IS NULL OR end_date >= CURDATE())
         AND (usage_limit IS NULL OR used_count < usage_limit)`,
        [promocode]
      );
      if (codes.length > 0) {
        const pc = codes[0];
        if (subtotal >= pc.min_order_amount) {
          promocode_id = pc.id;
          if (pc.discount_type === 'percent') {
            discount_amount = Math.floor(subtotal * pc.discount_value / 100);
            if (pc.max_discount && discount_amount > pc.max_discount) {
              discount_amount = pc.max_discount;
            }
          } else {
            discount_amount = pc.discount_value;
          }
          await connection.query(
            'UPDATE promocodes SET used_count = used_count + 1 WHERE id = ?',
            [pc.id]
          );
        }
      }
    }

    const total = subtotal - discount_amount + delivery_fee;

    // Tạo order
    const [orderResult] = await connection.query(
      `INSERT INTO orders (user_id, restaurant_id, address_id, promocode_id, subtotal, discount_amount, delivery_fee, total, payment_method, note)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [req.user.id, restaurant_id, address_id, promocode_id, subtotal, discount_amount, delivery_fee, total, payment_method || 'cash', note]
    );

    // Tạo order items
    const orderItemValues = items.map(i => [orderResult.insertId, i.food_id, i.name, i.price, i.quantity, i.note]);
    await connection.query(
      'INSERT INTO order_items (order_id, food_id, food_name, food_price, quantity, note) VALUES ?',
      [orderItemValues]
    );

    // Xoá giỏ hàng
    await connection.query('DELETE FROM cart_items WHERE cart_id = ?', [cart[0].id]);

    await connection.commit();
    res.status(201).json({ message: 'Đặt hàng thành công', orderId: orderResult.insertId, total });
  } catch (err) {
    await connection.rollback();
    res.status(500).json({ message: 'Lỗi đặt hàng', error: err.message });
  } finally {
    connection.release();
  }
});

// Lấy danh sách đơn hàng của user
router.get('/', async (req, res) => {
  try {
    const [rows] = await db.query(
      `SELECT o.*, r.name AS restaurant_name
       FROM orders o
       JOIN restaurants r ON o.restaurant_id = r.id
       WHERE o.user_id = ?
       ORDER BY o.ordered_at DESC`,
      [req.user.id]
    );
    res.json(rows);
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

// Chi tiết 1 đơn hàng
router.get('/:id', async (req, res) => {
  try {
    const [order] = await db.query(
      `SELECT o.*, r.name AS restaurant_name
       FROM orders o
       JOIN restaurants r ON o.restaurant_id = r.id
       WHERE o.id = ? AND o.user_id = ?`,
      [req.params.id, req.user.id]
    );
    if (order.length === 0) return res.status(404).json({ message: 'Không tìm thấy đơn hàng' });

    const [items] = await db.query('SELECT * FROM order_items WHERE order_id = ?', [req.params.id]);

    res.json({ ...order[0], items });
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

// Huỷ đơn hàng (chỉ khi pending)
router.put('/:id/cancel', async (req, res) => {
  try {
    const [result] = await db.query(
      "UPDATE orders SET status = 'cancelled' WHERE id = ? AND user_id = ? AND status = 'pending'",
      [req.params.id, req.user.id]
    );
    if (result.affectedRows === 0) {
      return res.status(400).json({ message: 'Không thể huỷ đơn hàng này' });
    }
    res.json({ message: 'Đã huỷ đơn hàng' });
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

module.exports = router;
