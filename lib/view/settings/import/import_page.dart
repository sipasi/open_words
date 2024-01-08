import 'package:flutter/material.dart';
import 'package:open_words/view/mvvm/view_model.dart';
import 'package:open_words/view/settings/import/import_view_model.dart';
import 'package:open_words/view/shared/scaffold/selectable_words_scaffold.dart';

class ImportPage extends StatefulView<ImportViewModel> {
  const ImportPage({super.key});

  @override
  ViewState<ImportViewModel> createState() => _ImportPageState();
}

class _ImportPageState extends ViewState<ImportViewModel> {
  @override
  Widget loading(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const LinearProgressIndicator(),
          Expanded(child: Center(child: Text('Wait for file ...', style: _getLargeText(context)))),
        ],
      ),
    );
  }

  @override
  Widget success(BuildContext context) {
    return viewmodel.selectable.groups.isEmpty ? _empty(context) : _list(context);
  }

  Widget _empty(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('empty or wrong', style: _getLargeText(context)),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          reload();

          setState(() {});
        },
        icon: const Icon(Icons.folder_outlined),
        label: const Text('select'),
      ),
    );
  }

  Widget _list(BuildContext context) {
    return SelectableWordsScaffold(
      allSelected: viewmodel.selectable.allSelected,
      onSelectAll: () => viewmodel.selectable.onSelectAll(setState),
      count: viewmodel.selectable.groups.length,
      groupAt: viewmodel.selectable.groupAt,
      selectedAt: viewmodel.selectable.selectedAt,
      fab: viewmodel.selectable.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () => viewmodel.onImport(context),
              icon: const Icon(Icons.import_export),
              label: const Text('Import'),
            )
          : null,
      onTap: (contains, index) => viewmodel.selectable.onTileTap(setState, contains, index),
    );
  }

  TextStyle? _getLargeText(BuildContext context) {
    return Theme.of(context).textTheme.headlineLarge?.copyWith(
          fontWeight: FontWeight.bold,
        );
  }
}
