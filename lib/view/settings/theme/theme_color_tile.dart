import 'package:flutter/material.dart';

import '../theme_controller.dart';

class ThemeColorTile extends StatelessWidget {
  final ThemeController viewmodel;

  const ThemeColorTile({super.key, required this.viewmodel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Color'),
      trailing: Icon(
        Icons.color_lens,
        color: viewmodel.seed.color,
      ),
      onTap: () => viewmodel.showColorDialog(context),
    );
  }
}
