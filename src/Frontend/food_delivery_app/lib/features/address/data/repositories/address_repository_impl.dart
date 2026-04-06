import '../../domain/entities/address_entity.dart';
import '../../domain/repositories/address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  const AddressRepositoryImpl();

  @override
  Future<List<AddressEntity>> getSavedAddresses() async {
    return const [
      AddressEntity(
        id: 'home',
        fullName: 'Nguyễn Văn A',
        phone: '(84)0652 323 939',
        addressLine: '123 Nguyễn Trãi, Q1',
      ),
      AddressEntity(
        id: 'office',
        fullName: 'Trần Văn B',
        phone: '(84)0128 927 221',
        addressLine: '456 Lê Lợi, Q1',
      ),
    ];
  }
}
