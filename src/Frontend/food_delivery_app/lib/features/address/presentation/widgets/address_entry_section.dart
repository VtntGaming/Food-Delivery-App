import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/text_style_scaler.dart';
import '../../domain/entities/address_entity.dart';
import 'address_contact_row.dart';

class AddressEntrySection extends StatelessWidget {
  const AddressEntrySection({
    super.key,
    required this.address,
    required this.isSelected,
    required this.onTap,
  });

  final AddressEntity address;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scale = AppDimensions.scaleFor(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: AddressContactRow(
            name: address.fullName,
            phone: address.phone,
            isSelected: isSelected,
          ),
        ),
        SizedBox(height: AppDimensions.s(context, 12)),
        Padding(
          padding: EdgeInsets.only(left: AppDimensions.s(context, 8)),
          child: Text(
            address.addressLine,
            style: scaleTextStyle(AppTextStyles.addressLine, scale),
          ),
        ),
      ],
    );
  }
}
