# Add New Language Support

Use this prompt to add plural/ordinal rules for a new language.

## Instructions

When adding a new language:

1. **Create the language file** at `lib/src/{lang_code}.dart`:
   ```dart
   import '../i420n.dart';

   QuantityCategory {langCode}Resolver(int count, QuantityType type) {
     // Implement CLDR plural rules for this language
     // See: https://cldr.unicode.org/index/cldr-spec/plural-rules
   }
   ```

2. **Register in `lib/i420n.dart`**:
   - Import the new file
   - Add to `_defaultResolverRegistry`

3. **Add tests** in `test/i420n_test.dart`

4. **Update documentation** if needed

## Example Request

"Add support for German (de) language with its plural rules"

## CLDR Plural Rules Reference

Common patterns:
- **English-like** (one/other): 1 is "one", everything else is "other"
- **French-like**: 0-1 is "one", 2+ is "other"  
- **Slavic** (one/few/many/other): Complex rules based on last digits
- **Arabic**: Has all six categories (zero/one/two/few/many/other)

See https://cldr.unicode.org/index/cldr-spec/plural-rules for complete rules.
