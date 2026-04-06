const router = require('express').Router();
const db = require('../config/db');
const { verifyToken } = require('../middleware/auth');

// Lấy tất cả món (có search)
router.get('/', async (req, res) => {
  try {
    const { search, category_id, restaurant_id } = req.query;
    let sql = `SELECT f.*, r.name AS restaurant_name, c.name AS category_name
               FROM foods f
               JOIN restaurants r ON f.restaurant_id = r.id
               LEFT JOIN categories c ON f.category_id = c.id
               WHERE f.is_available = 1`;
    const params = [];

    if (search) {
      sql += ' AND f.name LIKE ?';
      params.push(`%${search}%`);
    }
    if (category_id) {
      sql += ' AND f.category_id = ?';
      params.push(category_id);
    }
    if (restaurant_id) {
      sql += ' AND f.restaurant_id = ?';
      params.push(restaurant_id);
    }

    sql += ' ORDER BY f.name';
    const [rows] = await db.query(sql, params);
    res.json(rows);
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

// Lấy chi tiết 1 món
router.get('/:id', async (req, res) => {
  try {
    const [rows] = await db.query(
      `SELECT f.*, r.name AS restaurant_name, c.name AS category_name
       FROM foods f
       JOIN restaurants r ON f.restaurant_id = r.id
       LEFT JOIN categories c ON f.category_id = c.id
       WHERE f.id = ?`,
      [req.params.id]
    );
    if (rows.length === 0) return res.status(404).json({ message: 'Không tìm thấy món ăn' });
    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

// Thêm món ăn (chủ nhà hàng)
router.post('/', verifyToken, async (req, res) => {
  try {
    const { restaurant_id, category_id, name, description, price, image_url } = req.body;
    const [result] = await db.query(
      'INSERT INTO foods (restaurant_id, category_id, name, description, price, image_url) VALUES (?, ?, ?, ?, ?, ?)',
      [restaurant_id, category_id, name, description, price, image_url]
    );
    res.status(201).json({ message: 'Thêm món thành công', foodId: result.insertId });
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

// Cập nhật món ăn
router.put('/:id', verifyToken, async (req, res) => {
  try {
    const { category_id, name, description, price, image_url, is_available } = req.body;
    await db.query(
      `UPDATE foods SET
        category_id = COALESCE(?, category_id),
        name = COALESCE(?, name),
        description = COALESCE(?, description),
        price = COALESCE(?, price),
        image_url = COALESCE(?, image_url),
        is_available = COALESCE(?, is_available)
      WHERE id = ?`,
      [category_id, name, description, price, image_url, is_available, req.params.id]
    );
    res.json({ message: 'Cập nhật món ăn thành công' });
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

// Xoá món ăn
router.delete('/:id', verifyToken, async (req, res) => {
  try {
    await db.query('DELETE FROM foods WHERE id = ?', [req.params.id]);
    res.json({ message: 'Xoá món ăn thành công' });
  } catch (err) {
    res.status(500).json({ message: 'Lỗi server', error: err.message });
  }
});

module.exports = router;
