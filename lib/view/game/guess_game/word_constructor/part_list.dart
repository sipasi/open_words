import 'word_part.dart';

class PartList {
  final List<WordPart> _parts;

  int get length => _parts.length;

  ReadonlyWordPart operator [](int index) => _parts[index];

  PartList(List<String> parts) : _parts = _convert(parts);

  WordPart _byId(int id) => _parts.firstWhere((part) => part.id == id);

  static List<WordPart> _convert(List<String> parts) {
    return List.generate(
      parts.length,
      (index) => WordPart(id: index, text: parts[index]),
    );
  }
}

class AnswerPartList extends PartList {
  AnswerPartList(super.parts);

  String get constructed => _parts.map((e) => e.text).join();

  void add(WordPart part) => _parts.add(part);
  void remove(int id) => _parts.remove(_byId(id));

  bool matchWith(String text) {
    return text == constructed;
  }

  void reset() => _parts.clear();
}

class VariantPartList extends PartList {
  VariantPartList(super.parts);

  bool get allDisabled => _parts.every((element) => element.disabled);

  void enableBy(int id) => _byId(id).enable();
  void disableBy(int id) => _byId(id).disable();

  WordPart enabledCopyBy(int id) => _byId(id).copyWith(disable: false);

  void enableAll() {
    for (var element in _parts) {
      element.enable();
    }
  }
}
