import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/app/cubit/open_words_app_cubit.dart';

class ThemeOledTile extends StatelessWidget {
  const ThemeOledTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OpenWordsAppCubit, OpenWordsAppState>(
      builder: (context, state) {
        final oledBackground = state.theme.oledBackground;

        if (state.theme.mode == .light) {
          return const SizedBox.shrink();
        }

        return Column(
          children: [
            CheckboxListTile(
              title: Text("Oled Background"),
              value: oledBackground,
              onChanged: (value) => _onOledBackgroundChanged(context),
              dense: true,
              contentPadding: .symmetric(horizontal: 16),
            ),
          ],
        );
      },
    );
  }

  void _onOledBackgroundChanged(BuildContext context) async {
    final appCubit = context.read<OpenWordsAppCubit>();

    appCubit.setTheme(oledBackground: !appCubit.state.theme.oledBackground);
  }
}
