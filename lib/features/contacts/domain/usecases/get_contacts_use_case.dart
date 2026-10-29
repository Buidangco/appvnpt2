import '../entities/contact.dart';
import '../repositories/contacts_repository.dart';

class GetContactsUseCase {
  const GetContactsUseCase(this._repository);

  final ContactsRepository _repository;

  Future<List<Contact>> call({String? keyword}) {
    return _repository.getContacts(keyword: keyword);
  }
}
