import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/app/cubit/open_words_app_cubit.dart';

class ThemeModeTile extends StatelessWidget {
  const ThemeModeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OpenWordsAppCubit, OpenWordsAppState>(
      builder: (context, state) {
        return ListTile(
          title: SegmentedButton(
            showSelectedIcon: false,
            segments: [
              ButtonSegment(
                value: ThemeMode.dark,
                icon: Icon(Icons.dark_mode_outlined),
                label: Text('dark'),
              ),
              ButtonSegment(
                value: ThemeMode.light,
                icon: Icon(Icons.light_mode_outlined),
                label: Text('light'),
              ),
              ButtonSegment(
                value: ThemeMode.system,
                icon: Icon(Icons.devices_outlined),
                label: Text('system'),
              ),
            ],
            selected: {state.theme.mode},
            onSelectionChanged:
                (set) => _onThemeModeChanged(context, set.first),
          ),
        );
      },
    );
  }

  void _onThemeModeChanged(BuildContext context, ThemeMode value) async {
    final appCubit = context.read<OpenWordsAppCubit>();

    appCubit.setTheme(mode: value);
  }
}
