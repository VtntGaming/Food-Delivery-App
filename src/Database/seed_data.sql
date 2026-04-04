-- ============================================================
-- FILE: seed_data.sql
-- Dữ liệu mẫu cho ứng dụng Quản lý Đặt Đồ Ăn
-- Có thể chạy nhiều lần mà không lỗi (INSERT IGNORE / ON DUPLICATE KEY)
-- ============================================================

USE food_ordering_db;

-- ============================================================
-- 1. USERS
-- Password mẫu: "123456" (đã hash bcrypt)
-- Hash: $2b$10$XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
-- Trong thực tế bạn sẽ hash bằng bcrypt trong Node.js
-- ============================================================
INSERT INTO users (id, full_name, email, password_hash, phone, role) VALUES
  (1, 'Nguyễn Văn An',     'an.nguyen@gmail.com',     '$2b$10$abcdefghijklmnopqrstuuABCDEFGHIJKLMNOPQRSTUVWXYZ12345', '0901000001', 'customer'),
  (2, 'Trần Thị Bình',     'binh.tran@gmail.com',     '$2b$10$abcdefghijklmnopqrstuuABCDEFGHIJKLMNOPQRSTUVWXYZ12345', '0901000002', 'customer'),
  (3, 'Lê Minh Châu',      'chau.le@gmail.com',       '$2b$10$abcdefghijklmnopqrstuuABCDEFGHIJKLMNOPQRSTUVWXYZ12345', '0901000003', 'customer'),
  (4, 'Phạm Đức Dũng',     'dung.pham@gmail.com',     '$2b$10$abcdefghijklmnopqrstuuABCDEFGHIJKLMNOPQRSTUVWXYZ12345', '0901000004', 'restaurant_owner'),
  (5, 'Hoàng Thị Em',      'em.hoang@gmail.com',      '$2b$10$abcdefghijklmnopqrstuuABCDEFGHIJKLMNOPQRSTUVWXYZ12345', '0901000005', 'restaurant_owner'),
  (6, 'Admin Hệ Thống',    'admin@foodapp.com',       '$2b$10$abcdefghijklmnopqrstuuABCDEFGHIJKLMNOPQRSTUVWXYZ12345', '0900000000', 'admin')
ON DUPLICATE KEY UPDATE full_name = VALUES(full_name), phone = VALUES(phone), role = VALUES(role);

-- ============================================================
-- 2. ADDRESSES
-- ============================================================
INSERT INTO addresses (id, user_id, label, address_line, ward, district, city, is_default) VALUES
  (1, 1, 'Nhà',     '123 Nguyễn Trãi',       'Phường 2',  'Quận 5',       'TP.HCM', 1),
  (2, 1, 'Công ty', '456 Lê Lợi',            'Phường 1',  'Quận 1',       'TP.HCM', 0),
  (3, 2, 'Nhà',     '789 Trần Hưng Đạo',     'Phường 7',  'Quận 5',       'TP.HCM', 1),
  (4, 3, 'Nhà',     '12 Phạm Ngũ Lão',       'Phường 3',  'Quận 1',       'TP.HCM', 1),
  (5, 3, 'Trường',  '268 Lý Thường Kiệt',    'Phường 14', 'Quận 10',      'TP.HCM', 0)
ON DUPLICATE KEY UPDATE address_line = VALUES(address_line);

-- ============================================================
-- 3. RESTAURANTS
-- ============================================================
INSERT INTO restaurants (id, owner_id, name, description, phone, address, image_url, rating, is_open) VALUES
  (1, 4, 'Phở Hà Nội 36',           'Phở bò truyền thống Hà Nội',                '0281000001', '36 Lê Thái Tổ, Q.Hoàn Kiếm, Hà Nội',   '/images/restaurants/pho36.jpg',      4.5, 1),
  (2, 4, 'Cơm Tấm Sài Gòn',        'Cơm tấm sườn bì chả ngon nức tiếng',        '0281000002', '84 Nguyễn Du, Q.1, TP.HCM',              '/images/restaurants/comtam.jpg',      4.3, 1),
  (3, 5, 'Bún Bò Huế Cô Ri',       'Bún bò Huế chuẩn vị miền Trung',            '0281000003', '18 Hai Bà Trưng, Q.1, TP.HCM',           '/images/restaurants/bunbo.jpg',       4.7, 1),
  (4, 5, 'Pizza & Burger House',     'Fast food kiểu Mỹ giá bình dân',            '0281000004', '99 Bùi Viện, Q.1, TP.HCM',               '/images/restaurants/pizza.jpg',       4.1, 1),
  (5, 4, 'Trà Sữa ToCoToCo',        'Trà sữa và đồ uống đa dạng',               '0281000005', '50 Nguyễn Huệ, Q.1, TP.HCM',             '/images/restaurants/trasua.jpg',      4.0, 1)
