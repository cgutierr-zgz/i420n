# i420n

Simple, type-safe internationalization (i18n) for Dart and Flutter.

[![pub package](https://img.shields.io/badge/pub.dev-i420n-brightgreen)](https://pub.dev/packages/i420n)
[![License: BSD](https://img.shields.io/badge/License-BSD-blue.svg)](LICENSE)

> **Note**: i420n is a fork of [i69n](https://github.com/fnx-io/i69n) by [fnx.io](https://fnx.io), enhanced with Flutter `Locale` support, `supportedLocales` registry, and a modern developer experience. All credit to the original authors for the excellent foundation!

## Features

- ✅ **Type-safe** - Messages are checked at compile time
- ✅ **Code generation** - From YAML to Dart classes
- ✅ **Flutter integration** - `supportedLocales`, `Locale` objects, `MaterialApp` ready
- ✅ **Pluralization** - Built-in plural rules for multiple languages
- ✅ **Inheritance** - Translations inherit from base locale
- ✅ **Deferred loading** - Lazy load translations when needed
- ✅ **Hot reload** - Works with Flutter hot reload
- ✅ **Null safety** - Full null safety support

## Quick Start

### 1. Add dependencies

```yaml
# pubspec.yaml
dependencies:
  i420n: ^1.0.0

dev_dependencies:
  build_runner: ^2.4.0
```

### 2. Create YAML translation files

```yaml
# lib/messages.i420n.yaml (default/English)
generic:
  ok: OK
  cancel: Cancel
greeting:
  hello(String name): "Hello, $name!"
  items(int count): "You have ${_plural(count, one: '1 item', other: '$count items')}"
```

```yaml
# lib/messages_es.i420n.yaml (Spanish)
generic:
  ok: Aceptar
  cancel: Cancelar
greeting:
  hello(String name): "¡Hola, $name!"
  items(int count): "Tienes ${_plural(count, one: '1 artículo', other: '$count artículos')}"
```

### 3. Generate Dart code

```bash
dart run build_runner build
```

### 4. Use in your app

```dart
import 'messages.i420n.dart';
import 'messages_es.i420n.dart'; // Auto-registered on import!

void main() {
  var m = Messages();
  print(m.generic.ok);           // "OK"
  print(m.greeting.hello('World')); // "Hello, World!"
  print(m.greeting.items(5));    // "You have 5 items"
  
  // Switch to Spanish
  m = Messages_es();
  print(m.generic.ok);           // "Aceptar"
  
  // Or find by locale name
  m = getMessagesByLocale('es') ?? Messages();
}
```

## Flutter Integration

i420n provides first-class Flutter support with `LocaleSettings`, `TranslationProvider`, global accessor, and context-based access.

### Enable Flutter Widgets

Add `flutter: true` to your `build.yaml`:

```yaml
# build.yaml
targets:
  $default:
    builders:
      i420n|yamlBasedBuilder:
        options:
          flutter: true
```

Then regenerate: `dart run build_runner build --delete-conflicting-outputs`

### Quick Start

```dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'messages.i420n.dart';
import 'messages_es.i420n.dart'; // Auto-registered!

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MessagesLocaleSettings.useDeviceLocale(); // Use device locale
  runApp(TranslationProvider(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: TranslationProvider.flutterLocale(context),
      supportedLocales: MessagesLocaleSettings.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access via context extension
    return Text(context.messages.greeting.hello('World'));
  }
}
```

### Changing Locale

```dart
// Option 1: Use device locale
MessagesLocaleSettings.useDeviceLocale();

// Option 2: Set by locale string
MessagesLocaleSettings.setLocaleRaw('es');

// Option 3: Set by Locale object
MessagesLocaleSettings.setLocale(Locale('es'));
```

The `TranslationProvider` will automatically rebuild all widgets when locale changes.

### Global Accessor

```dart
// Use the global accessor anywhere (after init)
String a = messages.greeting.hello('World');
```

### Access Methods

```dart
// 1. Global accessor
messages.generic.ok

// 2. Extension on BuildContext (reactive)
context.messages.generic.ok

// 3. TranslationProvider.of
TranslationProvider.of(context).generic.ok
```

### Complete Example

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MessagesLocaleSettings.useDeviceLocale(); // or: MessagesLocaleSettings.init()
  runApp(TranslationProvider(child: MyApp()));
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(context.messages.settings.title),
        ElevatedButton(
          onPressed: () => MessagesLocaleSettings.setLocaleRaw('en'),
          child: Text('English'),
        ),
        ElevatedButton(
          onPressed: () => MessagesLocaleSettings.setLocaleRaw('es'),
          child: Text('Español'),
        ),
      ],
    );
  }
}
```

### Without Context (Pure Dart)

If you don't set `flutter: true` or need pure Dart usage:

```dart
import 'messages.i420n.dart';
import 'messages_es.i420n.dart'; // Auto-registered!

void main() {
  var m = Messages();
  print(m.generic.ok);           // "OK"
  
  m = findMessagesByLocale(Locale('es')) ?? Messages();
  print(m.generic.ok);           // "Aceptar"
}
```

### Available Utilities

For a message bundle named `Messages`, the following are generated:

| Utility | Type | Description |
|---------|------|-------------|
| `messagesSupportedLocales` | `List<String>` | List of registered locale names |
| `messagesSupportedLocalesFlutter` | `List<Locale>` | For `MaterialApp.supportedLocales` |
| `registerMessagesLocale(m)` | `void` | Manually register a locale (only needed for deferred loading) |
| `getMessagesByLocale(name)` | `Messages?` | Find by locale name string |
| `findMessagesByLocale(Locale)` | `Messages?` | Find by Flutter Locale (with fallback) |
| `m.languageCode` | `String` | Language code (e.g., 'en', 'es') |
| `m.localeName` | `String` | Full locale name (e.g., 'en', 'en_GB') |
| `m.flutterLocale` | `Locale` | Flutter Locale object |

**With `flutter: true`** (additional utilities):

| Utility | Type | Description |
|---------|------|-------------|
| `messages` | `Messages` | Global accessor for translations |
| `MessagesLocaleSettings` | `class` | Locale management |
| `MessagesLocaleSettings.useDeviceLocale()` | `void` | Set locale from device |
| `MessagesLocaleSettings.setLocaleRaw(str)` | `void` | Set locale by string |
| `MessagesLocaleSettings.setLocale(Locale)` | `void` | Set locale by Locale |
| `MessagesLocaleSettings.supportedLocales` | `List<Locale>` | For `MaterialApp.supportedLocales` |
| `TranslationProvider` | `Widget` | Wrap your app, auto-rebuilds on locale change |
| `TranslationProvider.of(context)` | `Messages` | Get translations from context |
| `TranslationProvider.flutterLocale(context)` | `Locale` | Get current locale |
| `context.messages` | `Messages` | BuildContext extension |

> **Note**: Locales are auto-registered when you import them. Manual registration via `registerMessagesLocale()` is only needed for deferred/lazy loading.

### Language Selection Widget

```dart
class LanguageSelector extends StatelessWidget {
class LanguageSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: context.messagesLocale.languageCode,
      items: messagesSupportedLocales.map((name) {
        return DropdownMenuItem(value: name, child: Text(name));
      }).toList(),
      onChanged: (name) {
        if (name != null) {
          MessagesLocaleSettings.setLocaleRaw(name);
        }
      },
    );
  }
}
```

## File Naming Convention

| File | Description |
|------|-------------|
| `messages.i420n.yaml` | Default locale (English) |
| `messages_es.i420n.yaml` | Spanish |
| `messages_fr.i420n.yaml` | French |
| `messages_pt_BR.i420n.yaml` | Brazilian Portuguese |
| `messages_zh_CN.i420n.yaml` | Simplified Chinese |

## Pluralization

i420n supports CLDR plural rules with built-in support for English and Czech. Add more languages as needed.

```yaml
items:
  count(int n): "${_plural(n, zero: 'no items', one: '1 item', other: '$n items')}"
