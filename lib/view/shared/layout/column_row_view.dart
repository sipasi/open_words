import 'package:flutter/material.dart';
import 'package:open_words/view/shared/layout/constraints_adaptive_layout.dart';

class ColumnRowView extends StatelessWidget {
  final List<ColumnRowItem> children;

  final bool columnReverse;
  final bool rowReverse;

  const ColumnRowView({
    super.key,
    required this.children,
    this.columnReverse = false,
    this.rowReverse = true,
  });

  @override
  Widget build(BuildContext context) {
    return ConstraintsAdaptiveLayout(
      portrait: (context) {
        return Column(
          children: _perform(
            list: children,
            reverse: columnReverse,
            exist: (item) => item.column,
          ),
        );
      },
      landscape: (context) {
        return Row(
          children: _perform(
            list: children,
            reverse: rowReverse,
            exist: (item) => item.row,
          ),
        );
      },
    );
  }

  static List<Widget> _perform({
    required List<ColumnRowItem> list,
    required bool reverse,
    required ColumnRow Function(ColumnRowItem item) exist,
  }) {
    final iterable = _tryReverse(list, reverse).where((element) => exist(element).exist);

    return iterable.map((e) => e.partOfRow()).toList();
  }

  static Iterable<ColumnRowItem> _tryReverse(List<ColumnRowItem> list, bool reverse) {
    return reverse ? list.reversed : list;
  }
}

class ColumnRow {
  final int flex;
  final FlexFit fit;
  final bool exist;

  const ColumnRow({this.flex = 1, this.fit = FlexFit.loose, this.exist = true});
  const ColumnRow.empty() : this(exist: false, fit: FlexFit.loose, flex: 0);
}

abstract class ColumnRowItem {
  final ColumnRow row;
  final ColumnRow column;

  const ColumnRowItem({required this.row, required this.column});

  Widget partOfRow();
  Widget partOfColumn();
}

class ColumnRowDivider extends ColumnRowItem {
  static const _divider = ColumnRow(
    exist: true,
    flex: 0,
  );

  const ColumnRowDivider({required super.row, required super.column});

  const ColumnRowDivider.vertical()
      : super(
          column: _divider,
          row: const ColumnRow.empty(),
        );
  const ColumnRowDivider.horizontal()
      : super(
          column: const ColumnRow.empty(),
          row: _divider,
        );
  const ColumnRowDivider.both()
      : super(
          column: _divider,
          row: _divider,
        );

  @override
  Widget partOfColumn() {
    return const Divider();
  }

  @override
  Widget partOfRow() {
    return const VerticalDivider();
  }
}

class ColumnRowFlexWidget extends ColumnRowItem {
  final Widget child;

  ColumnRowFlexWidget({required super.row, required super.column, required this.child});

  @override
  Widget partOfColumn() {
    return _build(child, column);
  }

  @override
  Widget partOfRow() {
    return _build(child, row);
  }

  static Widget _build(Widget child, ColumnRow rule) {
    return Flexible(flex: rule.flex, fit: rule.fit, child: child);
  }
}
