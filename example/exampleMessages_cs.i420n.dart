// ignore_for_file: unused_element, unused_field, camel_case_types, annotate_overrides, prefer_single_quotes, library_private_types_in_public_api
// GENERATED FILE, do not edit!
import 'package:i420n/i420n.dart' as i420n;
import 'exampleMessages.i420n.dart';

/// Auto-register this locale when the file is imported.
/// This makes it available via [exampleMessagesSupportedLocales]
/// and lookup functions without manual registration.
final _exampleMessages_csRegistered = () {
  registerExampleMessagesLocale(const ExampleMessages_cs());
  return true;
}();

String get _languageCode => 'cs';
String get _localeName => 'cs';

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

class ExampleMessages_cs extends ExampleMessages {
  const ExampleMessages_cs();
  String get languageCode => _languageCode;
  String get localeName => _localeName;
  i420n.Locale get flutterLocale => i420n.Locale.fromLocaleName(localeName);
  GenericExampleMessages_cs get generic => GenericExampleMessages_cs(this);
  InvoiceExampleMessages_cs get invoice => InvoiceExampleMessages_cs(this);
  ApplesExampleMessages_cs get apples => ApplesExampleMessages_cs(this);
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

class GenericExampleMessages_cs extends GenericExampleMessages {
  final ExampleMessages_cs _parent;
  const GenericExampleMessages_cs(this._parent) : super(_parent);
  String get done => "Hotovo";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i420n.I420nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'done':
        return done;
      default:
        return super[key];
    }
  }
}

class InvoiceExampleMessages_cs extends InvoiceExampleMessages {
  final ExampleMessages_cs _parent;
  const InvoiceExampleMessages_cs(this._parent) : super(_parent);
  String get create => "Vytvořit fakturu";
  String get delete => "Smazat fakturu";
  String get help => "Tuhle funkci použij na vytváření faktur. Boží!";
  String count(int a) =>
      "Už jsi vytvořil ${_plural(a, one: 'fakturu', few: 'faktury', many: 'faktur')}.";
  Object operator [](String key) {
    var index = key.indexOf('.');
    if (index > 0) {
      return (this[key.substring(0, index)]
          as i420n.I420nMessageBundle)[key.substring(index + 1)];
    }
    switch (key) {
      case 'create':
        return create;
      case 'delete':
        return delete;
      case 'help':
        return help;
      case 'count':
        return count;
      default:
        return super[key];
    }
  }
}

class ApplesExampleMessages_cs extends ApplesExampleMessages {
  final ExampleMessages_cs _parent;
  const ApplesExampleMessages_cs(this._parent) : super(_parent);
  String _apples(int cnt) =>
      "${_plural(cnt, zero: 'fakt málo jablek', one: 'jedno jablko', few: '$cnt jablka', many: '$cnt jablek')}";
  String count(int cnt) => "Snědl jsi ${_apples(cnt)}.";
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
