const router = require('express').Router();
const db = require('../config/db');
const { verifyToken } = require('../middleware/auth');

// Kiểm tra mã giảm giá có hợp lệ không
router.post('/validate', verifyToken, async (req, res) => {
  try {
    const { code, subtotal } = req.body;

    const [rows] = await db.query(
      `SELECT * FROM promocodes WHERE code = ? AND is_active = 1
       AND (start_date IS NULL OR start_date <= CURDATE())
       AND (end_date IS NULL OR end_date >= CURDATE())
       AND (usage_limit IS NULL OR used_count < usage_limit)`,
      [code]
    );

    if (rows.length === 0) {
      return res.status(400).json({ valid: false, message: 'Mã giảm giá không hợp lệ hoặc đã hết hạn' });
    }

    const pc = rows[0];
    if (subtotal < pc.min_order_amount) {
      return res.status(400).json({
        valid: false,
        message: `Đơn hàng tối thiểu ${pc.min_order_amount.toLocaleString()}đ để sử dụng mã này`
      });
    }

    let discount = 0;
    if (pc.discount_type === 'percent') {
      discount = Math.floor(subtotal * pc.discount_value / 100);
      if (pc.max_discount && discount > pc.max_discount) discount = pc.max_discount;
    } else {
      discount = pc.discount_value;
    }

    res.json({
      valid: true,
      code: pc.code,
      description: pc.description,
      discount_amount: discount,
    });
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

// Lấy danh sách mã đang hoạt động (public)
router.get('/active', async (req, res) => {
  try {
    const [rows] = await db.query(
      `SELECT code, description, discount_type, discount_value, min_order_amount, max_discount, end_date
       FROM promocodes
       WHERE is_active = 1
         AND (start_date IS NULL OR start_date <= CURDATE())
         AND (end_date IS NULL OR end_date >= CURDATE())
         AND (usage_limit IS NULL OR used_count < usage_limit)
       ORDER BY end_date`
    );
    res.json(rows);
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

module.exports = router;
