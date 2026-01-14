library i420n;

import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:yaml/yaml.dart';

part 'i420n_model.dart';

Pattern twoCharsLower = RegExp('^[a-z]{2,3}\$');
Pattern twoCharsUpper = RegExp('^[A-Z]{2,3}\$');

String generateDartContentFromYaml(ClassMeta meta, String yamlContent, BuilderOptions options) {
  var messages = (loadYaml(yamlContent) as YamlMap);

  var todoList = <TodoItem>[];

  prepareTodoList(null, null, todoList, messages, meta, options);

  // Check if Flutter widgets should be generated (default: false for backward compatibility)
  final generateFlutter = options.config['flutter'] == true;

  var output = StringBuffer();

  output.writeln(
      '// ignore_for_file: unused_element, unused_field, camel_case_types, annotate_overrides, prefer_single_quotes, library_private_types_in_public_api');
  output.writeln('// GENERATED FILE, do not edit!');
  output.writeln('import \'package:i420n/i420n.dart\' as i420n;');

  // Add Flutter import for default locale (needed for InheritedWidget)
  if (meta.isDefault! && generateFlutter) {
    output.writeln('import \'package:flutter/widgets.dart\';');
  }

  if (meta.defaultFileName != null) {
    output.writeln('import \'${meta.defaultFileName}\';');
  }

  // Auto-registration for non-default locales
  if (!meta.isDefault!) {
    output.writeln('');
    output.writeln('/// Auto-register this locale when the file is imported.');
    output.writeln('/// This makes it available via [${_firstCharLower(meta.defaultObjectName!)}SupportedLocales]');
    output.writeln('/// and lookup functions without manual registration.');
    output.writeln('final _${_firstCharLower(meta.objectName!)}Registered = () {');
    output.writeln('  register${meta.defaultObjectName}Locale(const ${meta.objectName}());');
    output.writeln('  return true;');
    output.writeln('}();');
  }

  String? i = todoList.first.flagValue("import");
  if (i != null) {
    List<String> imports = i.split(",");
    for (String import in imports) {
      import = import.trim();
      if (import.isNotEmpty) {
        output.writeln('import \'${import}\';');
      }
    }
  }

  String nullableChar = todoList.first.hasFlag('prenullsafe') ? '' : '?';

  var lang = todoList.first.flagValue("language") ?? meta.languageCode;

  output.writeln('');
  output.writeln('String get _languageCode => \'${lang}\';');
  output.writeln('String get _localeName => \'${meta.localeName}\';');
  output.writeln('');

  if (meta.isDefault!) {
    output.writeln('/// List of all supported locales for ${meta.objectName}.');
    output.writeln('/// Add your locale bundles to this list to make them discoverable.');
    output.writeln(
        'final List<${meta.objectName}> _${_firstCharLower(meta.objectName!)}SupportedLocales = [const ${meta.objectName}()];');
    output.writeln('');
    output.writeln('/// Returns a list of all supported locales (locale names) for ${meta.objectName}.');
    output.writeln(
        'List<String> get ${_firstCharLower(meta.objectName!)}SupportedLocales => _${_firstCharLower(meta.objectName!)}SupportedLocales.map((m) => m.localeName).toList();');
    output.writeln('');
    output.writeln('/// Add a locale bundle to the list of supported locales.');
    output.writeln('void register${meta.objectName}Locale(${meta.objectName} locale) {');
    output.writeln(
        '  if (!_${_firstCharLower(meta.objectName!)}SupportedLocales.any((m) => m.localeName == locale.localeName)) {');
    output.writeln('    _${_firstCharLower(meta.objectName!)}SupportedLocales.add(locale);');
    output.writeln('  }');
    output.writeln('}');
    output.writeln('');
    output.writeln('/// Get a locale bundle by locale name. Returns null if not found.');
    output.writeln('${meta.objectName}? get${meta.objectName}ByLocale(String localeName) {');
    output.writeln('  for (final m in _${_firstCharLower(meta.objectName!)}SupportedLocales) {');
    output.writeln('    if (m.localeName == localeName) return m;');
    output.writeln('  }');
    output.writeln('  return null;');
    output.writeln('}');
    output.writeln('');
    // Flutter-specific helpers
    output.writeln('// **************************************************************************');
    output.writeln('// Flutter-specific locale utilities');
    output.writeln('// **************************************************************************');
    output.writeln('');
    output.writeln(
        '/// Returns the list of supported Flutter [Locale] objects for use with [MaterialApp.supportedLocales].');
    output.writeln('List<i420n.Locale> get ${_firstCharLower(meta.objectName!)}SupportedLocalesFlutter =>');
    output.writeln('    _${_firstCharLower(meta.objectName!)}SupportedLocales.map((m) => m.flutterLocale).toList();');
    output.writeln('');
    output.writeln('/// Find a message bundle by Flutter [Locale]. Returns null if not found.');
    output.writeln('/// Tries exact match first, then falls back to language-only match.');
    output.writeln('${meta.objectName}? find${meta.objectName}ByLocale(i420n.Locale locale) {');
    output.writeln(
        '  final fullMatch = \'\${locale.languageCode}\${locale.countryCode != null ? \'_\${locale.countryCode}\' : \'\'}\';');
    output.writeln('  // Try exact match first (e.g., en_GB)');
    output.writeln('  for (final m in _${_firstCharLower(meta.objectName!)}SupportedLocales) {');
    output.writeln('    if (m.localeName == fullMatch) return m;');
    output.writeln('  }');
    output.writeln('  // Fall back to language-only match (e.g., en)');
    output.writeln('  for (final m in _${_firstCharLower(meta.objectName!)}SupportedLocales) {');
    output.writeln('    if (m.languageCode == locale.languageCode) return m;');
    output.writeln('  }');
    output.writeln('  return null;');
    output.writeln('}');
    output.writeln('');

    // Flutter InheritedWidget and context extension (only if flutter: true in build.yaml)
    if (generateFlutter) {
      _generateFlutterWidgets(output, meta);
    }
  }
  output.writeln('');
  output.writeln(
      'String _plural(int count, {String$nullableChar zero, String$nullableChar one, String$nullableChar two, String$nullableChar few, String$nullableChar many, String$nullableChar other}) =>');
  output.writeln('\ti420n.plural(count, _languageCode, zero:zero, one:one, two:two, few:few, many:many, other:other);');
  output.writeln(
      'String _ordinal(int count, {String$nullableChar zero, String$nullableChar one, String$nullableChar two, String$nullableChar few, String$nullableChar many, String$nullableChar other}) =>');
  output
      .writeln('\ti420n.ordinal(count, _languageCode, zero:zero, one:one, two:two, few:few, many:many, other:other);');
  output.writeln(
      'String _cardinal(int count, {String$nullableChar zero, String$nullableChar one, String$nullableChar two, String$nullableChar few, String$nullableChar many, String$nullableChar other}) =>');
  output
      .writeln('\ti420n.cardinal(count, _languageCode, zero:zero, one:one, two:two, few:few, many:many, other:other);');
  output.writeln('');

  for (var todo in todoList) {
    renderTodoItem(todo, output);
    output.writeln('');
  }
  try {
    var formatter = DartFormatter(
      languageVersion: DartFormatter.latestShortStyleLanguageVersion,
    );
    return formatter.format(output.toString());
  } catch (e) {
    print(
        'Cannot format ${meta.languageCode}, ${meta.defaultObjectName} messages. You might need to escape some special characters with a backslash. Please investigate generated class.');
    return output.toString();
  }
}

