import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_exception.dart';
import '../domain/entities/contact.dart';
import '../domain/repositories/contacts_repository.dart';
import 'contacts_remote_data_source.dart';
import 'models/contact_model.dart';

class ContactsRepositoryImpl implements ContactsRepository {
  ContactsRepositoryImpl(this._remote);

  final ContactsRemoteDataSource _remote;

  @override
  Future<List<Contact>> getContacts({String? keyword}) async {
    List<Contact> contacts = <Contact>[];
    try {
      final remote = await _remote.getContacts();
      contacts = remote.map((e) => e.toEntity()).toList();
    } on ApiException {
      final mock = await _remote.getMockContacts();
      contacts = mock.map((e) => e.toEntity()).toList();
    }

    if (keyword == null || keyword.isEmpty) {
      return contacts;
    }

    final search = keyword.toLowerCase();
    return contacts
        .where(
          (c) =>
              c.name.toLowerCase().contains(search) ||
              (c.address ?? '').toLowerCase().contains(search),
        )
        .toList();
  }
}

final contactsRemoteDataSourceProvider = Provider<ContactsRemoteDataSource>((
  ref,
) {
  return ContactsRemoteDataSource(ref.watch(apiClientProvider));
});

final contactsRepositoryProvider = Provider<ContactsRepository>((ref) {
  return ContactsRepositoryImpl(ref.watch(contactsRemoteDataSourceProvider));
});
