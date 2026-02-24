import 'package:open_words/features/settings/import_export/export_selected/logic/html/html_buffer.dart';
import 'package:open_words/features/settings/import_export/export_selected/logic/html/tag_writer.dart';

class HtmlWriter {
  final HtmlBuffer _buffer;

  HtmlWriter(this._buffer);

  HtmlWriter tag({
    required String tag,
    Function(TagWriter writer)? attributes,
    Function(HtmlWriter writer)? child,
  }) {
    _buffer.write('<').write(tag).appendAttributes(attributes).writeln('>');
    child?.call(this);
    _buffer.write('</').write(tag).writeln('>');

    return this;
  }

  HtmlWriter tagWhen({
    required String tag,
    required bool condition,
    Function(TagWriter writer)? attributes,
    Function(HtmlWriter writer)? child,
  }) {
    if (condition) {
      this.tag(
        tag: tag,
        attributes: attributes,
        child: child,
      );
    }

    return this;
  }

  HtmlWriter variableLine({required String name, required String value}) {
    _buffer.write('const ').write(name).write(' = ').write(value).writeln(';');

    return this;
  }

  HtmlWriter textLine(String value) {
    _buffer.writeln(value);

    return this;
  }
}

extension _HtmlWriterExtension on HtmlBuffer {
  HtmlBuffer appendAttributes(Function(TagWriter writer)? attributes) {
    attributes?.call(TagWriter(this));

    return this;
  }
}
