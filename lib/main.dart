import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_words/dependency/dependency_setter.dart';
import 'package:open_words/theme/app_theme.dart';
import 'package:open_words/theme/theme_storage.dart';
import 'package:open_words/theme/theme_switcher.dart';
import 'package:open_words/theme/theme_switcher_widget.dart';

import 'package:open_words/view/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppDependencySetter.set();

  await ThemeStorage.init();

  AppTheme theme = ThemeStorage.get();

  runApp(ThemeSwitcherWidget(
    initialTheme: theme,
    child: kReleaseMode ? const MyApp() : const _PreviewMyApp(),
  ));
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

class _PreviewMyApp extends StatefulWidget {
  const _PreviewMyApp();

  @override
  State<_PreviewMyApp> createState() => _MyPreviewMyAppAppState();
}

class _MyPreviewMyAppAppState extends State<_PreviewMyApp> {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = ThemeSwitcher.of(context).theme!;

    return DevicePreview(
      enabled: true,
      builder: (context) => MaterialApp(
        title: 'Open Words',
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        themeMode: theme.mode,
        theme: theme.asLight(),
        darkTheme: theme.asDark(),
        home: const HomePage(),
      ), // Wrap your app
    );
  }
}
