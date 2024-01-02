import 'package:flutter/material.dart';
import 'package:open_words/view/shared/layout/adaptive_layout.dart';

class OrientationAdaptiveLayout extends AdaptiveLayout {
  const OrientationAdaptiveLayout({super.key, required super.portrait, required super.landscape});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.portrait) {
      return portrait(context);
    }

    return landscape(context);
  }
}
