import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/features/app/cubit/open_words_app_cubit.dart';
import 'package:open_words/features/explorer/list/bloc/explorer_bloc.dart';
import 'package:open_words/features/home/cubit/home_cubit.dart';
import 'package:open_words/features/home/home_page.dart';
import 'package:open_words/features/settings/list/bloc/settings_bloc.dart';

class OpenWordsApp extends StatelessWidget {
  const OpenWordsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OpenWordsAppCubit(themeStorage: GetIt.I.get()),
        ),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(
          lazy: false,
          create: (context) {
            return ExplorerBloc(
              explorerRepository: GetIt.I.get(),
              folderRepository: GetIt.I.get(),
            )..add(ExplorerStarted());
          },
        ),
        BlocProvider(
          lazy: false,
          create: (context) => SettingsBloc(
            themeStorage: GetIt.I.get(),
            translatorStorage: GetIt.I.get(),
            aiBridgeProvider: GetIt.I.get(),
          )..add(SettingsInitRequested()),
        ),
      ],
      child: BlocBuilder<OpenWordsAppCubit, OpenWordsAppState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: state.theme.mode,
            theme: state.theme.asLight(),
            darkTheme: state.theme.asDark(),
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
