# i420n - Copilot Instructions

This is a Dart package for internationalization (i18n) using YAML-based code generation.

## Project Structure

- `lib/i420n.dart` - Main library entry point with `Locale`, `I420nMessageBundle`, and plural/ordinal functions
- `lib/src/i420n_impl.dart` - Code generator that transforms `.i420n.yaml` files into `.i420n.dart` files
- `lib/src/model.dart` - Data models for parsing YAML structure
- `lib/src/en.dart`, `lib/src/cs.dart` - Language-specific plural rules
- `test/` - Unit tests
- `example/` - Example usage with YAML files and generated Dart code

## Code Generation

The package uses `build_runner` to generate Dart code from YAML files:
- Input: `*.i420n.yaml` files
- Output: `*.i420n.dart` files (generated)

### YAML Format

```yaml
generic:
  ok: OK
  done: Done!
  
apples:
  count(int count): 
    - $count apples
    - No apples
    - One apple
```

### Generated Code Features

- Type-safe message classes extending `I420nMessageBundle`
- Locale information (`languageCode`, `localeName`, `flutterLocale`)
- Locale registry with `registerXxxLocale()`, `getXxxByLocale()`, `findXxxByLocale()`
- Supported locales lists (`xxxSupportedLocales`, `xxxSupportedLocalesFlutter`)
- Optional Flutter widgets when `flutter: true` in build.yaml

## Coding Guidelines

1. **Dart Style**: Follow Effective Dart guidelines
2. **Testing**: Add tests for new functionality in `test/i420n_test.dart`
3. **Documentation**: Add dartdoc comments to public APIs
4. **Generated Code**: Never edit `.i420n.dart` files directly - modify the generator in `lib/src/i420n_impl.dart`

## Common Tasks

### Adding a New Language's Plural Rules

1. Create `lib/src/{lang}.dart` with the `CategoryResolver` function
2. Import and register it in `lib/i420n.dart`

### Modifying Generated Code

1. Edit `lib/src/i420n_impl.dart`
2. Run `dart run build_runner build --delete-conflicting-outputs`
3. Verify generated output in `example/` and `test/`

### Running Tests

```bash
dart run build_runner build --delete-conflicting-outputs && dart test
```

## Build Configuration

The builder is configured in `build.yaml`:
- `flutter: true` - Generates Flutter widgets (LocaleSettings, TranslationProvider)
- Default locale is auto-detected from the base YAML filename

## Dependencies

- `build` & `build_config` - For code generation
- `yaml` - Parsing YAML files  
- `dart_style` - Formatting generated code
