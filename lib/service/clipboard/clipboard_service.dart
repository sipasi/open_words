import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'clipboard_handler.dart';

class ClipboardService {
  final ClipboardHandler _clipboard;

  const ClipboardService(this._clipboard);

  Future<String?> readText(BuildContext context, {bool snackBar = true, bool vibrate = true}) async {
    _vibrateIfTrue(vibrate);

    final text = await _clipboard.readText();

    if (context.mounted) _snackBarIfTrue(context, '$text pasted', snackBar);

    return text;
  }

  Future writeText(BuildContext context, String text, {bool snackBar = true, bool vibrate = true}) async {
    _vibrateIfTrue(vibrate);
    _snackBarIfTrue(context, '$text copied', snackBar);

    return _clipboard.writeText(text);
  }

  Future _vibrate() {
    return HapticFeedback.vibrate();
  }

  void _snackBar(
    BuildContext context,
    String text,
  ) {
    final colors = Theme.of(context).colorScheme;

    final snackBar = SnackBar(
      content: Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: colors.primary),
      ),
      backgroundColor: colors.surfaceContainerHighest,
      elevation: 0,
      showCloseIcon: true,
      closeIconColor: colors.error,
      duration: const Duration(seconds: 1),
    );

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future _vibrateIfTrue(bool condition) {
    return condition ? _vibrate() : Future.value();
  }

  void _snackBarIfTrue(BuildContext context, String? text, bool condition) {
    if (condition && text != null) _snackBar(context, text);
  }
}
