class WordPart {
  final int id;
  final String text;

  WordPart({required this.id, required this.text});

  WordPart copyWith({int? id, String? text}) {
    return WordPart(id: id ?? this.id, text: text ?? this.text);
  }
}
