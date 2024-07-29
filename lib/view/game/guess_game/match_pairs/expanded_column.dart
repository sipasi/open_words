import 'package:flutter/material.dart';

class ExpandedColumn extends StatelessWidget {
  final int length;
  final Widget Function(int index) builder;

  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;

  const ExpandedColumn({
    super.key,
    required this.length,
    required this.builder,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        children: List.generate(length, (index) => builder(index)),
      ),
    );
  }
}
