import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:open_words/shared/layout/adaptive_layout.dart';

class ConstraintsAdaptiveLayout extends AdaptiveLayout {
  const ConstraintsAdaptiveLayout({
    super.key,
    required super.portrait,
    required super.landscape,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final padding = View.of(context).viewInsets; // on-screen keyboard

        bool isPortrait = _isPortrait(constraints, padding);

        return isPortrait ? portrait(context) : landscape(context);
      },
    );
  }

  static bool _isPortrait(BoxConstraints constraints, ViewPadding padding) {
    return (constraints.maxHeight + padding.bottom) > constraints.maxWidth;
  }
}
