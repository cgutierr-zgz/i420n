// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Example demonstrating basic usage of the i420n internationalization package.
///
/// This example shows:
/// - Loading and using message bundles
/// - Accessing locale information
/// - Using pluralization
/// - Working with nested messages
library;

import 'package:i420n/i420n.dart';

import 'exampleMessages.i420n.dart';
import 'exampleMessages_en_GB.i420n.dart';

void main() {
  print('Hello from i420n!');
  print('');

  // Register all supported locales
  registerExampleMessagesLocale(ExampleMessages_en_GB());

  print('=== Basic Usage ===');
  print('Some English:');
  var m = ExampleMessages();
  print(m.generic.ok);
  print(m.generic.done);
  print(m.invoice.help);
  print(m.apples.count(0));
  print(m.apples.count(1));
  print(m.apples.count(2));
  print(m.apples.count(5));

  print('');
  print('=== Locale Information ===');
  print('Language code: ${m.languageCode}');
  print('Locale name: ${m.localeName}');
  print('Flutter locale: ${m.flutterLocale}');

  print('');
  print('=== Supported Locales ===');
  print('Registered locales: $exampleMessagesSupportedLocales');
  print('Flutter locales: $exampleMessagesSupportedLocalesFlutter');

  print('');
  print('=== Finding Locales ===');
  // Find a locale by Locale object
  final enGb = findExampleMessagesByLocale(const Locale('en', 'GB'));
  if (enGb != null) {
    print('Found en_GB: ${enGb.localeName}');
    print('en_GB done message: ${enGb.generic.done}');
  }

  print('');
  print('=== Pluralization ===');
  print('0 apples: ${m.apples.count(0)}');
  print('1 apple: ${m.apples.count(1)}');
  print('2 apples: ${m.apples.count(2)}');
  print('5 apples: ${m.apples.count(5)}');
}
