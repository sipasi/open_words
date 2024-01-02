import 'package:flutter/material.dart';
import 'package:open_words/view/mvvm/view_model.dart';
import 'package:open_words/view/settings/export/export_view_model.dart';
import 'package:open_words/view/shared/list/adaptive_grid_view.dart';

class ExportPage extends StatefulView<ExportViewModel> {
  const ExportPage({super.key});

  @override
  ViewState<ExportViewModel> createState() => _ExportPageState();
}

class _ExportPageState extends ViewState<ExportViewModel> {
  @override
  Widget success(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(viewmodel.allSelected ? Icons.done : Icons.circle),
            onPressed: () => viewmodel.onSelectAll(setState),
          ),
        ],
      ),
      floatingActionButton: viewmodel.canShare()
          ? FloatingActionButton.extended(
              label: const Text('Share'),
              icon: const Icon(Icons.share_outlined),
              onPressed: () => viewmodel.toExportDestination(context),
            )
          : null,
      body: _grid(),
    );
  }

  Widget _grid() {
    return AdaptiveGridView(
      children: List.generate(
        viewmodel.count,
        (index) => _tile(index),
      ),
    );
  }

  InkWell _tile(int index) {
    final entity = viewmodel.groupAt(index);

    bool contains = viewmodel.selectedAt(index);

    return InkWell(
      child: ListTile(
        title: Text(entity.name),
        titleAlignment: ListTileTitleAlignment.top,
        selected: contains,
        trailing: Icon(Icons.circle, color: contains ? null : Colors.transparent),
      ),
      onTap: () => viewmodel.onTileTap(setState, contains, index),
    );
  }
}
