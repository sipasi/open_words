import 'package:flutter/material.dart';

class AdaptiveGridView extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets padding;

  final double maxCrossAxisExtent;
  final double mainAxisExtent;

  const AdaptiveGridView({
    super.key,
    required this.children,
    this.padding = EdgeInsets.zero,
    this.maxCrossAxisExtent = 220,
    this.mainAxisExtent = 100,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: padding,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: maxCrossAxisExtent,
        mainAxisExtent: mainAxisExtent,
      ),
      itemCount: children.length,
      itemBuilder: (context, index) {
        return children[index];
      },
    );
  }
}
