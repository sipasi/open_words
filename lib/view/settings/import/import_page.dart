import 'package:flutter/material.dart';
import 'package:open_words/view/mvvm/view_model.dart';
import 'package:open_words/view/settings/import/import_view_model.dart';

class ImportPage extends StatefulView<ImportViewModel> {
  const ImportPage({super.key});

  @override
  ViewState<ImportViewModel> createState() => _ImportPageState();
}

class _ImportPageState extends ViewState<ImportViewModel> {
  @override
  Widget success(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Text('ImportPage'),
    );
  }
}
