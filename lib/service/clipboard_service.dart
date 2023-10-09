import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClipboardService {
  Future copy(String text) async {
    await HapticFeedback.heavyImpact();

    await Clipboard.setData(ClipboardData(text: text));
  }

  Future copyWithSnakBar(BuildContext context, String text) {
    final colors = Theme.of(context).colorScheme;

    final snackBar = SnackBar(
      content: Text(
        '$text copied',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: colors.primary),
      ),
      backgroundColor: colors.surfaceVariant,
      elevation: 0,
      showCloseIcon: true,
      closeIconColor: colors.error,
      duration: const Duration(seconds: 1),
    );

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    return copy(text);
  }
}
