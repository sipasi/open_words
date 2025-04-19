import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/app/cubit/open_words_app_cubit.dart';
import 'package:open_words/shared/modal/color_list_modal.dart';
import 'package:open_words/shared/theme/color_seed.dart';

class ThemeColorTile extends StatelessWidget {
  const ThemeColorTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OpenWordsAppCubit, OpenWordsAppState>(
      builder: (context, state) {
        final seed = state.theme.seed;

        return ListTile(
          title: const Text('Color'),
          subtitle: Text(seed.label),
          trailing: Icon(Icons.palette_outlined, color: seed.color),
          onTap: () => _onThemeColorChanged(context, seed),
        );
      },
    );
  }

  Future _onThemeColorChanged(BuildContext context, ColorSeed value) async {
    final seed = await ColorListModal.dialog(context: context, current: value);

    if (seed == null || seed == value || context.mounted == false) {
      return;
    }

    final appCubit = context.read<OpenWordsAppCubit>();

    appCubit.setTheme(seed: seed);
  }
}
