# 🍔 Food Delivery App — Ứng Dụng Đặt Đồ Ăn

> **Môn học:** Công Cụ Phát Triển Phần Mềm

## Giới thiệu

Ứng dụng quản lý đặt đồ ăn trực tuyến cho phép khách hàng duyệt nhà hàng, chọn món, đặt hàng và thanh toán. Hỗ trợ nhiều vai trò: **Customer**, **Restaurant Owner** và **Admin**.

## Công nghệ & Công cụ sử dụng

| Công cụ / Công nghệ | Mục đích |
|---|---|
| **Figma** | Thiết kế UI/UX |
| **Trello** | Quản lý công việc & tiến độ |
| **Node.js + Express** | Backend REST API |
| **Flutter** | Frontend ứng dụng di động |
| **MySQL 8.0** | Cơ sở dữ liệu |
| **JWT** | Xác thực người dùng |
| **Git & GitHub** | Quản lý mã nguồn |

## Cấu trúc dự án

```
Food-Delivery-App/
├── README.md
├── Docs/
│   └── huong_dan_build_project.txt   # Hướng dẫn build chi tiết
├── src/
│   ├── Database/
│   │   ├── schema.sql                # Cấu trúc database
│   │   └── seed_data.sql             # Dữ liệu mẫu
│   ├── Backend/                      # Node.js + Express API
│   │   ├── server.js
│   │   ├── .env
│   │   ├── config/
│   │   │   └── db.js
│   │   ├── middleware/
│   │   │   └── auth.js
│   │   └── routes/
│   │       ├── auth.routes.js
│   │       ├── user.routes.js
│   │       ├── restaurant.routes.js
│   │       ├── category.routes.js
│   │       ├── food.routes.js
│   │       ├── cart.routes.js
│   │       ├── order.routes.js
│   │       ├── address.routes.js
│   │       ├── favorite.routes.js
│   │       ├── review.routes.js
│   │       ├── notification.routes.js
│   │       └── promocode.routes.js
│   └── Frontend/                     # Flutter mobile app
└── ...
```

## Database Schema

Gồm **13 bảng** chính:

| Bảng | Mô tả |
|---|---|
| `users` | Người dùng (customer, restaurant_owner, admin) |
| `addresses` | Địa chỉ giao hàng |
| `restaurants` | Nhà hàng / Quán ăn |
| `categories` | Danh mục món ăn |
| `foods` | Món ăn |
| `carts` | Giỏ hàng |
| `cart_items` | Chi tiết giỏ hàng |
| `promocodes` | Mã giảm giá |
| `orders` | Đơn hàng |
| `order_items` | Chi tiết đơn hàng |
| `favorites` | Món ăn yêu thích |
| `reviews` | Đánh giá nhà hàng |
| `notifications` | Thông báo |

## Tính năng chính

- Đăng ký / Đăng nhập (JWT Authentication)
- Quản lý nhà hàng & danh mục món ăn
- Tìm kiếm & duyệt món ăn
- Giỏ hàng & đặt hàng
- Mã giảm giá (Promocode)
- Quản lý địa chỉ giao hàng
- Đánh giá & yêu thích
- Thông báo đơn hàng
- Thanh toán (Cash, MoMo, ZaloPay, Bank Transfer)

## Yêu cầu cài đặt

- **Node.js** >= 18.x
- **MySQL** >= 8.0
- **Flutter** SDK
- **VS Code** (khuyến nghị)

## Hướng dẫn chạy

Chi tiết tham khảo file [`Docs/huong_dan_build_project.txt`](Docs/huong_dan_build_project.txt).

**Tóm tắt nhanh:**

```bash
# 1. Setup Database
mysql -u root -p < src/Database/schema.sql
mysql -u root -p < src/Database/seed_data.sql

# 2. Chạy Backend
cd src/Backend
npm install
npm start

# 3. Chạy Frontend (Flutter)
cd src/Frontend
flutter pub get
flutter run
```

## Quy tắc làm việc nhóm (Git Workflow)

- Tạo nhánh theo format: `feature-<featureName>`
- Tạo PR vào nhánh **develop**, **KHÔNG TẠO PR VÀO MAIN**
- Không tự merge vào nhánh không phải của mình
- Có thể tạo nhiều nhánh, nhưng lưu ý nhớ kỹ nhánh của mình
- Xoá nhánh nếu không còn sử dụng
