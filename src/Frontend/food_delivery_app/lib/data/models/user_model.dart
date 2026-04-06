/// Represents the current user session data.
class UserModel {
  final String id;
  final String name;
  final String avatarUrl;
  final String address;

  const UserModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.address,
  });

  static const UserModel mockUser = UserModel(
    id: '1',
    name: 'Lê Thanh Lộc',
    avatarUrl: 'assets/images/avatar.png',
    address: 'D1/6 đường 385, phường Tăng Nhơn Phú A, Quận 9, TP.HCM',
  );
}