ClassMeta generateMessageObjectName(String fileName) {
  var name = fileName.replaceAll('.i420n.yaml', '');

  var nameParts = name.split('_');
  if (nameParts.isEmpty) {
    throw Exception(_renderFileNameError(name));
  }

  var result = ClassMeta();

  result.defaultObjectName = _firstCharUpper(nameParts[0]);

  if (nameParts.length == 1) {
    result.objectName = result.defaultObjectName;
    result.isDefault = true;
    result.languageCode = 'en';
    result.localeName = 'en';
    return result;
  } else {
    result.defaultFileName = '${nameParts[0]}.i420n.dart';
    result.isDefault = false;

    if (nameParts.length > 3) {
      throw Exception(_renderFileNameError(name));
    }
    if (nameParts.length >= 2) {
      var languageCode = nameParts[1];
      if (twoCharsLower.allMatches(languageCode).length != 1) {
        throw Exception(
            'Wrong language code $languageCode in file name $fileName. Language code must match $twoCharsLower');
      }
      result.languageCode = languageCode;
      result.localeName = languageCode;
    }
    if (nameParts.length == 3) {
      var countryCode = nameParts[2];
      if (twoCharsUpper.allMatches(countryCode).length != 1) {
        throw Exception(
            'Wrong country code $countryCode in file name $fileName. Country code must match $twoCharsUpper');
      }
      result.localeName = '${result.languageCode}_$countryCode';
    }
    result.objectName = '${result.defaultObjectName}_${result.localeName}';
    return result;
  }
}

