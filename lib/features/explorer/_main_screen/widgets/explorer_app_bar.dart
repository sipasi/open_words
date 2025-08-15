import 'package:flutter/material.dart';
import 'package:open_words/features/explorer/_main_screen/widgets/explorer_back_button.dart';
import 'package:open_words/features/explorer/_main_screen/widgets/explorer_title.dart';

class ExplorerAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  const ExplorerAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: ExplorerTitle(),
      leading: ExplorerBackButton.nullIfRoot(context),
    );
  }
}
