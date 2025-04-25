import 'package:flutter/material.dart';
import 'package:open_words/shared/bottom_sheet/editor/editor_bottom_bar.dart';
import 'package:open_words/shared/bottom_sheet/pop_scope_bottom_sheet.dart';

class EditorBottomSheet extends StatelessWidget {
  final Widget body;
  final EditorBottomBar bottomBar;
  final bool Function() showDismissDialog;

  const EditorBottomSheet({
    super.key,
    required this.body,
    required this.bottomBar,
    required this.showDismissDialog,
  });

  @override
  Widget build(BuildContext context) {
    return PopScopeBottomSheet(
      body: body,
      bottomBar: bottomBar,
      showDismissDialog: showDismissDialog,
    );
  }
}
