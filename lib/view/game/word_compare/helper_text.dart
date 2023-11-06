class HelperText {
  final String text;
  final String prefix;

  HelperText({required this.text, required this.prefix});

  @override
  String toString() => '$prefix: $text';
}
