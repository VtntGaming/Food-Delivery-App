const router = require('express').Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const db = require('../config/db');

// ĐĂNG KÝ
router.post('/register', async (req, res) => {
  try {
    const { full_name, email, password, phone } = req.body;

    // Kiểm tra email đã tồn tại
    const [existing] = await db.query('SELECT id FROM users WHERE email = ?', [email]);
    if (existing.length > 0) {
      return res.status(400).json({ message: 'Email đã được sử dụng' });
    }

    // Hash password
    const salt = await bcrypt.genSalt(10);
    const password_hash = await bcrypt.hash(password, salt);

    // Insert user
    const [result] = await db.query(
      'INSERT INTO users (full_name, email, password_hash, phone) VALUES (?, ?, ?, ?)',
      [full_name, email, password_hash, phone || null]
    );

    // Tạo giỏ hàng cho user mới
    await db.query('INSERT INTO carts (user_id) VALUES (?)', [result.insertId]);

    res.status(201).json({ message: 'Đăng ký thành công', userId: result.insertId });
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

// ĐĂNG NHẬP
router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;

    const [users] = await db.query('SELECT * FROM users WHERE email = ?', [email]);
    if (users.length === 0) {
      return res.status(401).json({ message: 'Email hoặc mật khẩu sai' });
    }

    const user = users[0];
    if (!user.is_active) {
      return res.status(403).json({ message: 'Tài khoản đã bị khoá' });
    }

    const validPassword = await bcrypt.compare(password, user.password_hash);
    if (!validPassword) {
      return res.status(401).json({ message: 'Email hoặc mật khẩu sai' });
    }

    // Tạo token
    const token = jwt.sign(
      { id: user.id, email: user.email, role: user.role },
      process.env.JWT_SECRET,
      { expiresIn: process.env.JWT_EXPIRES_IN }
    );

    res.json({
      message: 'Đăng nhập thành công',
      token,
      user: {
        id: user.id,
        full_name: user.full_name,
        email: user.email,
        phone: user.phone,
        role: user.role,
        avatar_url: user.avatar_url,
      }
    });
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

module.exports = router;
