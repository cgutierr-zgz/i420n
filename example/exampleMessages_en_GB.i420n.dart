// ignore_for_file: unused_element, unused_field, camel_case_types, annotate_overrides, prefer_single_quotes, library_private_types_in_public_api
// GENERATED FILE, do not edit!
import 'package:i420n/i420n.dart' as i420n;
import 'exampleMessages.i420n.dart';

/// Auto-register this locale when the file is imported.
/// This makes it available via [exampleMessagesSupportedLocales]
/// and lookup functions without manual registration.
final _exampleMessages_en_GBRegistered = () {
  registerExampleMessagesLocale(const ExampleMessages_en_GB());
  return true;
}();

String get _languageCode => 'en';
String get _localeName => 'en_GB';

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

class ExampleMessages_en_GB extends ExampleMessages {
  const ExampleMessages_en_GB();
  String get languageCode => _languageCode;
  String get localeName => _localeName;
  i420n.Locale get flutterLocale => i420n.Locale.fromLocaleName(localeName);
  GenericExampleMessages_en_GB get generic =>
      GenericExampleMessages_en_GB(this);
  InvoiceExampleMessages_en_GB get invoice =>
      InvoiceExampleMessages_en_GB(this);
  ApplesExampleMessages_en_GB get apples => ApplesExampleMessages_en_GB(this);
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
        return super[key];
    }
  }
}

class GenericExampleMessages_en_GB extends GenericExampleMessages {
  final ExampleMessages_en_GB _parent;
  const GenericExampleMessages_en_GB(this._parent) : super(_parent);
  String get ok => "OK";
  String get done => "DONE";
  String get letsGo => "Let us go!";
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
        return super[key];
    }
  }
}

class InvoiceExampleMessages_en_GB extends InvoiceExampleMessages {
  final ExampleMessages_en_GB _parent;
  const InvoiceExampleMessages_en_GB(this._parent) : super(_parent);
  String get create => "Create invoice";
  String get delete => "Delete  invoice";
  String get help =>
      "Use this function to generate new invoices and stuff. Awesome!";
  String count(int cnt) =>
      "You have created $cnt ${_plural(cnt, one: 'invoice', many: 'invoices')} indeed.";
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

class ApplesExampleMessages_en_GB extends ApplesExampleMessages {
  final ExampleMessages_en_GB _parent;
  const ApplesExampleMessages_en_GB(this._parent) : super(_parent);
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
        return super[key];
    }
  }
}
