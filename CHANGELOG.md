# Changelog

## 1.0.0

Initial release of i420n, a fork of [i69n](https://github.com/fnx-io/i69n) by [fnx.io](https://fnx.io) with enhanced Flutter support.

### New Features

- **Auto-Registration**
  - Locales are automatically registered when imported — no manual setup needed!
  - Just import your locale files and they're ready to use
  - Manual registration only required for deferred/lazy loading

- **Flutter Context Integration** (`flutter: true` in build.yaml)
  - `XxxLocaleSettings` class
    - `useDeviceLocale()` - set locale from device
    - `setLocaleRaw(String)` - set by locale string
    - `setLocale(Locale)` - set by Locale object
    - `supportedLocales` - for MaterialApp
  - `TranslationProvider` widget - wrap your app, auto-rebuilds on locale change
  - Global accessor `xxx`
  - `context.xxx` extension for easy access

- **Flutter Locale Support**
  - `flutterLocale` getter on all message bundles
  - `Locale` class compatible with Flutter's Locale
  - `supportedLocalesFlutter` for `MaterialApp.supportedLocales`
  - `findByLocale(Locale)` with language fallback

- **Locale Registry**
  - `registerXxxLocale()` to register locale bundles (for deferred loading)
  - `getXxxByLocale(String)` to find by locale name
  - `xxxSupportedLocales` getter for registered locale names

- **Breaking Changes from i69n**
  - Package renamed from `i69n` to `i420n`
  - File extension changed from `.i69n.yaml` to `.i420n.yaml`
  - Flags changed from `_i69n` to `_i420n`
  - Interface renamed from `I69nMessageBundle` to `I420nMessageBundle`

### Inherited from i69n 3.4.0

- Global configuration support for `nomap` and `notraverse` flags via `build.yaml`
- `notraverse` flag to control dot notation access
- Local override support with `map`/`traverse` flags
- Emoji support in translations
- Null safety
- Custom imports and types
- Deferred loading support
