import 'package:flutter/material.dart';
import '../config/theme/app_theme.dart';
import '../models/order_model.dart';
import '../widgets/common_widgets.dart';

class OrderDetailScreen extends StatefulWidget {
  final OrderDetail orderDetail;

  const OrderDetailScreen({
    Key? key,
    required this.orderDetail,
  }) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(
      text: widget.orderDetail.order.deliveryNote ?? '',
    );
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _onRateOrder() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Điều hướng tới màn hình đánh giá')),
    );
  }

  void _onReOrder() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đặt lại đơn hàng')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.orderDetail.order;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        children: [
          AppHeader(
            title: 'Chi tiết đơn hàng',
            onBackPressed: () => Navigator.of(context).pop(),
            trailing: SizedBox.shrink(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildOrderIdSection(order),
                  const SizedBox(height: AppTheme.spacingL),
                  _buildDeliveryAddressSection(),
                  const SizedBox(height: AppTheme.spacingL),
                  _buildOrderItemsSection(order),
                  const SizedBox(height: AppTheme.spacingL),
                  _buildPriceSummarySection(order),
                  const SizedBox(height: AppTheme.spacingL),
                  _buildNoteSection(),
                  const SizedBox(height: AppTheme.spacingL),
                  _buildActionButtonsSection(),
                  const SizedBox(height: AppTheme.spacingL),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderIdSection(Order order) {
    return Container(
      margin: const EdgeInsets.all(AppTheme.spacingM),
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'ID Đơn hàng: ',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.errorColor,
                    fontFamily: 'Inter',
                  ),
                ),
                TextSpan(
                  text: order.id,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spacingM),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Giao đến:',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textSecondary,
                        fontFamily: 'BeVietnamPro',
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXS),
                    Text(
                      widget.orderDetail.location,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textPrimary,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Thêm địa chỉ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textSecondary,
                    fontFamily: 'BeVietnamPro',
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryAddressSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: AppTheme.primaryColor,
                size: AppTheme.iconSizeL,
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.orderDetail.location,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXS),
                    Text(
                      widget.orderDetail.recipientName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textSecondary,
                        fontFamily: 'BeVietnamPro',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingM),
          Row(
            children: [
              const Icon(
                Icons.phone,
                color: AppTheme.primaryColor,
                size: AppTheme.iconSizeL,
              ),
              const SizedBox(width: AppTheme.spacingM),
              Text(
                widget.orderDetail.recipientPhone,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItemsSection(Order order) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppTheme.radiusS),
                child: Container(
                  width: 80,
                  height: 80,
                  color: AppTheme.dividerColor,
                  child: const Icon(
                    Icons.restaurant,
                    color: AppTheme.textHint,
                    size: AppTheme.iconSizeL,
                  ),
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tên đơn hàng: ${order.restaurantName}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                        fontFamily: 'BeVietnamPro',
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppTheme.spacingXS),
                    Text(
                      'Mô tả: ${order.description ?? "N/A"}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textSecondary,
                        fontFamily: 'BeVietnamPro',
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingM),
          Divider(
            thickness: 1,
            color: AppTheme.dividerColor,
          ),
          const SizedBox(height: AppTheme.spacingM),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Thời gian giao: ${widget.orderDetail.deliveryTime}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textSecondary,
                  fontFamily: 'BeVietnamPro',
                ),
              ),
              Text(
                widget.orderDetail.deliveryDate.toString().split(' ')[0],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSummarySection(Order order) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
      ),
      child: Column(
        children: [
          PriceInfoRow(
            label: 'Giá tiền:',
            value: '${order.foodPrice.toStringAsFixed(0)}VND',
          ),
          const SizedBox(height: AppTheme.spacingM),
          PriceInfoRow(
            label: 'Phí ship:',
            value: '${order.shippingFee.toStringAsFixed(0)}VND',
          ),
          const SizedBox(height: AppTheme.spacingM),
          PriceInfoRow(
            label: 'Tổng tiền:',
            value: order.formattedPrice,
            isHighlight: true,
          ),
        ],
      ),
    );
  }

  Widget _buildNoteSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ghi chú:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: AppTheme.spacingS),
          NoteTextField(
            hint: 'Ghi chú tại đây......',
            onChanged: (value) {},
            controller: _noteController,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtonsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: _onRateOrder,
              child: const Text('Đánh giá'),
            ),
          ),
          const SizedBox(width: AppTheme.spacingM),
          Expanded(
            child: ElevatedButton(
              onPressed: _onReOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentColor,
              ),
              child: const Text('Đặt lại'),
            ),
          ),
        ],
      ),
    );
  }
}
