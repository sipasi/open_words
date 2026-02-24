class HtmlBuffer {
  final StringBuffer _buffer = StringBuffer(_beginPage());

  HtmlBuffer writeln(String text) {
    _buffer.writeln(text);

    return this;
  }

  HtmlBuffer write(String text) {
    _buffer.write(text);

    return this;
  }

  String build() {
    _buffer.writeln(_endPage());

    return _buffer.toString();
  }

  static String _beginPage() {
    return '''
<!doctype html>
<html lang="en" data-theme="dark-green">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />

  <title>Open Words</title>

  <link rel="icon" href="data:," />
</head>

<body>
''';
  }

  static String _endPage() {
    return '''
</body>

</html> 
''';
  }
}
