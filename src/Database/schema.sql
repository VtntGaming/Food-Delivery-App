-- ============================================================
-- FILE: schema.sql
-- Cấu trúc database cho ứng dụng Quản lý Đặt Đồ Ăn
-- Có thể chạy nhiều lần mà không lỗi (idempotent)
-- ============================================================

CREATE DATABASE IF NOT EXISTS food_ordering_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE food_ordering_db;

-- ============================================================
-- 1. USERS - Người dùng
-- ============================================================
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  phone VARCHAR(20) DEFAULT NULL,
  avatar_url VARCHAR(500) DEFAULT NULL,
  role ENUM('customer', 'restaurant_owner', 'admin') NOT NULL DEFAULT 'customer',
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uq_users_email (email)
) ENGINE=InnoDB;

-- ============================================================
-- 2. ADDRESSES - Địa chỉ giao hàng
-- ============================================================
CREATE TABLE IF NOT EXISTS addresses (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  label VARCHAR(50) DEFAULT 'Nhà',        -- Nhà, Công ty, Khác...
  address_line VARCHAR(255) NOT NULL,
  ward VARCHAR(100) DEFAULT NULL,
  district VARCHAR(100) DEFAULT NULL,
  city VARCHAR(100) DEFAULT NULL,
  latitude DECIMAL(10, 7) DEFAULT NULL,
  longitude DECIMAL(10, 7) DEFAULT NULL,
  is_default TINYINT(1) NOT NULL DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
-- 3. RESTAURANTS - Nhà hàng / Quán ăn
-- ============================================================
CREATE TABLE IF NOT EXISTS restaurants (
  id INT AUTO_INCREMENT PRIMARY KEY,
  owner_id INT DEFAULT NULL,
  name VARCHAR(200) NOT NULL,
  description TEXT DEFAULT NULL,
  phone VARCHAR(20) DEFAULT NULL,
  address VARCHAR(255) DEFAULT NULL,
  image_url VARCHAR(500) DEFAULT NULL,
  rating DECIMAL(2,1) DEFAULT 0.0,
  is_open TINYINT(1) NOT NULL DEFAULT 1,
  open_time TIME DEFAULT '07:00:00',
  close_time TIME DEFAULT '22:00:00',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (owner_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- ============================================================
-- 4. CATEGORIES - Danh mục món ăn
-- ============================================================
CREATE TABLE IF NOT EXISTS categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  image_url VARCHAR(500) DEFAULT NULL,
  sort_order INT DEFAULT 0,
  UNIQUE KEY uq_categories_name (name)
) ENGINE=InnoDB;

-- ============================================================
-- 5. FOODS - Món ăn
-- ============================================================
CREATE TABLE IF NOT EXISTS foods (
  id INT AUTO_INCREMENT PRIMARY KEY,
  restaurant_id INT NOT NULL,
  category_id INT DEFAULT NULL,
  name VARCHAR(200) NOT NULL,
  description TEXT DEFAULT NULL,
  price DECIMAL(12, 0) NOT NULL DEFAULT 0,       -- VND, không cần thập phân
  image_url VARCHAR(500) DEFAULT NULL,
  is_available TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) ON DELETE CASCADE,
  FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- ============================================================
-- 6. CARTS - Giỏ hàng (mỗi user 1 giỏ)
-- ============================================================
CREATE TABLE IF NOT EXISTS carts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uq_carts_user (user_id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
-- 7. CART_ITEMS - Chi tiết giỏ hàng
-- ============================================================
CREATE TABLE IF NOT EXISTS cart_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cart_id INT NOT NULL,
  food_id INT NOT NULL,
  quantity INT NOT NULL DEFAULT 1,
  note VARCHAR(255) DEFAULT NULL,
  UNIQUE KEY uq_cart_food (cart_id, food_id),
  FOREIGN KEY (cart_id) REFERENCES carts(id) ON DELETE CASCADE,
  FOREIGN KEY (food_id) REFERENCES foods(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
-- 8. PROMOCODES - Mã giảm giá
-- ============================================================
CREATE TABLE IF NOT EXISTS promocodes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  code VARCHAR(50) NOT NULL,
  description VARCHAR(255) DEFAULT NULL,
  discount_type ENUM('percent', 'fixed') NOT NULL DEFAULT 'percent',
  discount_value DECIMAL(12, 0) NOT NULL DEFAULT 0, -- % hoặc VND
  min_order_amount DECIMAL(12, 0) DEFAULT 0,
  max_discount DECIMAL(12, 0) DEFAULT NULL,          -- giới hạn giảm tối đa (cho %)
  usage_limit INT DEFAULT NULL,                       -- NULL = không giới hạn
  used_count INT NOT NULL DEFAULT 0,
  start_date DATE DEFAULT NULL,
  end_date DATE DEFAULT NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_promocodes_code (code)
) ENGINE=InnoDB;

-- ============================================================
-- 9. ORDERS - Đơn hàng
-- ============================================================
CREATE TABLE IF NOT EXISTS orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  restaurant_id INT NOT NULL,
  address_id INT DEFAULT NULL,
  promocode_id INT DEFAULT NULL,
  status ENUM('pending', 'confirmed', 'preparing', 'delivering', 'delivered', 'cancelled') NOT NULL DEFAULT 'pending',
  subtotal DECIMAL(12, 0) NOT NULL DEFAULT 0,
  discount_amount DECIMAL(12, 0) NOT NULL DEFAULT 0,
  delivery_fee DECIMAL(12, 0) NOT NULL DEFAULT 0,
  total DECIMAL(12, 0) NOT NULL DEFAULT 0,
  payment_method ENUM('cash', 'momo', 'zalopay', 'bank_transfer') NOT NULL DEFAULT 'cash',
  note TEXT DEFAULT NULL,
  ordered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  delivered_at TIMESTAMP NULL DEFAULT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) ON DELETE CASCADE,
  FOREIGN KEY (address_id) REFERENCES addresses(id) ON DELETE SET NULL,
  FOREIGN KEY (promocode_id) REFERENCES promocodes(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- ============================================================
-- 10. ORDER_ITEMS - Chi tiết đơn hàng
-- ============================================================
CREATE TABLE IF NOT EXISTS order_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  food_id INT NOT NULL,
  food_name VARCHAR(200) NOT NULL,      -- lưu snapshot tên tại thời điểm đặt
  food_price DECIMAL(12, 0) NOT NULL,   -- lưu snapshot giá tại thời điểm đặt
  quantity INT NOT NULL DEFAULT 1,
  note VARCHAR(255) DEFAULT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
  FOREIGN KEY (food_id) REFERENCES foods(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
-- 11. FAVORITES - Yêu thích
-- ============================================================
CREATE TABLE IF NOT EXISTS favorites (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  food_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_favorites (user_id, food_id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (food_id) REFERENCES foods(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
-- 12. REVIEWS - Đánh giá
-- ============================================================
CREATE TABLE IF NOT EXISTS reviews (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  restaurant_id INT NOT NULL,
  order_id INT DEFAULT NULL,
  rating TINYINT NOT NULL DEFAULT 5,    -- 1-5 sao
  comment TEXT DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) ON DELETE CASCADE,
  FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- ============================================================
-- 13. NOTIFICATIONS - Thông báo
-- ============================================================
CREATE TABLE IF NOT EXISTS notifications (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  title VARCHAR(200) NOT NULL,
  body TEXT DEFAULT NULL,
  type ENUM('order', 'promo', 'system') NOT NULL DEFAULT 'system',
  is_read TINYINT(1) NOT NULL DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
-- INDEX bổ sung để query nhanh hơn
-- ============================================================
-- Chỉ tạo index nếu chưa tồn tại (dùng procedure để kiểm tra)

DELIMITER $$

DROP PROCEDURE IF EXISTS add_index_if_not_exists$$

CREATE PROCEDURE add_index_if_not_exists(
  IN p_table VARCHAR(64),
  IN p_index VARCHAR(64),
  IN p_sql TEXT
)
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.statistics
    WHERE table_schema = DATABASE()
      AND table_name = p_table
      AND index_name = p_index
  ) THEN
    SET @ddl = p_sql;
    PREPARE stmt FROM @ddl;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END IF;
END$$

DELIMITER ;

CALL add_index_if_not_exists('foods', 'idx_foods_restaurant', 'CREATE INDEX idx_foods_restaurant ON foods(restaurant_id)');
CALL add_index_if_not_exists('foods', 'idx_foods_category', 'CREATE INDEX idx_foods_category ON foods(category_id)');
CALL add_index_if_not_exists('orders', 'idx_orders_user', 'CREATE INDEX idx_orders_user ON orders(user_id)');
CALL add_index_if_not_exists('orders', 'idx_orders_restaurant', 'CREATE INDEX idx_orders_restaurant ON orders(restaurant_id)');
CALL add_index_if_not_exists('orders', 'idx_orders_status', 'CREATE INDEX idx_orders_status ON orders(status)');
CALL add_index_if_not_exists('order_items', 'idx_order_items_order', 'CREATE INDEX idx_order_items_order ON order_items(order_id)');
CALL add_index_if_not_exists('reviews', 'idx_reviews_restaurant', 'CREATE INDEX idx_reviews_restaurant ON reviews(restaurant_id)');
CALL add_index_if_not_exists('notifications', 'idx_notifications_user', 'CREATE INDEX idx_notifications_user ON notifications(user_id)');

DROP PROCEDURE IF EXISTS add_index_if_not_exists;

SELECT 'Schema created / updated successfully!' AS result;