void renderTodoItem(TodoItem todo, StringBuffer output) {
  var meta = todo.meta;

  String? implements = todo.flagValue("implements");

  if (meta.isDefault!) {
    String i = "";
    if (implements != null) {
      i = ", $implements";
    }
    output.writeln('class ${meta.objectName} implements i420n.I420nMessageBundle$i {');
  } else {
    String i = "";
    if (implements != null) {
      i = " implements $implements";
    }
    output.writeln('class ${meta.objectName} extends ${meta.defaultObjectName} $i {');
  }

  if (meta.parent == null) {
    output.writeln('\tconst ${meta.objectName}();');
    output.writeln('\tString get languageCode => _languageCode;');
    output.writeln('\tString get localeName => _localeName;');
    output.writeln('\ti420n.Locale get flutterLocale => i420n.Locale.fromLocaleName(localeName);');
  } else {
    output.writeln('\tfinal ${meta.parent!.objectName} _parent;');
    if (meta.isDefault!) {
      output.writeln('\tconst ${meta.objectName}(this._parent);');
      output.writeln('\tString get languageCode => _parent.languageCode;');
      output.writeln('\tString get localeName => _parent.localeName;');
      output.writeln('\ti420n.Locale get flutterLocale => _parent.flutterLocale;');
    } else {
      output.writeln('\tconst ${meta.objectName}(this._parent):super(_parent);');
    }
  }

  renderTodoItemProperties(todo, output);

  renderTodoItemMapOperator(todo, output);

  output.writeln('}');
}

const _reserved = ['_i420n', '_i420n_language', '_i420n_import'];

void renderTodoItemMapOperator(TodoItem todo, StringBuffer output) {
  output.writeln('\tObject operator[](String key) {');

  final shouldDisableMap = todo.hasFlag('nomap') || (!todo.hasFlag('map') && todo.hasGlobalFlag('nomap'));
  final shouldDisableTraverse =
      todo.hasFlag('notraverse') || (!todo.hasFlag('traverse') && todo.hasGlobalFlag('notraverse'));

  if (shouldDisableMap && shouldDisableTraverse) {
    output.writeln(
        '\t\tthrow Exception(\'[] operator is disabled in ${todo.path}, see _i420n: nomap, notraverse flag.\');');
    output.writeln('\t}');
    return;
  }

  if (!shouldDisableTraverse) {
    output.writeln('\t\tvar index = key.indexOf(\'.\');');
    output.writeln('\t\tif (index > 0) {');
    output.writeln('\t\t\treturn (this[key.substring(0,index)] as i420n.I420nMessageBundle)[key.substring(index+1)];');
    output.writeln('\t\t}');
  }

  if (shouldDisableMap) {
    output.writeln('\t\tthrow Exception(\'[] operator is disabled in ${todo.path}, see _i420n: nomap flag.\');');
  } else {
    output.writeln('\t\tswitch(key) {');
    todo.content.forEach((k, v) {
      if (!_reserved.contains(k)) {
        String key = k;
        if (key.contains('(')) {
          key = key.substring(0, key.indexOf('('));
        }
        output.writeln('\t\t\tcase \'$key\': return $key;');
      }
    });
    if (todo.meta.isDefault!) {
      if (todo.hasInheritedFlag('nothrow')) {
        output.writeln('\t\t\tdefault: throw Exception(\'Message \$key doesn\\\'t exist in \$this\');');
      } else {
        output.writeln('\t\t\tdefault: return key;');
      }
    } else {
      output.writeln('\t\t\tdefault: return super[key];');
    }
    output.writeln('\t\t}');
  }
  output.writeln('\t}');
}

