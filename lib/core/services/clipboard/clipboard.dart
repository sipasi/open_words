import 'package:flutter/services.dart';

abstract class ClipboardService {
  Future<String> getText();
  Future setText(String value);
}

final class ClipboardServiceImpl extends ClipboardService {
  @override
  Future<String> getText() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final value = data?.text;

    if (data == null || value == null) {
      return '';
    }

    return value.trim();
  }

  @override
  Future setText(String value) {
    final trimmed = value.trim();

    if (trimmed.isEmpty) {
      return Future.value();
    }

    return Clipboard.setData(ClipboardData(text: trimmed));
  }
}
