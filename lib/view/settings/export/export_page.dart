import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/share/share_data.dart';
import 'package:open_words/storage/word_group_storage.dart';
import 'package:open_words/view/shared/future_state.dart';
import 'package:share_plus/share_plus.dart';

class ExportPage extends StatefulWidget {
  const ExportPage({super.key});

  @override
  State<ExportPage> createState() => _ExportPageState();
}

class _ExportPageState extends FutureState<ExportPage, List<WordGroup>> {
  final Set<int> selections = {};

  bool get allSelected => selections.length == dataCount;

  int get dataCount => cache?.length ?? 0;

  @override
  Future<List<WordGroup>> getFuture() async {
    final storage = GetIt.I.get<WordGroupStorage>();

    return storage.getAll();
  }

  @override
  Widget successBuild(BuildContext context, List<WordGroup> data) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(allSelected ? Icons.done : Icons.circle),
            onPressed: _selectAllHandler,
          ),
        ],
      ),
      body: _listView(data),
      floatingActionButton: selections.isNotEmpty ? _shareFab() : null,
    );
  }

  void _selectAllHandler() {
    setState(() {
      if (allSelected) {
        selections.clear();
        return;
      }

      selections.clear();

      selections.addAll(List.generate(dataCount, (index) => index));
    });
  }

  Widget _shareFab() {
    return FloatingActionButton.extended(
      label: const Text('Share'),
      icon: const Icon(Icons.share_outlined),
      onPressed: () => _onShare(),
    );
  }

  ListView _listView(List<WordGroup> data) {
    return ListView.separated(
      itemCount: data.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final entity = data[index];

        bool contains = selections.contains(index);

        return _tile(entity, contains, index);
      },
    );
  }

  InkWell _tile(WordGroup entity, bool contains, int index) {
    return InkWell(
      child: ListTile(
        title: Text(entity.name),
        selected: true,
        trailing: contains ? const Icon(Icons.circle) : null,
      ),
      onTap: () {
        setState(() {
          if (contains) {
            selections.remove(index);

            return;
          }
          selections.add(index);
        });
      },
    );
  }

  Future<ShareResult> _onShare() {
    final export = selections.map((index) => cache![index]).toList();

    return ShareData.asJson(
      context: context,
      data: export,
      name: 'WordGroup.json',
      manyNamePolicy: (entity) => '${entity.name}.json',
      oneFile: true,
    );
  }
}
