import 'package:flutter/foundation.dart';

import '../../domain/entities/address_entity.dart';
import '../../domain/usecases/get_saved_addresses_usecase.dart';

class AddressPageController extends ChangeNotifier {
  AddressPageController({
    required GetSavedAddressesUseCase getSavedAddressesUseCase,
    VoidCallback? onConfirm,
    VoidCallback? onAddNewAddress,
  }) : _getSavedAddressesUseCase = getSavedAddressesUseCase,
       _onConfirm = onConfirm,
       _onAddNewAddress = onAddNewAddress;

  final GetSavedAddressesUseCase _getSavedAddressesUseCase;
  final VoidCallback? _onConfirm;
  final VoidCallback? _onAddNewAddress;

  final List<AddressEntity> _addresses = [];

  bool _isLoading = true;
  String? _selectedAddressId;

  bool get isLoading => _isLoading;
  String? get selectedAddressId => _selectedAddressId;
  List<AddressEntity> get addresses => List.unmodifiable(_addresses);

  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    final data = await _getSavedAddressesUseCase.call();

    _addresses
      ..clear()
      ..addAll(data);

    if (_addresses.isNotEmpty && _selectedAddressId == null) {
      _selectedAddressId = _addresses.first.id;
    }

    _isLoading = false;
    notifyListeners();
  }

  void selectAddress(String id) {
    if (_selectedAddressId == id) {
      return;
    }

    _selectedAddressId = id;
    notifyListeners();
  }

  void confirmSelection() {
    _onConfirm?.call();
  }

  void addNewAddress() {
    _onAddNewAddress?.call();
  }
}