void renderTodoItemProperties(TodoItem todo, StringBuffer output) {
  var escapeFunction = escapeDartString;
  if (todo.hasFlag('noescape')) {
    escapeFunction = (String? s) => s;
  }
  todo.content.forEach((k, v) {
    if (!_reserved.contains(k)) {
      if (v is YamlMap) {
        var prefix = _firstCharUpper(k);
        var child = todo.meta.nest(prefix);
        output.writeln('\t${child.objectName} get $k => ${child.objectName}(this);');
      } else {
        if (k.contains('(')) {
          // function
          output.writeln('\tString $k => "${escapeFunction(v)}";');
        } else {
          if (k.contains('.')) {
            throw Exception('Your message key cannot contain a dot, see $k');
          }
          output.writeln('\tString get $k => "${escapeFunction(v)}";');
        }
      }
    }
  });
}

void prepareTodoList(
  String? prefix,
  TodoItem? parent,
  List<TodoItem> todoList,
  YamlMap messages,
  ClassMeta name,
  BuilderOptions? options,
) {
  var todo = TodoItem(prefix, parent, name, messages, options: options);
  todoList.add(todo);

  messages.forEach((k, v) {
    if (v is YamlMap) {
      var prefix = _firstCharUpper(k);
      prepareTodoList(k, todo, todoList, v, name.nest(prefix), options);
    }
  });
}

String _firstCharUpper(String s) {
  return s.replaceRange(0, 1, s[0].toUpperCase());
}

String _firstCharLower(String s) {
  return s.replaceRange(0, 1, s[0].toLowerCase());
}

String _renderFileNameError(String name) {
  return 'Wrong file name: "$name"';
}

String? escapeDartString(String? string) {
  if (string == null) return null;
  if (string.isEmpty) return string;

  var sb = StringBuffer();
  // Iterate over the Unicode code points (runes)
  for (var c in string.runes) {
    switch (c) {
      case 9: // \t (Horizontal Tab)
        sb.write('\\t');
        break;
      case 10: // \n (Line Feed)
        sb.write('\\n');
        break;
      case 13: // \r (Carriage Return)
        sb.write('\\r');
        break;
      default:
        // For all other code points, convert the code point back to its string representation
        // This correctly handles both single-unit characters and surrogate pairs (emojis)
        sb.writeCharCode(c);
        break;
    }
  }
  return sb.toString();
}

