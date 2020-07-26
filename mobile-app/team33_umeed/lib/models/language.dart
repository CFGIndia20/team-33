class Language {
  final int id;
  final String name;
  final String flag;
  final String languageCode;

  Language({this.id, this.name, this.flag, this.languageCode});
  static List<Language> languagesList() {
    return <Language>[
      Language(id: 1, name: 'English', flag: '🇺🇸', languageCode: 'en'),
      Language(id: 2, name: 'Hindi', flag: '🇮🇳', languageCode: 'hi'),
      // Language(id: 3, name: 'Farsi', flag: '🇮🇷', languageCode: 'fa'),
      // Language(id: 4, name: 'Arabic', flag: '🇸🇦', languageCode: 'ar'),
    ];
  }
}
