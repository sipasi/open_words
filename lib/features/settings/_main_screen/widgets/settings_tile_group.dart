import 'package:flutter/material.dart';
import 'package:open_words/shared/layout/separated_column.dart';

class SettingsTileGroup extends StatelessWidget {
  final Widget child;

  const SettingsTileGroup({super.key, required this.child});
  const SettingsTileGroup.single({super.key, required this.child});

  factory SettingsTileGroup.many({required List<Widget> children}) {
    return SettingsTileGroup(
      child: SeparatedColumn(
        mainAxisSize: MainAxisSize.min,
        separator: (context, index) => const Divider(height: 0),
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card.outlined(clipBehavior: Clip.antiAlias, child: child);
  }
}
