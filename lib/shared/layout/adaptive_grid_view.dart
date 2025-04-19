import 'package:flutter/material.dart';

class AdaptiveGridView extends StatelessWidget {
  final EdgeInsets padding;

  final double maxCrossAxisExtent;
  final double mainAxisExtent;

  final bool shrinkWrap;

  final ScrollPhysics? physics;

  final int itemCount;
  final NullableIndexedWidgetBuilder itemBuilder;

  final double? cacheExtent;

  const AdaptiveGridView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.padding = EdgeInsets.zero,
    this.maxCrossAxisExtent = 220,
    this.mainAxisExtent = 100,
    this.shrinkWrap = false,
    this.physics,
    this.cacheExtent,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: padding,
      physics: physics,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: maxCrossAxisExtent,
        mainAxisExtent: mainAxisExtent,
      ),
      shrinkWrap: shrinkWrap,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      cacheExtent: cacheExtent,
    );
  }
}