ON DUPLICATE KEY UPDATE name = VALUES(name), description = VALUES(description);

-- ============================================================
-- 4. CATEGORIES
-- ============================================================
INSERT INTO categories (id, name, image_url, sort_order) VALUES
  (1, 'Cơm',         '/images/categories/com.jpg',       1),
  (2, 'Phở & Bún',   '/images/categories/pho.jpg',       2),
  (3, 'Đồ ăn nhanh', '/images/categories/fastfood.jpg',  3),
  (4, 'Đồ uống',     '/images/categories/drink.jpg',     4),
  (5, 'Món tráng miệng', '/images/categories/dessert.jpg', 5),
  (6, 'Món chay',     '/images/categories/chay.jpg',      6)
ON DUPLICATE KEY UPDATE name = VALUES(name), sort_order = VALUES(sort_order);

-- ============================================================
-- 5. FOODS
-- ============================================================
INSERT INTO foods (id, restaurant_id, category_id, name, description, price, image_url, is_available) VALUES
  -- Phở Hà Nội 36
  (1,  1, 2, 'Phở bò tái',           'Phở bò tái truyền thống với nước dùng ninh xương',  45000,  '/images/foods/pho_bo_tai.jpg',      1),
  (2,  1, 2, 'Phở bò chín',          'Phở bò chín mềm thơm ngon',                         45000,  '/images/foods/pho_bo_chin.jpg',     1),
  (3,  1, 2, 'Phở gà',               'Phở gà ta thả vườn',                                 40000,  '/images/foods/pho_ga.jpg',          1),
  (4,  1, 4, 'Trà đá',               'Trà đá miễn phí',                                    0,      '/images/foods/tra_da.jpg',          1),

  -- Cơm Tấm Sài Gòn
  (5,  2, 1, 'Cơm tấm sườn',         'Cơm tấm sườn nướng than hồng',                      35000,  '/images/foods/comtam_suon.jpg',     1),
  (6,  2, 1, 'Cơm tấm sườn bì chả', 'Cơm tấm đầy đủ sườn bì chả trứng',                  50000,  '/images/foods/comtam_sbc.jpg',      1),
  (7,  2, 1, 'Cơm tấm bì',          'Cơm tấm bì đơn giản',                                30000,  '/images/foods/comtam_bi.jpg',       1),
  (8,  2, 4, 'Nước ngọt lon',        'Coca / Pepsi / 7Up',                                  15000,  '/images/foods/nuoc_ngot.jpg',       1),

  -- Bún Bò Huế Cô Ri
  (9,  3, 2, 'Bún bò Huế đặc biệt',  'Bún bò giò heo, chả cua, huyết',                   55000,  '/images/foods/bunbo_db.jpg',        1),
  (10, 3, 2, 'Bún bò Huế thường',     'Bún bò thịt bò viên',                               40000,  '/images/foods/bunbo_thuong.jpg',    1),
  (11, 3, 2, 'Bún chả Hà Nội',        'Bún chả với nước chấm chua ngọt',                   45000,  '/images/foods/buncha.jpg',          1),

  -- Pizza & Burger House
  (12, 4, 3, 'Pizza Margherita',       'Pizza cà chua, phô mai mozzarella',                 89000,  '/images/foods/pizza_mar.jpg',       1),
  (13, 4, 3, 'Pizza Hải Sản',         'Pizza tôm, mực, nghêu',                              109000, '/images/foods/pizza_seafood.jpg',   1),
  (14, 4, 3, 'Burger Bò Phô Mai',     'Burger bò Úc với phô mai cheddar',                   65000,  '/images/foods/burger_cheese.jpg',   1),
  (15, 4, 3, 'Khoai Tây Chiên',       'Khoai tây chiên giòn kèm sốt',                      35000,  '/images/foods/fries.jpg',           1),

  -- Trà Sữa ToCoToCo
  (16, 5, 4, 'Trà sữa trân châu',     'Trà sữa trân châu đường đen',                      29000,  '/images/foods/trasua_tc.jpg',       1),
  (17, 5, 4, 'Trà đào cam sả',        'Trà đào thơm mát cam sả tươi',                      35000,  '/images/foods/tra_dao.jpg',         1),
  (18, 5, 4, 'Matcha đá xay',         'Matcha Nhật Bản đá xay kem',                         39000,  '/images/foods/matcha.jpg',          1),
  (19, 5, 5, 'Bánh flan',             'Bánh flan caramen mềm mịn',                          20000,  '/images/foods/flan.jpg',            1),
  (20, 5, 5, 'Chè bưởi',             'Chè bưởi nước cốt dừa',                              25000,  '/images/foods/che_buoi.jpg',        1)
