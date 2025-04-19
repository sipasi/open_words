import 'package:flutter/material.dart';
import 'package:open_words/core/dependency/app_dependency_provider.dart';
import 'package:open_words/features/app/open_words_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppDependencyProvider.init();

  runApp(const OpenWordsApp());
}
