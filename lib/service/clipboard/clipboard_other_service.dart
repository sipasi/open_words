import 'package:flutter/services.dart';
import 'package:open_words/service/clipboard/clipboard_handler.dart';

class ClipboardDefaultHandler extends ClipboardHandler {
  @override
  Future<String?> readText() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);

    return data?.text;
  }

  @override
  Future writeText(String text) {
    return Clipboard.setData(ClipboardData(text: text));
  }
}
