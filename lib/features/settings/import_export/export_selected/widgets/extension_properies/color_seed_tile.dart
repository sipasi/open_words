import 'package:flutter/material.dart';
import 'package:open_words/shared/modal/color_list_modal.dart';
import 'package:open_words/shared/theme/color_seed.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class ColorSeedTile extends StatelessWidget {
  final ColorSeed colorSeed;
  final void Function(ColorSeed value) onChanged;

  const ColorSeedTile({
    super.key,
    required this.colorSeed,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'Document Color Scheme',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        'Choose the overall color scheme for the document',
      ),
      trailing: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.colorScheme.surface,
        ),
        child: Icon(
          Icons.palette_outlined,
          color: colorSeed.color,
        ),
      ),
      onTap: () async {
        final color = await ColorListModal.dialog(
          context: context,
          current: colorSeed,
        );

        if (color != null) {
          onChanged(color);
        }
      },
    );
  }
}
