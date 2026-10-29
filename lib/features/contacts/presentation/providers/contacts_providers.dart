import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/contacts_repository_impl.dart';
import '../../domain/entities/contact.dart';

final contactsProvider = FutureProvider.family<List<Contact>, String?>((
  ref,
  keyword,
) {
  return ref.watch(contactsRepositoryProvider).getContacts(keyword: keyword);
});
