import 'package:flutter/material.dart';

class ExpandedColumn extends StatelessWidget {
  final int length;
  final Widget Function(int index) builder;

  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;

  final double spacing;

  const ExpandedColumn({
    super.key,
    required this.length,
    required this.builder,
    required this.spacing,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        spacing: spacing,
        children: List.generate(length, (index) => builder(index)),
      ),
    );
  }
}
