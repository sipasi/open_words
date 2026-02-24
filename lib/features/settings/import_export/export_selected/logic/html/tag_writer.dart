import 'package:open_words/features/settings/import_export/export_selected/logic/html/html_buffer.dart';

class TagWriter {
  final HtmlBuffer _buffer;
  TagWriter(this._buffer);

  void add(String name, String value) {
    _buffer.write(' ').write(name).write('="').write(value).write('"');
  }
}
