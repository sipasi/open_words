import 'package:flutter/material.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class EditableListTile extends StatelessWidget {
  final String title;

  final int count;
  final IndexedWidgetBuilder builder;

  final void Function() onCreateTap;

  const EditableListTile({
    super.key,
    required this.title,
    required this.count,
    required this.builder,
    required this.onCreateTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = context.colorScheme.primary;
    final onPrimary = context.colorScheme.onPrimary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          onTap: onCreateTap,
          title: Text(title),
          trailing: Icon(Icons.add, color: onPrimary),
          tileColor: primary,
          titleTextStyle: TextStyle(
            color: onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),

        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: count,
          itemBuilder: builder,
          separatorBuilder: (context, index) => const Divider(height: 0),
        ),
      ],
    );
  }

  static Widget card({
    required String title,
    required int itemCount,
    required IndexedWidgetBuilder builder,
    required void Function() onCreateTap,
  }) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: EditableListTile(
        title: title,
        count: itemCount,
        builder: builder,
        onCreateTap: onCreateTap,
      ),
    );
  }

  static Widget filled({
    required String title,
    required int itemCount,
    required IndexedWidgetBuilder builder,
    required void Function() onCreateTap,
  }) {
    return Card.filled(
      clipBehavior: Clip.antiAlias,
      child: EditableListTile(
        title: title,
        count: itemCount,
        builder: builder,
        onCreateTap: onCreateTap,
      ),
    );
  }

  static Widget outlined({
    required String title,
    required int itemCount,
    required IndexedWidgetBuilder builder,
    required void Function() onCreateTap,
  }) {
    return Card.outlined(
      clipBehavior: Clip.antiAlias,
      child: EditableListTile(
        title: title,
        count: itemCount,
        builder: builder,
        onCreateTap: onCreateTap,
      ),
    );
  }
}
