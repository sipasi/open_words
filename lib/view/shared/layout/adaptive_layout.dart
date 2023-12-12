import 'package:flutter/material.dart';

abstract class AdaptiveLayout extends StatelessWidget {
  final WidgetBuilder portrait;
  final WidgetBuilder landscape;

  const AdaptiveLayout({super.key, required this.portrait, required this.landscape});
}