```

Available plural categories: `zero`, `one`, `two`, `few`, `many`, `other`

### Available Functions

```dart
_plural(count, {...})   // Same as _cardinal
_cardinal(count, {...}) // Cardinal numbers (1 apple, 2 apples)
_ordinal(count, {...})  // Ordinal numbers (1st, 2nd, 3rd)
```

### Register Custom Plural Rules

```dart
import 'package:i420n/i420n.dart' as i420n;

i420n.registerResolver('es', (int count, i420n.QuantityType type) {
  if (count == 1) return i420n.QuantityCategory.one;
  return i420n.QuantityCategory.other;
});
```

## Configuration Flags

Use flags in your YAML to control behavior:

```yaml
_i420n: noescape,nomap
generic:
  ok: OK
```

| Flag | Description |
|------|-------------|
| `noescape` | Disable automatic escaping of special characters |
| `nomap` | Disable `[]` operator for this group |
| `notraverse` | Disable dot notation access |
| `nothrow` | Return key instead of throwing when message not found |

### Global Configuration

Configure flags globally in `build.yaml`:

```yaml
targets:
  $default:
    builders:
      i420n|yamlBasedBuilder:
        options:
          nomap: true
          notraverse: true
```

Override locally with `map` or `traverse` flags:

```yaml
_i420n: map  # Override global nomap
hello: "Hello"
```

## Dynamic Access

Access messages using string keys at runtime:

```dart
var m = Messages();
print(m.generic.ok);        // Static access
print(m.generic['ok']);     // Dynamic access
print(m['generic.ok']);     // Dot notation access
```

## Custom Imports and Types

Add custom imports and implement interfaces:

```yaml
_i420n_import: package:my_app/interfaces.dart
friends:
  john:
    _i420n_implements: PersonInterface
    name: John
    bio: Developer
```

## Deferred Loading

Load translations on demand. This is the **only case** where manual registration is needed, since deferred imports don't trigger auto-registration until loaded:

```dart
import 'messages.i420n.dart';
import 'messages_es.i420n.dart' deferred as es;

Future<void> loadSpanish() async {
  await es.loadLibrary();
  // After loading, the locale is auto-registered.
  // You can now use it:
  var m = es.Messages_es();
  print(m.generic.ok);
}
```
```

## Migration from i69n

If you're migrating from i69n:

1. Update package name: `i69n` → `i420n`
2. Rename YAML files: `.i69n.yaml` → `.i420n.yaml`
3. Update flags: `_i69n` → `_i420n`, `_i69n_import` → `_i420n_import`, etc.
4. Update imports: `package:i69n/i69n.dart` → `package:i420n/i420n.dart`
5. Run `dart run build_runner build --delete-conflicting-outputs`

## Example

See the [example](example/) directory for a complete working example.

```bash
cd example
dart run build_runner build
dart run main_i420n.dart
```

## Credits & Acknowledgments

This package is a fork of the excellent [**i69n**](https://github.com/fnx-io/i69n) package created by [fnx.io](https://fnx.io). The original i69n provided the solid foundation for type-safe, YAML-based internationalization that this package builds upon.

**Why the fork?**  
i420n extends i69n with Flutter-specific features like `Locale` objects, `supportedLocales` lists, and locale registry/lookup utilities—features commonly needed for `MaterialApp` integration but not present in the original package.

## License

BSD License - see [LICENSE](LICENSE)
