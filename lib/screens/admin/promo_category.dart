import 'package:flutter/material.dart';

class PromoCategoryScreen extends StatefulWidget {
  const PromoCategoryScreen({super.key});

  @override
  State<PromoCategoryScreen> createState() => _PromoCategoryScreenState();
}

class _PromoCategoryScreenState extends State<PromoCategoryScreen> {
  final List<Map<String, dynamic>> _promos = [
    {'id': '1', 'code': 'GIAM10K', 'value': 10000, 'expiry': '2026-12-31'},
    {'id': '2', 'code': 'FREESHIP', 'value': 15000, 'expiry': '2026-05-30'},
  ];

  final List<Map<String, dynamic>> _categories = [
    {'id': '1', 'name': 'Đồ ăn nhanh'},
    {'id': '2', 'name': 'Lẩu'},
    {'id': '3', 'name': 'Trà sữa'},
  ];

  void _addPromo() {
    setState(() {
      _promos.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'code': 'NEWPROMO${_promos.length}',
        'value': 20000,
        'expiry': '2026-12-31',
      });
    });
  }

  void _deletePromo(String id) {
    setState(() {
      _promos.removeWhere((promo) => promo['id'] == id);
    });
  }

  void _addCategory() {
    setState(() {
      _categories.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'name': 'Danh mục mới ${_categories.length}',
      });
    });
  }

  void _deleteCategory(String id) {
    setState(() {
      _categories.removeWhere((cat) => cat['id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Mã giảm giá'),
              Tab(text: 'Danh mục món ăn'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildPromoTab(),
                _buildCategoryTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Danh sách mã giảm giá',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: _addPromo,
                icon: const Icon(Icons.add),
                label: const Text('Thêm mới'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Card(
              color: Colors.white,
              child: ListView.separated(
                itemCount: _promos.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final promo = _promos[index];
                  return ListTile(
                    leading: const Icon(Icons.local_offer, color: Colors.green),
                    title: Text(promo['code']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Giảm: ${promo['value']} đ • HSD: ${promo['expiry']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deletePromo(promo['id']!),
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

  Widget _buildCategoryTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Danh sách danh mục',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: _addCategory,
                icon: const Icon(Icons.add),
                label: const Text('Thêm mới'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Card(
              color: Colors.white,
              child: ListView.separated(
                itemCount: _categories.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  return ListTile(
                    leading: const Icon(Icons.category, color: Colors.orange),
                    title: Text(cat['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteCategory(cat['id']!),
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
