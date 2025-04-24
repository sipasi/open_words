import 'package:flutter/material.dart';
import 'package:open_words/shared/bottom_sheet/dismissible_bottom_sheet.dart';
import 'package:open_words/shared/modal/discard_changes_modal.dart';

class PopScopeBottomSheet extends StatelessWidget {
  final Widget body;
  final Widget bottomBar;
  final bool Function() showDismissDialog;

  const PopScopeBottomSheet({
    super.key,
    required this.body,
    required this.bottomBar,
    required this.showDismissDialog,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        _onPopInvoked(context, didPop, result);
      },
      child: DismissibleBottomSheet(body: body, bottomBar: bottomBar),
    );
  }

  Future<void> _onPopInvoked(
    BuildContext context,
    bool didPop,
    Object? result,
  ) async {
    if (didPop) {
      // Already popped.
      return;
    } else if (!showDismissDialog()) {
      // Dismiss immediately if there are no unsaved changes.
      Navigator.pop(context);
      return;
    }

    // Show a confirmation dialog.
    final shouldPop = await DiscardChangesModal.dialog(context: context);

    if (shouldPop && context.mounted) {
      Navigator.pop(context);
    }
  }
}
