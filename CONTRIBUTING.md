# Contributing to i420n

First off, thank you for considering contributing to i420n! 🎉

## Code of Conduct

This project and everyone participating in it is governed by our commitment to providing a welcoming and inclusive experience for everyone.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates. When you create a bug report, include as many details as possible using the bug report template.

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. Create an issue and provide:

- A clear and descriptive title
- A detailed description of the proposed enhancement
- Examples of how it would be used
- Why this enhancement would be useful

### Pull Requests

1. Fork the repo and create your branch from `master`
2. If you've added code that should be tested, add tests
3. If you've changed APIs, update the documentation
4. Ensure the test suite passes
5. Make sure your code follows the existing style
6. Issue that pull request!

## Development Setup

1. Clone your fork:
   ```bash
   git clone https://github.com/YOUR_USERNAME/i420n.git
   cd i420n
   ```

2. Install dependencies:
   ```bash
   dart pub get
   ```

3. Run the code generator:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. Run tests:
   ```bash
   dart test
   ```

## Style Guide

- Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Run `dart format .` before committing
- Run `dart analyze` to check for issues
- Keep commits atomic and write meaningful commit messages

## Running Tests

```bash
# Run all tests
dart test

# Run a specific test file
dart test test/i420n_test.dart

# Run with coverage
dart test --coverage=coverage
```

## Building

```bash
# Generate code from YAML files
dart run build_runner build --delete-conflicting-outputs

# Watch mode for development
dart run build_runner watch --delete-conflicting-outputs
```

## Questions?

Feel free to open an issue with your question!
