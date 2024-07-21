import 'package:flutter/material.dart';

class SeparatedColumn extends StatelessWidget {
  final List<Widget> children;

  final IndexedWidgetBuilder separatorBuilder;

  final TextBaseline? textBaseline;

  final TextDirection? textDirection;

  final MainAxisSize mainAxisSize;

  final VerticalDirection verticalDirection;

  final MainAxisAlignment mainAxisAlignment;

  final CrossAxisAlignment crossAxisAlignment;

  const SeparatedColumn({
    super.key,
    this.textBaseline,
    this.textDirection,
    this.children = const <Widget>[],
    this.mainAxisSize = MainAxisSize.max,
    this.verticalDirection = VerticalDirection.down,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    required this.separatorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      textBaseline: textBaseline,
      textDirection: textDirection,
      mainAxisSize: mainAxisSize,
      verticalDirection: verticalDirection,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: _separate(context, children, separatorBuilder),
    );
  }

  static List<Widget> _separate(BuildContext context, List<Widget> widgets, IndexedWidgetBuilder separatorBuilder) {
    if (widgets.isEmpty) {
      return widgets;
    }

    final result = <Widget>[];

    for (var i = 0; i < widgets.length; i++) {
      result.add(widgets[i]);

      if (i + 1 == widgets.length) {
        continue;
      }

      result.add(separatorBuilder(context, i));
    }

    return result;
  }
}
