import 'package:flutter/material.dart';
import 'package:open_words/service/language/language_info_service.dart';
import 'package:open_words/storage/in_memory_word_group_storage.dart';
import 'package:open_words/storage/word_group_storage.dart';
import 'package:open_words/theme/app_theme.dart';
import 'package:open_words/theme/theme_storage.dart';
import 'package:open_words/theme/theme_switcher.dart';
import 'package:open_words/theme/theme_switcher_widget.dart';

import 'package:get_it/get_it.dart';
import 'package:open_words/view/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await InMemoryWordGroupStorage.fromBuiltIn();

  GetIt.I.registerSingleton<WordGroupStorage>(storage);
  GetIt.I.registerSingleton<LanguageInfoService>(LanguageInfoService());

  await ThemeStorage.init();

  AppTheme theme = ThemeStorage.get();

  runApp(ThemeSwitcherWidget(initialTheme: theme, child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = ThemeSwitcher.of(context).theme!;

    return MaterialApp(
      title: 'Open Words',
      debugShowCheckedModeBanner: false,
      themeMode: theme.mode,
      theme: theme.asLight(),
      darkTheme: theme.asDark(),
      home: const HomePage(),
    );
  }
}
