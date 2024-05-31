import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/data/metadata/word_metadata.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/service/metadata/metadata_web_finder.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/storage/metadata_storage.dart';
import 'package:open_words/view/mvvm/view_model.dart';

import 'download_info.dart';

class DownloadMetadataViewModel {
  final List<Word> _words;

  bool _downloading = false;

  bool _metadataChecked = false;

  late final Future future;

  final List<DownloadInfo> infos = [];

  bool get downloading => _downloading;
  bool get metadataChecked => _metadataChecked;

  DownloadMetadataViewModel({required List<Word> words}) : _words = words;

  void allUpdatedTaped(BuildContext context) => MaterialNavigator.pop(context);

  Future onLoadAllTapped(UpdateState updateState) async {
    const offset = 5;

    _downloading = true;

    if (infos.isEmpty) {
      return;
    }

    int skipped = 0;

    while (skipped < infos.length) {
      final downloads = infos.skip(skipped).take(offset).toList();

      updateState(() {
        for (var element in downloads) {
          element.downloading();
        }
      });

      final downloaded = await _download(downloads);

      updateState(() {
        for (var info in downloads) {
          final metadata =
              downloaded.cast<WordMetadata?>().firstWhere((updated) => updated?.word == info.name, orElse: () => null);

          if (metadata == null) {
            info.error('not found');

            continue;
          }

          info.downloaded();

          infos.remove(info);
        }
      });

      await _storeDownloads(downloaded);

      skipped += offset - downloaded.length;
    }

    updateState(() => _downloading = false);
  }

  void init(UpdateState updateState) => future = _checkMetadata(updateState);

  Future<List<WordMetadata>> _download(List<DownloadInfo> downloads) async {
    final webFinder = GetIt.I.get<MetadataWebFinder>();

    final futures = downloads.map((info) => webFinder.find(info.name));

    final downloaded = await Future.wait(futures);

    downloaded.removeWhere((element) => element == null);

    return downloaded.cast<WordMetadata>();
  }

  Future _storeDownloads(List<WordMetadata> downloads) {
    final storage = GetIt.I.get<MetadataStorage>();

    return Future.wait(downloads.map((item) => storage.updateOrCreate(item)));
  }

  Future _checkMetadata(UpdateState updateState) async {
    final storage = GetIt.I.get<MetadataStorage>();

    infos.clear();

    for (var i = 0; i < _words.length; i++) {
      final word = _words[i];

      final metadata = await storage.firstByWord(word.origin);

      if (metadata != null) {
        continue;
      }

      final info = DownloadInfo(name: word.origin);

      updateState(() => infos.add(info));
    }

    updateState(() => _metadataChecked = true);
  }
}