/// Generate Flutter-specific widgets: LocaleSettings, TranslationProvider, and global accessor
void _generateFlutterWidgets(StringBuffer output, ClassMeta meta) {
  final className = meta.objectName!;
  final lowerName = _firstCharLower(className);

  output.writeln('// **************************************************************************');
  output.writeln('// Flutter integration');
  output.writeln('// **************************************************************************');
  output.writeln('');

  // Global translation accessor
  output.writeln('/// Global accessor for translations. Use after calling [${className}LocaleSettings.init].');
  output.writeln('///');
  output.writeln('/// Usage:');
  output.writeln('/// ```dart');
  output.writeln("/// String a = $lowerName.greeting.hello('World');");
  output.writeln('/// ```');
  output.writeln('$className get $lowerName => ${className}LocaleSettings.instance.currentTranslations;');
  output.writeln('');

  // LocaleSettings class
  output.writeln('/// Manages the current locale and provides methods to change it.');
  output.writeln('///');
  output.writeln('/// Initialize in main():');
  output.writeln('/// ```dart');
  output.writeln('/// void main() {');
  output.writeln('///   WidgetsFlutterBinding.ensureInitialized();');
  output.writeln('///   ${className}LocaleSettings.init();');
  output.writeln('///   // or: ${className}LocaleSettings.useDeviceLocale();');
  output.writeln('///   runApp(TranslationProvider(child: MyApp()));');
  output.writeln('/// }');
  output.writeln('/// ```');
  output.writeln('class ${className}LocaleSettings {');
  output.writeln('  ${className}LocaleSettings._();');
  output.writeln('');
  output.writeln('  static final ${className}LocaleSettings instance = ${className}LocaleSettings._();');
  output.writeln('');
  output.writeln('  /// The current translations. Defaults to the base locale.');
  output.writeln('  $className _currentTranslations = const $className();');
  output.writeln('  $className get currentTranslations => _currentTranslations;');
  output.writeln('');
  output.writeln('  /// The current locale.');
  output.writeln('  i420n.Locale get currentLocale => _currentTranslations.flutterLocale;');
  output.writeln('');
  output.writeln('  /// Listeners that are notified when the locale changes.');
  output.writeln('  final List<void Function($className)> _listeners = [];');
  output.writeln('');
  output.writeln('  /// Initialize with the default locale.');
  output.writeln('  static void init() {');
  output.writeln('    instance._currentTranslations = const $className();');
  output.writeln('  }');
  output.writeln('');
  output.writeln('  /// Set locale based on device settings.');
  output.writeln('  /// Call after WidgetsFlutterBinding.ensureInitialized()');
  output.writeln('  static void useDeviceLocale() {');
  output.writeln('    final platformDispatcher = WidgetsBinding.instance.platformDispatcher;');
  output.writeln('    final deviceLocales = platformDispatcher.locales;');
  output.writeln('    if (deviceLocales.isNotEmpty) {');
  output.writeln('      final deviceLocale = deviceLocales.first;');
  output.writeln('      final i420nLocale = i420n.Locale(deviceLocale.languageCode, deviceLocale.countryCode);');
  output.writeln('      final messages = find${className}ByLocale(i420nLocale);');
  output.writeln('      if (messages != null) {');
  output.writeln('        instance._setTranslations(messages);');
  output.writeln('        return;');
  output.writeln('      }');
  output.writeln('    }');
  output.writeln('    // Fall back to default');
  output.writeln('    instance._currentTranslations = const $className();');
  output.writeln('  }');
  output.writeln('');
  output.writeln('  /// Set locale by locale name string (e.g., "en", "es", "pt_BR").');
  output.writeln('  static void setLocaleRaw(String localeCode) {');
  output.writeln('    final messages = get${className}ByLocale(localeCode);');
  output.writeln('    if (messages != null) {');
  output.writeln('      instance._setTranslations(messages);');
  output.writeln('    }');
  output.writeln('  }');
  output.writeln('');
  output.writeln('  /// Set locale by Locale object.');
  output.writeln('  static void setLocale(i420n.Locale locale) {');
  output.writeln('    final messages = find${className}ByLocale(locale);');
  output.writeln('    if (messages != null) {');
  output.writeln('      instance._setTranslations(messages);');
  output.writeln('    }');
  output.writeln('  }');
  output.writeln('');
  output.writeln('  void _setTranslations($className translations) {');
  output.writeln('    _currentTranslations = translations;');
  output.writeln('    for (final listener in _listeners) {');
  output.writeln('      listener(translations);');
  output.writeln('    }');
  output.writeln('  }');
  output.writeln('');
  output.writeln('  /// Add a listener that is called when locale changes.');
  output.writeln('  void addListener(void Function($className) listener) {');
  output.writeln('    _listeners.add(listener);');
  output.writeln('  }');
  output.writeln('');
  output.writeln('  /// Remove a listener.');
  output.writeln('  void removeListener(void Function($className) listener) {');
  output.writeln('    _listeners.remove(listener);');
  output.writeln('  }');
  output.writeln('');
  output.writeln('  /// List of supported locales for MaterialApp.');
  output.writeln('  static List<Locale> get supportedLocales =>');
  output
      .writeln('      ${lowerName}SupportedLocalesFlutter.map((l) => Locale(l.languageCode, l.countryCode)).toList();');
  output.writeln('}');
  output.writeln('');

  // TranslationProvider widget
  output.writeln('/// Provider widget that rebuilds when locale changes.');
  output.writeln('/// Wrap your app with this.');
  output.writeln('///');
  output.writeln('/// ```dart');
  output.writeln('/// runApp(TranslationProvider(child: MyApp()));');
  output.writeln('/// ```');
  output.writeln('class TranslationProvider extends StatefulWidget {');
  output.writeln('  final Widget child;');
  output.writeln('');
  output.writeln('  const TranslationProvider({required this.child, super.key});');
  output.writeln('');
  output.writeln('  @override');
  output.writeln('  State<TranslationProvider> createState() => _TranslationProviderState();');
  output.writeln('');
  output.writeln('  /// Get the current translations from context.');
  output.writeln('  static $className of(BuildContext context) {');
  output.writeln('    return context.dependOnInheritedWidgetOfExactType<_InheritedTranslations>()!.translations;');
  output.writeln('  }');
  output.writeln('');
  output.writeln('  /// Get the current Flutter Locale from context.');
  output.writeln('  static Locale flutterLocale(BuildContext context) {');
  output.writeln('    final t = of(context);');
  output.writeln('    return Locale(t.flutterLocale.languageCode, t.flutterLocale.countryCode);');
  output.writeln('  }');
  output.writeln('}');
  output.writeln('');
  output.writeln('class _TranslationProviderState extends State<TranslationProvider> {');
  output.writeln('  $className _translations = ${className}LocaleSettings.instance.currentTranslations;');
  output.writeln('');
  output.writeln('  @override');
  output.writeln('  void initState() {');
  output.writeln('    super.initState();');
  output.writeln('    ${className}LocaleSettings.instance.addListener(_onLocaleChanged);');
  output.writeln('  }');
  output.writeln('');
  output.writeln('  @override');
  output.writeln('  void dispose() {');
  output.writeln('    ${className}LocaleSettings.instance.removeListener(_onLocaleChanged);');
  output.writeln('    super.dispose();');
  output.writeln('  }');
  output.writeln('');
  output.writeln('  void _onLocaleChanged($className translations) {');
  output.writeln('    setState(() {');
  output.writeln('      _translations = translations;');
  output.writeln('    });');
  output.writeln('  }');
  output.writeln('');
  output.writeln('  @override');
  output.writeln('  Widget build(BuildContext context) {');
  output.writeln('    return _InheritedTranslations(');
  output.writeln('      translations: _translations,');
  output.writeln('      child: widget.child,');
  output.writeln('    );');
  output.writeln('  }');
  output.writeln('}');
  output.writeln('');
  output.writeln('class _InheritedTranslations extends InheritedWidget {');
  output.writeln('  final $className translations;');
  output.writeln('');
  output.writeln('  const _InheritedTranslations({');
  output.writeln('    required this.translations,');
  output.writeln('    required super.child,');
  output.writeln('  });');
  output.writeln('');
  output.writeln('  @override');
  output.writeln('  bool updateShouldNotify(_InheritedTranslations oldWidget) {');
  output.writeln('    return translations.localeName != oldWidget.translations.localeName;');
  output.writeln('  }');
  output.writeln('}');
  output.writeln('');

  // BuildContext extension
  output.writeln('/// Extension on [BuildContext] for easy access to translations.');
  output.writeln('extension ${className}BuildContextExtension on BuildContext {');
  output.writeln('  /// Get the current translations from the widget tree.');
  output.writeln('  $className get $lowerName => TranslationProvider.of(this);');
  output.writeln('');
  output.writeln('  /// Get the current Flutter Locale from the widget tree.');
  output.writeln('  Locale get ${lowerName}Locale => TranslationProvider.flutterLocale(this);');
  output.writeln('}');
  output.writeln('');
}
