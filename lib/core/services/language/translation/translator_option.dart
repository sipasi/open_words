enum TranslatorOption {
  google(name: 'Google'),
  deepL(name: 'DeepL'),
  reverso(name: 'Reverso');

  final String name;

  const TranslatorOption({required this.name});
}
