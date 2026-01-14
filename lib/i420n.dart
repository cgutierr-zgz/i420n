import 'src/cs.dart' as cs;
import 'src/en.dart' as en;

///
/// Language specific function, which is provided with a number and should return one of possible categories.
/// count is never null.
///
typedef CategoryResolver = QuantityCategory Function(int count, QuantityType type);

enum QuantityCategory { zero, one, two, few, many, other }

enum QuantityType { cardinal, ordinal }

/// A simple locale representation compatible with Flutter's Locale class.
///
/// This class provides the same interface as Flutter's Locale class,
/// allowing i420n to work in both pure Dart and Flutter projects.
/// In Flutter projects, you can use this directly with `MaterialApp.supportedLocales`.
class Locale {
  /// Creates a new [Locale] with the given [languageCode] and optional [countryCode].
  const Locale(this.languageCode, [this.countryCode]);

  /// Creates a [Locale] from a locale name string (e.g., 'en', 'en_GB', 'cs_CZ').
  factory Locale.fromLocaleName(String localeName) {
    final parts = localeName.split('_');
    if (parts.length == 1) {
      return Locale(parts[0]);
    }
    return Locale(parts[0], parts[1]);
  }

  /// The language code (e.g., 'en', 'cs', 'de').
  final String languageCode;

  /// The country code (e.g., 'US', 'GB', 'CZ'), or null if not specified.
  final String? countryCode;

  /// Returns the locale as a string in the format 'languageCode' or 'languageCode_countryCode'.
  String toLanguageTag() => countryCode != null ? '${languageCode}_$countryCode' : languageCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Locale && other.languageCode == languageCode && other.countryCode == countryCode;
  }

  @override
  int get hashCode => Object.hash(languageCode, countryCode);

  @override
  String toString() => countryCode != null ? '${languageCode}_$countryCode' : languageCode;
}

/// Base class for all i420n message bundles.
///
/// Provides access to messages and locale information.
abstract class I420nMessageBundle {
  /// Access a message by key. Supports dot notation for nested messages.
  Object operator [](String messageKey);

  /// The language code (e.g., 'en', 'cs', 'de') for this message bundle.
  String get languageCode;

  /// The full locale name (e.g., 'en', 'en_GB', 'cs') for this message bundle.
  String get localeName;

  /// Returns a [Locale] object for this message bundle.
  ///
  /// This is useful for Flutter integration with `MaterialApp.locale`.
  Locale get flutterLocale;
}

void registerResolver(String languageCode, CategoryResolver resolver) {
  _resolverRegistry[languageCode] = resolver;
}

///
/// Same as cardinal.
///
String plural(int count, String languageCode,
    {String? zero, String? one, String? two, String? few, String? many, String? other}) {
  return _resolvePlural(count, languageCode, QuantityType.cardinal,
      zero: zero, one: one, two: two, few: few, many: many, other: other);
}

///
/// See: http://cldr.unicode.org/index/cldr-spec/plural-rules
///
String cardinal(int count, String languageCode,
    {String? zero, String? one, String? two, String? few, String? many, String? other}) {
  return _resolvePlural(count, languageCode, QuantityType.cardinal,
      zero: zero, one: one, two: two, few: few, many: many, other: other);
}

///
/// See: http://cldr.unicode.org/index/cldr-spec/plural-rules
///
String ordinal(int count, String languageCode,
    {String? zero, String? one, String? two, String? few, String? many, String? other}) {
  return _resolvePlural(count, languageCode, QuantityType.ordinal,
      zero: zero, one: one, two: two, few: few, many: many, other: other);
}

Map<String, CategoryResolver> _resolverRegistry = {
  'en': en.quantityResolver,
  'cs': cs.quantityResolver,
};

String _resolvePlural(int count, String languageCode, QuantityType type,
    {String? zero, String? one, String? two, String? few, String? many, String? other}) {
  final c = _resolveCategory(languageCode, count, type);
  many ??= other;
  switch (c) {
    case QuantityCategory.zero:
      return _firstNotNull([zero, many, other])!;
    case QuantityCategory.one:
      return _firstNotNull([one, many, other])!;
    case QuantityCategory.two:
      return _firstNotNull([two, few, many, other])!;
    case QuantityCategory.few:
      return _firstNotNull([few, many, other])!;
    case QuantityCategory.many:
      return _firstNotNull([many, other, few])!;
    case QuantityCategory.other:
      return _firstNotNull([other, many, few])!;
  }
}

QuantityCategory _defaultResolver(int count, QuantityType type) {
  switch (count) {
    case 0:
      return QuantityCategory.zero;
    case 1:
      return QuantityCategory.one;
    case 2:
      return QuantityCategory.two;
    case 3:
      return QuantityCategory.few;
    case 4:
      return QuantityCategory.few;
  }
  return QuantityCategory.other;
}

QuantityCategory _resolveCategory(String languageCode, int count, QuantityType type) {
  final resolver = _resolverRegistry[languageCode] ?? _defaultResolver;
  return resolver(count, type);
}

String? _firstNotNull(List<String?> possibilities) {
  return possibilities.firstWhere((a) => a != null, orElse: () => '???');
}