ON DUPLICATE KEY UPDATE name = VALUES(name), price = VALUES(price), is_available = VALUES(is_available);

-- ============================================================
-- 6. CARTS (mỗi customer 1 giỏ)
-- ============================================================
INSERT INTO carts (id, user_id) VALUES
  (1, 1),
  (2, 2),
  (3, 3)
ON DUPLICATE KEY UPDATE updated_at = CURRENT_TIMESTAMP;

-- ============================================================
-- 7. CART_ITEMS (giỏ hàng mẫu cho user 1)
-- ============================================================
INSERT INTO cart_items (id, cart_id, food_id, quantity, note) VALUES
  (1, 1, 6,  1, 'Thêm trứng ốp la'),
  (2, 1, 8,  2, NULL)
ON DUPLICATE KEY UPDATE quantity = VALUES(quantity), note = VALUES(note);

-- ============================================================
-- 8. PROMOCODES
-- ============================================================
INSERT INTO promocodes (id, code, description, discount_type, discount_value, min_order_amount, max_discount, usage_limit, used_count, start_date, end_date, is_active) VALUES
  (1, 'WELCOME10',   'Giảm 10% cho khách mới',             'percent', 10,    50000,  30000,  1000, 42,  '2026-01-01', '2026-12-31', 1),
  (2, 'FREESHIP',    'Miễn phí giao hàng (giảm 15k)',      'fixed',   15000, 30000,  NULL,   500,  120, '2026-01-01', '2026-06-30', 1),
  (3, 'SALE20',      'Giảm 20% đơn từ 100k',               'percent', 20,    100000, 50000,  200,  5,   '2026-03-01', '2026-04-30', 1),
  (4, 'TET2026',     'Khuyến mãi Tết 2026 giảm 30k',       'fixed',   30000, 80000,  NULL,   300,  280, '2026-01-25', '2026-02-10', 0)
ON DUPLICATE KEY UPDATE description = VALUES(description), is_active = VALUES(is_active);

-- ============================================================
-- 9. ORDERS
-- ============================================================
INSERT INTO orders (id, user_id, restaurant_id, address_id, promocode_id, status, subtotal, discount_amount, delivery_fee, total, payment_method, note, ordered_at, delivered_at) VALUES
  (1, 1, 2, 1, 1, 'delivered',   50000,  5000,  15000, 60000,  'cash',          'Giao nhanh giùm',               '2026-03-20 12:30:00', '2026-03-20 13:15:00'),
  (2, 1, 1, 1, NULL, 'delivered', 90000,  0,     15000, 105000, 'momo',          NULL,                            '2026-03-22 18:00:00', '2026-03-22 18:40:00'),
  (3, 2, 3, 3, NULL, 'delivering', 55000, 0,     15000, 70000,  'zalopay',       'Ít cay',                        '2026-04-01 11:00:00', NULL),
  (4, 3, 4, 4, 3,   'preparing',  154000, 30800, 15000, 138200, 'bank_transfer', NULL,                            '2026-04-02 19:00:00', NULL),
  (5, 1, 5, 2, 2,   'pending',    64000,  15000, 15000, 64000,  'momo',          'Trà sữa ít đường',             '2026-04-03 09:00:00', NULL),
  (6, 2, 2, 3, NULL, 'cancelled', 35000,  0,     15000, 50000,  'cash',          'Tôi đổi ý',                    '2026-03-28 08:00:00', NULL)
ON DUPLICATE KEY UPDATE status = VALUES(status);

