import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DemoLocalization {
  final Locale locale;
  DemoLocalization(this.locale);

  static DemoLocalization of(BuildContext context) {
    return Localizations.of<DemoLocalization>(context, DemoLocalization);
  }

  Map<String, String> _localizedValues;

  Future load() async {
    String jsonValues =
        await rootBundle.loadString('lib/lang/${locale.languageCode}.json');

    Map<String, dynamic> mappedJson = json.decode(jsonValues);
    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String getTranslatedValues(String key) {
    return _localizedValues[key];
  }

  static const LocalizationsDelegate<DemoLocalization> delegate =
      _DemoLocalizationDelegate();
}

class _DemoLocalizationDelegate
    extends LocalizationsDelegate<DemoLocalization> {
  const _DemoLocalizationDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en', 'hi', 'fa', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<DemoLocalization> load(Locale locale) async {
    DemoLocalization localization = new DemoLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(_DemoLocalizationDelegate old) => false;
}
