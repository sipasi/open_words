import 'package:flutter/material.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class EditorBottomBar extends StatelessWidget {
  final List<Widget> actions;

  final void Function()? onSubmitPressed;
  final Widget submitIcon;

  const EditorBottomBar({
    super.key,
    this.actions = const [],
    this.onSubmitPressed,
    this.submitIcon = const Icon(Icons.arrow_upward),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colorScheme.secondaryContainer,
      child: SafeArea(
        top: false,
        child: SizedBox.fromSize(
          size: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Row(spacing: 8, children: actions),
                const Spacer(),
                IconButton.filled(
                  onPressed: onSubmitPressed,
                  icon: submitIcon,
                  tooltip: 'Submit',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
