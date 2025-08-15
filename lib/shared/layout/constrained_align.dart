import 'package:flutter/material.dart';

class ConstrainedAlign extends StatelessWidget {
  final Widget child;

  final BoxConstraints constraints;
  final AlignmentGeometry alignment;

  const ConstrainedAlign({
    super.key,
    required this.child,
    this.alignment = AlignmentGeometry.center,
    this.constraints = const BoxConstraints(maxWidth: 800),
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: constraints,
        child: child,
      ),
    );
  }
}
