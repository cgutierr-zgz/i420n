// ignore_for_file: unused_element, unused_field, camel_case_types, annotate_overrides, prefer_single_quotes, library_private_types_in_public_api
// GENERATED FILE, do not edit!
import 'package:i420n/i420n.dart' as i420n;
import 'dart:io';

String get _languageCode => 'sk';
String get _localeName => 'en';

/// List of all supported locales for TestMessages.
/// Add your locale bundles to this list to make them discoverable.
final List<TestMessages> _testMessagesSupportedLocales = [const TestMessages()];

/// Returns a list of all supported locales (locale names) for TestMessages.
List<String> get testMessagesSupportedLocales =>
    _testMessagesSupportedLocales.map((m) => m.localeName).toList();

/// Add a locale bundle to the list of supported locales.
void registerTestMessagesLocale(TestMessages locale) {
  if (!_testMessagesSupportedLocales
      .any((m) => m.localeName == locale.localeName)) {
    _testMessagesSupportedLocales.add(locale);
  }
}

/// Get a locale bundle by locale name. Returns null if not found.
TestMessages? getTestMessagesByLocale(String localeName) {
  for (final m in _testMessagesSupportedLocales) {
    if (m.localeName == localeName) return m;
  }
  return null;
}

// **************************************************************************
// Flutter-specific locale utilities
// **************************************************************************

/// Returns the list of supported Flutter [Locale] objects for use with [MaterialApp.supportedLocales].
List<i420n.Locale> get testMessagesSupportedLocalesFlutter =>
    _testMessagesSupportedLocales.map((m) => m.flutterLocale).toList();

/// Find a message bundle by Flutter [Locale]. Returns null if not found.
/// Tries exact match first, then falls back to language-only match.
TestMessages? findTestMessagesByLocale(i420n.Locale locale) {
  final fullMatch =
      '${locale.languageCode}${locale.countryCode != null ? '_${locale.countryCode}' : ''}';
  // Try exact match first (e.g., en_GB)
  for (final m in _testMessagesSupportedLocales) {
    if (m.localeName == fullMatch) return m;
  }
  // Fall back to language-only match (e.g., en)
  for (final m in _testMessagesSupportedLocales) {
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

class TestMessages implements i420n.I420nMessageBundle {
  const TestMessages();
  String get languageCode => _languageCode;
  String get localeName => _localeName;
  i420n.Locale get flutterLocale => i420n.Locale.fromLocaleName(localeName);
  GenericTestMessages get generic => GenericTestMessages(this);
  InvoiceTestMessages get invoice => InvoiceTestMessages(this);
  ApplesTestMessages get apples => ApplesTestMessages(this);
  FriendsTestMessages get friends => FriendsTestMessages(this);
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
      case 'friends':
        return friends;
      default:
        return key;
    }
  }
}

class GenericTestMessages implements i420n.I420nMessageBundle {
  final TestMessages _parent;
  const GenericTestMessages(this._parent);
  String get languageCode => _parent.languageCode;
  String get localeName => _parent.localeName;
  i420n.Locale get flutterLocale => _parent.flutterLocale;
  String get ok => "OK";
  String get done => "DONE";
  String get letsGo => "Let's go!";
  String ordinalNumber(int n) =>
      "${_ordinal(n, one: '1st', two: '2nd', few: '3rd', other: '${n}th')}";
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
      case 'ordinalNumber':
        return ordinalNumber;
      default:
        return key;
    }
  }
}

class InvoiceTestMessages implements i420n.I420nMessageBundle {
  final TestMessages _parent;
  const InvoiceTestMessages(this._parent);
  String get languageCode => _parent.languageCode;
  String get localeName => _parent.localeName;
  i420n.Locale get flutterLocale => _parent.flutterLocale;
  String get create => "Create invoice";
  String get delete => "Delete  invoice";
  String get help =>
      "Use this function to generate new invoices and stuff. Awesome!";
  String count(int cnt) =>
      "You have created $cnt ${_plural(cnt, one: 'invoice', many: 'invoices')}.";
  String get something => "Let\'s go!";
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

class ApplesTestMessages implements i420n.I420nMessageBundle {
  final TestMessages _parent;
  const ApplesTestMessages(this._parent);
  String get languageCode => _parent.languageCode;
  String get localeName => _parent.localeName;
  i420n.Locale get flutterLocale => _parent.flutterLocale;
  String _apples(int cnt) =>
      "${_plural(cnt, zero: 'no apples', one: '$cnt apple', many: '$cnt apples')}";
  String count(int cnt) => "You have eaten ${_apples(cnt)}.";
  String problematic(int count) =>
      "${_plural(count, zero: 'didn\'t find any tasks', one: 'found 1 task', other: 'found $count tasks')}";
  String get anotherProblem => "here\nthere";
  String get quotes => "Hello \"world\"!";
  String get quotes2 => "Hello \"world\"!";
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
      case 'problematic':
        return problematic;
      case 'anotherProblem':
        return anotherProblem;
      case 'quotes':
        return quotes;
      case 'quotes2':
        return quotes2;
      default:
        return key;
    }
  }
}

class FriendsTestMessages implements i420n.I420nMessageBundle {
  final TestMessages _parent;
  const FriendsTestMessages(this._parent);
  String get languageCode => _parent.languageCode;
  String get localeName => _parent.localeName;
  i420n.Locale get flutterLocale => _parent.flutterLocale;
  MichaelFriendsTestMessages get michael => MichaelFriendsTestMessages(this);
  EvaFriendsTestMessages get eva => EvaFriendsTestMessages(this);
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i420n.I420nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'michael':
        return michael;
      case 'eva':
        return eva;
      default:
        return key;
    }
  }
}

class MichaelFriendsTestMessages implements i420n.I420nMessageBundle {
  final FriendsTestMessages _parent;
  const MichaelFriendsTestMessages(this._parent);
  String get languageCode => _parent.languageCode;
  String get localeName => _parent.localeName;
  i420n.Locale get flutterLocale => _parent.flutterLocale;
  String get name => "Aaaaa";
  String get description => "Aa Aa Aa";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i420n.I420nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'name':
        return name;
      case 'description':
        return description;
      default:
        return key;
    }
  }
}

class EvaFriendsTestMessages
    implements i420n.I420nMessageBundle, MichaelFriendsTestMessages {
  final FriendsTestMessages _parent;
  const EvaFriendsTestMessages(this._parent);
  String get languageCode => _parent.languageCode;
  String get localeName => _parent.localeName;
  i420n.Locale get flutterLocale => _parent.flutterLocale;
  String get _i420n_implements => "MichaelFriendsTestMessages";
  String get name => "Bbbbb";
  String get description => "Bb Bb Bb";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i420n.I420nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case '_i420n_implements':
        return _i420n_implements;
      case 'name':
        return name;
      case 'description':
        return description;
      default:
        return key;
    }
  }
}
