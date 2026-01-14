// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'package:i420n/i420n.dart' as i420n;

import 'exampleMessages.i420n.dart';
import 'exampleMessages_cs.i420n.dart' deferred as cs;
import 'exampleMessages_en_GB.i420n.dart';

void main() async {
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
  print('=== Deferred Loading ===');
  print('Asynchronous load of Czech messages:');
  await cs.loadLibrary();

  // Register Czech after loading
  cs.registerExampleMessagesLocale(cs.ExampleMessages_cs());

  print('Some Czech:');
  m = cs.ExampleMessages_cs();
  print(m.generic.ok); // inherited from default
  print(m.generic.done);
  print(m.invoice.help);
  print(m.apples.count(0));
  print(m.apples.count(1));
  print(m.apples.count(2));
  print(m.apples.count(5));

  print('');
  print('=== Dynamic Access ===');
  print('Access messages at runtime, with plain old string keys');
  print('Static:  ${m.generic.ok}');
  print('Dynamic: ${m.generic['ok']}');
  print('Or even: ${m['generic.ok']}');

  print('');
  print('=== Locale Lookup ===');
  // Find by locale name
  var found = getExampleMessagesByLocale('en');
  print('Found by locale name "en": ${found?.localeName}');

  // Find by Flutter Locale
  var foundByFlutter = findExampleMessagesByLocale(i420n.Locale('en', 'GB'));
  print('Found by Flutter Locale(en, GB): ${foundByFlutter?.localeName}');

  // Fallback to language when country not found
  var fallback = findExampleMessagesByLocale(i420n.Locale('en', 'AU'));
  print('Fallback for Locale(en, AU): ${fallback?.localeName}');

  print('');
  print('=== Custom Plural Rules ===');
  // Override plurals for Czech or register support for your own language:
  i420n.registerResolver('cs', (int count, i420n.QuantityType type) {
    if (type == i420n.QuantityType.cardinal && count == 1) {
      return i420n.QuantityCategory.one;
    }
    return i420n.QuantityCategory.other;
  });

  // See:
  // http://cldr.unicode.org/index/cldr-spec/plural-rules
  // https://www.unicode.org/cldr/charts/latest/supplemental/language_plural_rules.html
}
