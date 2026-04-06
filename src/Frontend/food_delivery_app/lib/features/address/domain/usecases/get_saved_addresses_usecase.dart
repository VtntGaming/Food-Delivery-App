import '../entities/address_entity.dart';
import '../repositories/address_repository.dart';

class GetSavedAddressesUseCase {
  const GetSavedAddressesUseCase(this._repository);

  final AddressRepository _repository;

  Future<List<AddressEntity>> call() {
    return _repository.getSavedAddresses();
  }
}
