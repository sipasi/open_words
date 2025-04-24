import 'package:flutter/material.dart';
import 'package:open_words/core/data/entities/folder/folder.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/features/explorer/widgets/folder_tile.dart';
import 'package:open_words/features/explorer/widgets/group_tile.dart';
import 'package:open_words/shared/constants/list_padding_constans.dart';
import 'package:open_words/shared/layout/adaptive_grid_view.dart';

class ExplorerGridView extends StatelessWidget {
  final List<Folder> folders;
  final List<WordGroup> groups;

  const ExplorerGridView({
    super.key,
    required this.folders,
    required this.groups,
  });

  @override
  Widget build(BuildContext context) {
    int folderLength = folders.length;

    return AdaptiveGridView.listTiles(
      itemCount: folderLength + groups.length,
      padding: const EdgeInsets.only(bottom: ListPaddingConstans.bottomForFab),
      itemBuilder: (context, index) {
        if (index < folderLength) {
          final folder = folders[index];

          return FolderTile(key: ValueKey(folder), folder: folder);
        }

        final group = groups[index - folderLength];

        return GroupTile(key: ValueKey(group), group: group);
      },
    );
  }
}
