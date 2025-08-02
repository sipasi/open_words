enum TranslatorBrand {
  google(name: 'Google'),
  deepL(name: 'DeepL'),
  reverso(name: 'Reverso');

  final String name;

  const TranslatorBrand({required this.name});
}
