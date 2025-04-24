import 'package:flutter/material.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class DismissibleBottomSheet extends StatelessWidget {
  final Widget body;
  final Widget bottomBar;

  const DismissibleBottomSheet({
    super.key,
    required this.body,
    required this.bottomBar,
  });

  @override
  Widget build(BuildContext context) {
    return SheetKeyboardDismissible(
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
    );
  }
}