-- ============================================================
-- 10. ORDER_ITEMS
-- ============================================================
INSERT INTO order_items (id, order_id, food_id, food_name, food_price, quantity, note) VALUES
  -- Order 1: Cơm tấm sườn bì chả
  (1,  1, 6,  'Cơm tấm sườn bì chả',    50000, 1, NULL),
  -- Order 2: 2 Phở bò tái
  (2,  2, 1,  'Phở bò tái',              45000, 2, 'Nhiều hành'),
  -- Order 3: Bún bò đặc biệt
  (3,  3, 9,  'Bún bò Huế đặc biệt',    55000, 1, 'Ít cay'),
  -- Order 4: Pizza + Burger
  (4,  4, 12, 'Pizza Margherita',         89000, 1, NULL),
  (5,  4, 14, 'Burger Bò Phô Mai',       65000, 1, 'Không hành'),
  -- Order 5: Trà sữa
  (6,  5, 16, 'Trà sữa trân châu',       29000, 1, 'Ít đường'),
  (7,  5, 17, 'Trà đào cam sả',          35000, 1, NULL),
  -- Order 6: Cơm tấm sườn (đã huỷ)
  (8,  6, 5,  'Cơm tấm sườn',            35000, 1, NULL)
ON DUPLICATE KEY UPDATE quantity = VALUES(quantity);

-- ============================================================
-- 11. FAVORITES
-- ============================================================
INSERT INTO favorites (id, user_id, food_id) VALUES
  (1, 1, 1),    -- An thích Phở bò tái
  (2, 1, 6),    -- An thích Cơm tấm sườn bì chả
  (3, 1, 16),   -- An thích Trà sữa trân châu
  (4, 2, 9),    -- Bình thích Bún bò đặc biệt
  (5, 2, 17),   -- Bình thích Trà đào cam sả
  (6, 3, 12),   -- Châu thích Pizza Margherita
  (7, 3, 14)    -- Châu thích Burger Bò Phô Mai
ON DUPLICATE KEY UPDATE created_at = CURRENT_TIMESTAMP;

-- ============================================================
-- 12. REVIEWS
-- ============================================================
INSERT INTO reviews (id, user_id, restaurant_id, order_id, rating, comment) VALUES
  (1, 1, 2, 1, 5, 'Cơm tấm rất ngon, sườn nướng thơm lừng!'),
  (2, 1, 1, 2, 4, 'Phở bò tái ngon, nước dùng đậm đà. Giao hơi chậm.'),
  (3, 2, 3, 3, 5, 'Bún bò Huế ngon nhất Sài Gòn!'),
  (4, 3, 4, 4, 4, 'Pizza ngon, burger bò cũng ổn. Giá hợp lý.')
ON DUPLICATE KEY UPDATE rating = VALUES(rating), comment = VALUES(comment);

-- ============================================================
-- 13. NOTIFICATIONS
-- ============================================================
INSERT INTO notifications (id, user_id, title, body, type, is_read) VALUES
  (1,  1, 'Đơn hàng #1 đã giao',          'Cơm tấm Sài Gòn đã giao thành công. Chúc ngon miệng!',         'order',  1),
  (2,  1, 'Đơn hàng #2 đã giao',          'Phở Hà Nội 36 đã giao thành công.',                             'order',  1),
  (3,  2, 'Đơn hàng #3 đang giao',        'Shipper đang trên đường giao bún bò cho bạn.',                  'order',  0),
  (4,  3, 'Đơn hàng #4 đang chuẩn bị',    'Pizza & Burger House đang chuẩn bị món cho bạn.',               'order',  0),
  (5,  1, 'Mã giảm giá mới!',             'Dùng mã SALE20 để giảm 20% đơn từ 100k. Hết hạn 30/04.',       'promo',  0),
  (6,  2, 'Mã giảm giá mới!',             'Dùng mã SALE20 để giảm 20% đơn từ 100k. Hết hạn 30/04.',       'promo',  0),
  (7,  3, 'Mã giảm giá mới!',             'Dùng mã SALE20 để giảm 20% đơn từ 100k. Hết hạn 30/04.',       'promo',  0),
  (8,  1, 'Chào mừng bạn đến FoodApp!',   'Đặt đơn đầu tiên với mã WELCOME10 để giảm 10%.',               'system', 1),
  (9,  2, 'Chào mừng bạn đến FoodApp!',   'Đặt đơn đầu tiên với mã WELCOME10 để giảm 10%.',               'system', 1),
  (10, 3, 'Chào mừng bạn đến FoodApp!',   'Đặt đơn đầu tiên với mã WELCOME10 để giảm 10%.',               'system', 1)
ON DUPLICATE KEY UPDATE title = VALUES(title), body = VALUES(body);

SELECT 'Seed data inserted / updated successfully!' AS result;
