import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../constants/address_page_texts.dart';
import '../controllers/address_page_controller.dart';
import '../widgets/add_new_address_tile.dart';
import '../widgets/address_entry_section.dart';
import '../widgets/address_header.dart';
import '../widgets/address_search_bar.dart';
import '../widgets/bottom_confirm_button.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key, required this.controller});

  final AddressPageController controller;

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  void initState() {
    super.initState();
    widget.controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: Column(
            children: [
              AddressHeader(
                title: AddressPageTexts.title,
                onBack: () => Navigator.of(context).maybePop(),
              ),
              Expanded(
                child: widget.controller.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      )
                    : _AddressBody(controller: widget.controller),
              ),
              BottomConfirmButton(
                label: AddressPageTexts.confirm,
                onPressed: widget.controller.confirmSelection,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AddressBody extends StatelessWidget {
  const _AddressBody({required this.controller});

  final AddressPageController controller;

  @override
  Widget build(BuildContext context) {
    final addresses = controller.addresses;

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        AppDimensions.s(context, AppDimensions.horizontalPadding),
        AppDimensions.s(context, 12),
        AppDimensions.s(context, AppDimensions.horizontalPadding),
        AppDimensions.s(context, AppDimensions.largeSpacing),
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AddressSearchBar(label: AddressPageTexts.searchHint),
              SizedBox(
                height: AppDimensions.s(context, AppDimensions.mediumSpacing),
              ),
              for (var i = 0; i < addresses.length; i++) ...[
                AddressEntrySection(
                  address: addresses[i],
                  isSelected: controller.selectedAddressId == addresses[i].id,
                  onTap: () => controller.selectAddress(addresses[i].id),
                ),
                if (i != addresses.length - 1)
                  SizedBox(height: AppDimensions.s(context, 20)),
              ],
              SizedBox(height: AppDimensions.s(context, 42)),
              AddNewAddressTile(
                label: AddressPageTexts.addNewAddress,
                onTap: controller.addNewAddress,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
