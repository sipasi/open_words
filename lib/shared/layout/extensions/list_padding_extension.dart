import 'package:flutter/material.dart';

extension ListPaddingExtension on BuildContext {
  EdgeInsets safeListViewPadding({
    double extraLeft = 0.0,
    double extraTop = 0.0,
    double extraRight = 0.0,
    double extraBottom = 0.0,
  }) {
    final padding = MediaQuery.of(this).padding;

    return EdgeInsets.only(
      top: padding.top + extraTop,
      bottom: padding.bottom + extraBottom,
      left: padding.left + extraLeft,
      right: padding.right + extraRight,
    );
  }
}
