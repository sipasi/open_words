abstract class ReadonlyWordPart {
  final int id;
  final String text;

  bool get disabled;

  ReadonlyWordPart({required this.id, required this.text});
}

class WordPart extends ReadonlyWordPart {
  bool _disabled;

  WordPart({required super.id, required super.text}) : _disabled = false;
  WordPart._({required super.id, required super.text, required bool disabled}) : _disabled = disabled;

  @override
  bool get disabled => _disabled;

  void disable() => _disabled = true;
  void enable() => _disabled = false;

  WordPart copyWith({required bool disable}) {
    return WordPart._(id: id, text: text, disabled: disable);
  }
}
