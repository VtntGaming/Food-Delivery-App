import 'package:flutter/material.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  final List<Map<String, String>> _users = [
    {'id': '1', 'name': 'Nguyễn Văn A', 'email': 'nguyenvana@gmail.com', 'role': 'Khách hàng'},
    {'id': '2', 'name': 'Lê Thị B', 'email': 'lethib@gmail.com', 'role': 'Chủ quán'},
    {'id': '3', 'name': 'Trần Văn C', 'email': 'tranvanc@gmail.com', 'role': 'Khách hàng'},
  ];

  String _searchQuery = '';

  void _deleteUser(String id) {
    setState(() {
      _users.removeWhere((user) => user['id'] == id);
    });
  }

  void _changeRole(String id, String newRole) {
    setState(() {
      final index = _users.indexWhere((user) => user['id'] == id);
      if (index != -1) {
        _users[index]['role'] = newRole;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredUsers = _users.where((user) {
      return user['name']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
             user['email']!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quản lý người dùng',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              hintText: 'Tìm kiếm theo tên hoặc email...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Card(
              color: Colors.white,
              elevation: 2,
              child: ListView.separated(
                itemCount: filteredUsers.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: user['role'] == 'Chủ quán' ? Colors.orange : Colors.blue,
                      child: Text(
                        user['name']![0],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(user['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${user['email']} • Vai trò: ${user['role']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PopupMenuButton<String>(
                          onSelected: (value) => _changeRole(user['id']!, value),
                          itemBuilder: (context) => [
                            const PopupMenuItem(value: 'Khách hàng', child: Text('Khách hàng')),
                            const PopupMenuItem(value: 'Chủ quán', child: Text('Chủ quán')),
                          ],
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          tooltip: 'Đổi vai trò',
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteUser(user['id']!),
                          tooltip: 'Xóa tài khoản',
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
