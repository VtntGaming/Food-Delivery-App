import '../entities/address_entity.dart';

abstract class AddressRepository {
  Future<List<AddressEntity>> getSavedAddresses();
}
