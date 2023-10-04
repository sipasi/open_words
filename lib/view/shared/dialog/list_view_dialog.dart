import 'package:flutter/material.dart';

class ListViewDialog extends StatelessWidget {
  final int length;

  final Widget Function(int index) builder;

  const ListViewDialog({
    super.key,
    required this.length,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ListView(
        shrinkWrap: true,
        children: List.generate(
          length,
          (index) => builder(index),
        ),
      ),
    );
  }

  static Future<T?> show<T>({
    required BuildContext context,
    required int length,
    required Widget Function(int index) builder,
  }) =>
      showDialog<T>(
        context: context,
        builder: (context) => ListViewDialog(length: length, builder: builder),
      );
}
