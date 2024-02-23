import 'package:flutter/material.dart';

import '../theme_controller.dart';

class ThemeModeTile extends StatelessWidget {
  final ThemeController viewmodel;

  const ThemeModeTile({super.key, required this.viewmodel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Dark'),
      trailing: Switch(
        value: viewmodel.isDark,
        onChanged: (value) => viewmodel.onModeChanged(context, value),
      ),
    );
  }
}
