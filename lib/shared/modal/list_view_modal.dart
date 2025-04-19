import 'package:flutter/material.dart';

class ListViewModal extends StatelessWidget {
  final int length;

  final Widget Function(int index) builder;

  const ListViewModal({super.key, required this.length, required this.builder});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAlias,
      child: Container(
        constraints: BoxConstraints(maxHeight: 800, maxWidth: 400),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: length,
          itemBuilder: (context, index) => builder(index),
        ),
      ),
    );
  }

  static Future<T?> dialog<T>({
    required BuildContext context,
    required int length,
    required Widget Function(int index) builder,
  }) => showDialog<T>(
    context: context,
    builder: (context) => ListViewModal(length: length, builder: builder),
  );
}
