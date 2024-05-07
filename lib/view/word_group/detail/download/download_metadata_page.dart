import 'package:flutter/material.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/view/shared/list/adaptive_grid_view.dart';

import 'download_info.dart';
import 'download_metadata_view_model.dart';

class DownloadMetadataPage extends StatefulWidget {
  final WordGroup group;

  const DownloadMetadataPage({super.key, required this.group});

  @override
  State<DownloadMetadataPage> createState() => _DownloadMetadataState();
}

class _DownloadMetadataState extends State<DownloadMetadataPage> {
  late final DownloadMetadataViewModel viewodel;

  @override
  void initState() {
    super.initState();

    viewodel = DownloadMetadataViewModel(words: widget.group.words);

    viewodel.init(setState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(viewodel.infos.isEmpty ? 'All updated' : 'need to update ${viewodel.infos.length}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: viewodel.downloading ? null : () => MaterialNavigator.pop(context),
        ),
      ),
      floatingActionButton: _Fab(
        metadataChecked: viewodel.metadataChecked,
        allUpdated: viewodel.infos.isEmpty,
        downloading: viewodel.downloading,
        onAllUpdatedTap: () => MaterialNavigator.pop(context),
        onLoadAllTap: () => viewodel.onLoadAllTapped(setState),
      ),
      body: FutureBuilder(
        future: viewodel.future,
        builder: (context, snapshot) {
          return _Body(infos: viewodel.infos);
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final List<DownloadInfo> infos;

  const _Body({required this.infos});

  @override
  Widget build(BuildContext context) {
    return AdaptiveGridView(
      children: List.generate(infos.length, (index) {
        final info = infos[index];

        return ListTile(
          title: _title(info),
          subtitle: _subtitle(context, info),
        );
      }),
    );
  }

  Widget _title(DownloadInfo info) {
    return Text(
      info.name,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _subtitle(BuildContext context, DownloadInfo info) {
    final scheem = Theme.of(context).colorScheme;

    final message = info.isError() ? info.message! : 'not checked yet';

    return info.isDownloading()
        ? const LinearProgressIndicator()
        : Text(message, style: TextStyle(color: info.isError() ? scheem.error : scheem.secondary));
  }
}

class _Fab extends StatelessWidget {
  final bool allUpdated;
  final bool metadataChecked;
  final bool downloading;

  final void Function() onAllUpdatedTap;
  final void Function() onLoadAllTap;

  const _Fab({
    required this.allUpdated,
    required this.metadataChecked,
    required this.downloading,
    required this.onAllUpdatedTap,
    required this.onLoadAllTap,
  });

  @override
  Widget build(BuildContext context) {
    if (metadataChecked == false) {
      return _loadingFab('Checking', Icons.search);
    }

    if (allUpdated) {
      return FloatingActionButton.extended(
        onPressed: onAllUpdatedTap,
        label: const Text('All updated'),
        icon: const Icon(Icons.arrow_back),
      );
    }

    if (downloading) {
      return _loadingFab('Loading', Icons.download);
    }

    return FloatingActionButton.extended(
      onPressed: onLoadAllTap,
      label: const Text('Load all'),
      icon: const Icon(Icons.download),
    );
  }

  Widget _loadingFab(String text, IconData icon) {
    return FloatingActionButton.extended(
      onPressed: () {},
      icon: Icon(icon),
      label: Row(
        children: [
          Text(text),
          const SizedBox(width: 20),
          const SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
