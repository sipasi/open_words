import 'package:flutter/material.dart';
import 'package:open_words/shared/modal/discard_changes_modal.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class PopScopeBottomSheet<T> extends StatelessWidget {
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
      child: SheetKeyboardDismissible(
        dismissBehavior: const SheetKeyboardDismissBehavior.onDragDown(
          isContentScrollAware: true,
        ),
        child: Sheet(
          scrollConfiguration: const SheetScrollConfiguration(),
          decoration: MaterialSheetDecoration(
            size: SheetSize.stretch,
            color: Theme.of(context).colorScheme.secondaryContainer,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
          ),
          child: SheetContentScaffold(
            bottomBarVisibility: const BottomBarVisibility.always(
              // Make the bottom bar visible when the keyboard is open.
              ignoreBottomInset: true,
            ),
            body: body,
            bottomBar: bottomBar,
          ),
        ),
      ),
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
