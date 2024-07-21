import 'package:flutter/material.dart';

class GameProgressIndicator extends StatelessWidget {
  final double percentage;

  final EdgeInsets margin;

  const GameProgressIndicator({
    super.key,
    required this.percentage,
    this.margin = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: LinearProgressIndicator(value: percentage),
    );
  }
}
