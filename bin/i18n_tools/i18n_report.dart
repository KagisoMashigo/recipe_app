// 🎯 Dart imports:
import 'dart:convert';
import 'dart:io';

const _kAsset = './assets/i18n';

/// generate a report comparing the languages to the primary language: english
Future<void> reportLanguages() async {
  print('Loading primary language: 🇬🇧 en');
  final loadEn = await loadLanguage('en');
  print('Loading primary topics and keys');
  final primaryLanguage = LanguageTranslation.of(loadEn);

  print('Loading secondary languages...');
  print(' 🇫🇷 fr...');
  final loadFr = await loadLanguage('fr');
  print(' 🇪🇸 es..');
  final loadEs = await loadLanguage('es');

  print('Loading secondary topics and keys');
  final frLanguage = LanguageTranslation.of(loadFr, 'fr');
  final esLanguage = LanguageTranslation.of(loadEs, 'es');

  print('evaluating 🇫🇷 fr package:');
  evaluateTopics(primaryLanguage, frLanguage);

  print('****\n');
  print('evaluating 🇪🇸 es package');
  evaluateTopics(primaryLanguage, esLanguage);
}

void evaluateTopics(
    LanguageTranslation primary, LanguageTranslation secondary) {
  final missing = primary.topics.keys
      .where(
        (topic) => !secondary.topics.containsKey(topic),
      )
      .toList();

  final extras = secondary.topics.keys
      .where(
        (topic) => !primary.topics.containsKey(topic),
      )
      .toList();

  print('\t ${extras.length} extra topic(s) on ${secondary.packageName}:');
  if (extras.isNotEmpty) {
    extras.forEach(
      (item) => print('\t 🗑️ [$item]'),
    );
  } else {
    print('\t 🤙');
  }

  print('\t ${missing.length} missing topic(s) on ${secondary.packageName}:');
  if (missing.isNotEmpty) {
    missing.forEach(
      (item) => print('\t 🚨 [$item]'),
    );
  } else {
    print('\t 🤙');
  }

  if (missing.isEmpty && extras.isEmpty) {
    evaluateKeys(primary, secondary);
  }
}

void evaluateKeys(LanguageTranslation primary, LanguageTranslation secondary) {
  // checks for missing keys
  primary.topics.keys.forEach((topic) {
    final primaryKeys = primary.topics[topic];
    final secondaryKeys = secondary.topics[topic];

    if (!secondaryKeys.containsAll(primaryKeys)) {
      print('\t 🚨 missing the following key(s) on $topic topic:');

      primaryKeys
          .where(
            (element) => !secondaryKeys.contains(element),
          )
          .forEach(
            (item) => print('\t\t 🚨  missing key: \"$item\"'),
          );
    }
  });

  secondary.topics.keys.forEach((topic) {
    final primaryKeys = primary.topics[topic];
    final secondaryKeys = secondary.topics[topic];

    if (!primaryKeys.containsAll(secondaryKeys)) {
      print(
          '\t\tThe following key(s) have to be removed from \"$topic\" topic:');

      secondaryKeys
          .where(
            (element) => !primaryKeys.contains(element),
          )
          .forEach(
            (item) => print('\t\t 🗑️  key: \"$item\"'),
          );
    }
  });
}

Future<Map<String, dynamic>> loadLanguage(String language) async {
  try {
    final file = File('$_kAsset/$language.json');
    final text = await file.readAsString();

    return json.decode(text);
  } catch (_) {
    rethrow;
  }
}

class LanguageTranslation {
  LanguageTranslation(String name)
      : topics = {},
        packageName = name ?? 'en';

  Map<String, Set<String>> topics;

  final String packageName;

  factory LanguageTranslation.of(Map<String, dynamic> translation,
      [String title]) {
    final package = LanguageTranslation(title);

    translation.forEach((key, value) {
      package.topics.putIfAbsent(key, () => value.keys.toSet());
    });

    return package;
  }
}
