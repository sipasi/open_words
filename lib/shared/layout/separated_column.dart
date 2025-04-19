import 'package:flutter/material.dart';

class SeparatedColumn extends StatelessWidget {
  final List<Widget> children;

  final IndexedWidgetBuilder? firstSeparator;
  final IndexedWidgetBuilder? lastSeparator;
  final IndexedWidgetBuilder separator;

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
    this.firstSeparator,
    this.lastSeparator,
    required this.separator,
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
      children: _separate(
        context,
        children,
        separator: separator,
        firstSeparator: firstSeparator,
        lastSeparator: lastSeparator,
      ),
    );
  }

  static List<Widget> _separate(
    BuildContext context,
    List<Widget> widgets, {
    required IndexedWidgetBuilder? firstSeparator,
    required IndexedWidgetBuilder? lastSeparator,
    required IndexedWidgetBuilder separator,
  }) {
    if (widgets.isEmpty) {
      return widgets;
    }

    final result = <Widget>[];

    tryAdd(result, firstSeparator, context, 0);

    for (var i = 0; i < widgets.length; i++) {
      result.add(widgets[i]);

      if (i + 1 == widgets.length) {
        continue;
      }

      result.add(separator(context, i));
    }

    tryAdd(result, lastSeparator, context, result.length);

    return result;
  }

  static void tryAdd(
    List<Widget> widgets,
    IndexedWidgetBuilder? separator,
    BuildContext context,
    int index,
  ) {
    if (separator case IndexedWidgetBuilder last) {
      widgets.add(last(context, index));
    }
  }
}
