class FormatOptions {
  static const _empty = FormatOptions();

  const FormatOptions();

  static FormatOptions empty() => _empty;

  bool isEmpty() => this == _empty;

  T? cast<T extends FormatOptions>() => this is T ? this as T : null;
  T trycast<T extends FormatOptions>(T defaultValue) => cast<T>() ?? defaultValue;
}
