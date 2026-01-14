// ignore_for_file: unused_element, unused_field, camel_case_types, annotate_overrides, prefer_single_quotes, library_private_types_in_public_api
// GENERATED FILE, do not edit!
import 'package:i420n/i420n.dart' as i420n;

String get _languageCode => 'en';
String get _localeName => 'en';

/// List of all supported locales for ExampleMessages.
/// Add your locale bundles to this list to make them discoverable.
final List<ExampleMessages> _exampleMessagesSupportedLocales = [
  const ExampleMessages()
];

/// Returns a list of all supported locales (locale names) for ExampleMessages.
List<String> get exampleMessagesSupportedLocales =>
    _exampleMessagesSupportedLocales.map((m) => m.localeName).toList();

/// Add a locale bundle to the list of supported locales.
void registerExampleMessagesLocale(ExampleMessages locale) {
  if (!_exampleMessagesSupportedLocales
      .any((m) => m.localeName == locale.localeName)) {
    _exampleMessagesSupportedLocales.add(locale);
  }
}

/// Get a locale bundle by locale name. Returns null if not found.
ExampleMessages? getExampleMessagesByLocale(String localeName) {
  for (final m in _exampleMessagesSupportedLocales) {
    if (m.localeName == localeName) return m;
  }
  return null;
}

// **************************************************************************
// Flutter-specific locale utilities
// **************************************************************************

/// Returns the list of supported Flutter [Locale] objects for use with [MaterialApp.supportedLocales].
List<i420n.Locale> get exampleMessagesSupportedLocalesFlutter =>
    _exampleMessagesSupportedLocales.map((m) => m.flutterLocale).toList();

/// Find a message bundle by Flutter [Locale]. Returns null if not found.
/// Tries exact match first, then falls back to language-only match.
ExampleMessages? findExampleMessagesByLocale(i420n.Locale locale) {
  final fullMatch =
      '${locale.languageCode}${locale.countryCode != null ? '_${locale.countryCode}' : ''}';
  // Try exact match first (e.g., en_GB)
  for (final m in _exampleMessagesSupportedLocales) {
    if (m.localeName == fullMatch) return m;
  }
  // Fall back to language-only match (e.g., en)
  for (final m in _exampleMessagesSupportedLocales) {
    if (m.languageCode == locale.languageCode) return m;
  }
  return null;
}

String _plural(int count,
        {String? zero,
        String? one,
        String? two,
        String? few,
        String? many,
        String? other}) =>
    i420n.plural(count, _languageCode,
        zero: zero, one: one, two: two, few: few, many: many, other: other);
String _ordinal(int count,
        {String? zero,
        String? one,
        String? two,
        String? few,
        String? many,
        String? other}) =>
    i420n.ordinal(count, _languageCode,
        zero: zero, one: one, two: two, few: few, many: many, other: other);
String _cardinal(int count,
        {String? zero,
        String? one,
        String? two,
        String? few,
        String? many,
        String? other}) =>
    i420n.cardinal(count, _languageCode,
        zero: zero, one: one, two: two, few: few, many: many, other: other);

class ExampleMessages implements i420n.I420nMessageBundle {
  const ExampleMessages();
  String get languageCode => _languageCode;
  String get localeName => _localeName;
  i420n.Locale get flutterLocale => i420n.Locale.fromLocaleName(localeName);
  GenericExampleMessages get generic => GenericExampleMessages(this);
  InvoiceExampleMessages get invoice => InvoiceExampleMessages(this);
  ApplesExampleMessages get apples => ApplesExampleMessages(this);
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i420n.I420nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'generic':
        return generic;
      case 'invoice':
        return invoice;
      case 'apples':
        return apples;
      default:
        return key;
    }
  }
}

class GenericExampleMessages implements i420n.I420nMessageBundle {
  final ExampleMessages _parent;
  const GenericExampleMessages(this._parent);
  String get languageCode => _parent.languageCode;
  String get localeName => _parent.localeName;
  i420n.Locale get flutterLocale => _parent.flutterLocale;
  String get ok => "OK";
  String get done => "DONE";
  String get letsGo => "Let's go!";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i420n.I420nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'ok':
        return ok;
      case 'done':
        return done;
      case 'letsGo':
        return letsGo;
      default:
        return key;
    }
  }
}

class InvoiceExampleMessages implements i420n.I420nMessageBundle {
  final ExampleMessages _parent;
  const InvoiceExampleMessages(this._parent);
  String get languageCode => _parent.languageCode;
  String get localeName => _parent.localeName;
  i420n.Locale get flutterLocale => _parent.flutterLocale;
  String get create => "Create invoice";
  String get delete => "Delete  invoice";
  String get help =>
      "Use this function to generate new invoices and stuff. Awesome!";
  String count(int cnt) =>
      "You have created $cnt ${_plural(cnt, one: 'invoice', many: 'invoices')}.";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i420n.I420nMessageBundle)[key.substring(index + 1)];
    }
    throw Exception(
        '[] operator is disabled in en.invoice, see _i420n: nomap flag.');
  }
}

class ApplesExampleMessages implements i420n.I420nMessageBundle {
  final ExampleMessages _parent;
  const ApplesExampleMessages(this._parent);
  String get languageCode => _parent.languageCode;
  String get localeName => _parent.localeName;
  i420n.Locale get flutterLocale => _parent.flutterLocale;
  String _apples(int cnt) =>
      "${_plural(cnt, zero: 'no apples', one: '$cnt apple', many: '$cnt apples')}";
  String count(int cnt) => "You have eaten ${_apples(cnt)}.";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i420n.I420nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case '_apples':
        return _apples;
      case 'count':
        return count;
      default:
        return key;
    }
  }
}
