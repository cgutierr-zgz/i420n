# Add New Feature to Code Generator

Use this prompt to add new features to the i420n code generator.

## Instructions

The code generator is in `lib/src/i420n_impl.dart`. Key functions:

- `_generateDartClass()` - Main generation logic
- `_generateFlutterWidgets()` - Flutter-specific code (when `flutter: true`)
- `_recreateObjectContent()` - Handles message content generation

## Before Making Changes

1. Understand the current YAML → Dart transformation
2. Check `lib/src/model.dart` for data structures
3. Review existing generated files in `example/` for patterns

## After Making Changes

```bash
dart run build_runner build --delete-conflicting-outputs
dart test
dart pub global run pana .
```

## Common Feature Requests

- **New YAML syntax**: Update model.dart parsing + i420n_impl.dart generation
- **New generated utilities**: Add to _generateDartClass()
- **Flutter features**: Add to _generateFlutterWidgets() (guarded by flutter option)

## Example Request

"Add support for linked translations using @:path.to.key syntax"
