import 'package:flutter/material.dart';
import 'package:open_words/view/mvvm/view_model.dart';
import 'package:open_words/view/settings/export/export_view_model.dart';
import 'package:open_words/view/shared/scaffold/selectable_words_scaffold.dart';

class ExportPage extends StatefulView<ExportViewModel> {
  const ExportPage({super.key});

  @override
  ViewState<ExportViewModel> createState() => _ExportPageState();
}

class _ExportPageState extends ViewState<ExportViewModel> {
  @override
  Widget success(BuildContext context) {
    return SelectableWordsScaffold(
      allSelected: viewmodel.selectable.allSelected,
      onSelectAll: () => viewmodel.selectable.onSelectAll(setState),
      count: viewmodel.selectable.groups.length,
      groupAt: viewmodel.selectable.groupAt,
      selectedAt: viewmodel.selectable.selectedAt,
      fab: viewmodel.canShare()
          ? FloatingActionButton.extended(
              label: const Text('Share'),
              icon: const Icon(Icons.share_outlined),
              onPressed: () => viewmodel.toExportDestination(context),
            )
          : null,
      onTap: (contains, index) => viewmodel.selectable.onTileTap(setState, contains, index),
    );
  }
}
