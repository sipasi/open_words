import 'package:flutter/material.dart';

class ExpandedColumn extends StatelessWidget {
  final int length;
  final Widget Function(int index) builder;

  const ExpandedColumn({super.key, required this.length, required this.builder});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: List.generate(length, (index) => builder(index)),
      ),
    );
  }
}
