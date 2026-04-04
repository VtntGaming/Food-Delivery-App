import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tổng quan hệ thống',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _buildSummaryCard('Người dùng', '1,234', Icons.people, Colors.blue)),
              const SizedBox(width: 16),
              Expanded(child: _buildSummaryCard('Nhà hàng', '56', Icons.restaurant, Colors.orange)),
              const SizedBox(width: 16),
              Expanded(child: _buildSummaryCard('Đơn hôm nay', '320', Icons.shopping_bag, Colors.green)),
            ],
          ),
          const SizedBox(height: 30),
          const Text(
            'Thống kê đơn theo thời gian',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Container(
             height: 300,
             padding: const EdgeInsets.all(16),
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(12),
               boxShadow: [
                 BoxShadow(
                   color: Colors.black.withValues(alpha: 0.05),
                   blurRadius: 10,
                 )
               ]
             ),
             child: LineChart(
               LineChartData(
                 gridData: const FlGridData(show: true),
                 titlesData: FlTitlesData(
                   bottomTitles: AxisTitles(
                     sideTitles: SideTitles(
                       showTitles: true,
                       getTitlesWidget: (value, meta) {
                         const days = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
                         if (value.toInt() >= 0 && value.toInt() < days.length) {
                           return Padding(
                             padding: const EdgeInsets.only(top: 8.0),
                             child: Text(days[value.toInt()]),
                           );
                         }
                         return const Text('');
                       },
                       interval: 1,
                     ),
                   ),
                   leftTitles: const AxisTitles(
                     sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                   ),
                   topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                   rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                 ),
                 borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey.shade300)),
                 lineBarsData: [
                   LineChartBarData(
                     spots: const [
                       FlSpot(0, 120),
                       FlSpot(1, 210),
                       FlSpot(2, 180),
                       FlSpot(3, 300),
                       FlSpot(4, 250),
                       FlSpot(5, 400),
                       FlSpot(6, 320),
                     ],
                     isCurved: true,
                     color: Colors.blue,
                     barWidth: 4,
                     isStrokeCapRound: true,
                     belowBarData: BarAreaData(
                       show: true,
                       color: Colors.blue.withValues(alpha: 0.2),
                     ),
                   ),
                 ],
               ),
             ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 30, color: color),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
