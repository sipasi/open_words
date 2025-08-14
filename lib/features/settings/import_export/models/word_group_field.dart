enum WordGroupField {
  name('name'),
  origin('origin'),
  translation('translation'),
  words('words');

  final String key;
  const WordGroupField(this.key);

  T? fromMap<T>(Map<String, dynamic> map) {
    if (map[key] case T value) {
      return value;
    }

    return null;
  }
}
