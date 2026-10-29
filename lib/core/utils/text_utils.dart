import 'dart:convert';

String normalizeText(String? value) {
  return (value ?? '').trim();
}

bool isBlank(String? value) {
  return normalizeText(value).isEmpty;
}

String fixVietnameseEncoding(String? input) {
  final value = normalizeText(input);
  if (value.isEmpty) return value;

  // Repair common mojibake when UTF-8 bytes are decoded as Latin-1/Windows-1252.
  final hasMojibakeHints =
      value.contains('Ã') ||
      value.contains('áº') ||
      value.contains('Ä') ||
      value.contains('Æ') ||
      value.contains('Â');
  if (!hasMojibakeHints) {
    return value;
  }

  try {
    return utf8.decode(latin1.encode(value), allowMalformed: true);
  } catch (_) {
    return value;
  }
}
