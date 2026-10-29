import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../core/network/api_client.dart';
import '../../../core/utils/text_utils.dart';
import 'models/contact_model.dart';

class ContactsRemoteDataSource {
  ContactsRemoteDataSource(ApiClient _);

  Future<List<ContactModel>> getContacts() async {
    // Contacts intentionally stay on mock data until a dedicated backend
    // contract is confirmed. This avoids accidental auth errors from trying
    // to map the screen onto unrelated ASMX endpoints.
    final list = await getMockContacts();
    return list;
  }

  Future<List<ContactModel>> getMockContacts() async {
    final raw = await rootBundle.loadString('assets/mock/contacts.json');
    final data = jsonDecode(raw) as List<dynamic>;
    return data.whereType<Map<String, dynamic>>().map(_parseContact).toList();
  }

  ContactModel _parseContact(Map<String, dynamic> json) {
    final normalized = Map<String, dynamic>.from(json);
    normalized['id'] = '${normalized['id'] ?? ''}';
    normalized['name'] = fixVietnameseEncoding(normalized['name'] ?? 'Liên hệ');
    normalized['digitalExport'] = _emptyToNull(
      fixVietnameseEncoding(normalized['digitalExport']),
    );
    normalized['address'] = fixVietnameseEncoding(normalized['address']);
    normalized['latitude'] = _toDouble(normalized['latitude']);
    normalized['longitude'] = _toDouble(normalized['longitude']);
    return ContactModel.fromJson(normalized);
  }

  String? _emptyToNull(String? value) {
    if (value == null || value.isEmpty) return null;
    return value;
  }

  double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value.toString());
  }
}
