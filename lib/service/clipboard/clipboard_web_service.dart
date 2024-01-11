import 'package:open_words/service/clipboard/clipboard_handler.dart';
import 'package:universal_html/html.dart' as html;

class ClipboardWebHandler extends ClipboardHandler {
  @override
  Future<String> readText() {
    return html.window.navigator.clipboard?.readText() ?? Future.value('');
  }

  @override
  Future writeText(String text) {
    return html.window.navigator.clipboard?.writeText(text) ?? Future.value();
  }
}
