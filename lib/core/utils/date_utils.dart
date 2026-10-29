import 'package:intl/intl.dart';

String formatDate(String? value) {
  if (value == null || value.trim().isEmpty) {
    return '--';
  }
  final raw = value.trim();

  final parsed = DateTime.tryParse(raw) ?? _tryParseNonIso(raw);
  if (parsed == null) {
    return raw;
  }
  return DateFormat('dd/MM/yyyy').format(parsed);
}

/// The ASMX API doesn't return ISO-8601 dates consistently, and the shape
/// even differs by endpoint:
/// - `Lay_ds_tintuc` (news list/detail): `MM-dd-yyyy`, e.g. "08-13-2026".
/// - `Lay_ds_tin_settop` (home featured news): .NET's default en-US
///   `ToString()`, e.g. "8/13/2026 12:00:00 AM" (`M/d/yyyy h:mm:ss tt`).
/// - Older docs also show a plain `dd/MM/yyyy` (no time) for other spots.
/// [DateTime.tryParse] only understands ISO-8601, so fall back to parsing
/// those known shapes, using the presence of a time-of-day to tell the two
/// slash-separated shapes apart.
DateTime? _tryParseNonIso(String raw) {
  final datePart = raw.split(RegExp(r'[ T]')).first;
  if (datePart.contains('/')) {
    final pattern = raw.contains(':') ? 'M/d/yyyy' : 'dd/MM/yyyy';
    return _tryParsePattern(datePart, pattern);
  }
  if (datePart.contains('-')) {
    return _tryParsePattern(datePart, 'MM-dd-yyyy');
  }
  return null;
}

DateTime? _tryParsePattern(String input, String pattern) {
  try {
    return DateFormat(pattern).parseStrict(input);
  } on FormatException {
    return null;
  }
}
