import 'package:flutter/material.dart';
import 'package:open_words/view/shared/layout/adaptive_layout.dart';

class AdaptiveLayoutByConstraintsHeight extends AdaptiveLayout {
  const AdaptiveLayoutByConstraintsHeight({super.key, required super.portrait, required super.landscape});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isMobile = constraints.maxHeight > constraints.maxWidth;

      return isMobile ? portrait(context) : landscape(context);
    });
  }
}
