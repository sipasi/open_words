import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/word_metadata/update/cubit/word_metadata_update_cubit.dart';
import 'package:open_words/shared/layout/adaptive_grid_view.dart';
import 'package:open_words/shared/theme/theme_extension.dart';
import 'package:open_words/shared/tiles/word_tile.dart';

class WordMetadataUpdateGridView extends StatelessWidget {
  const WordMetadataUpdateGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final alreadyDownloaded = context.select(
      (WordMetadataUpdateCubit value) => value.state.alreadyDownloaded,
    );

    return AdaptiveGridView(
      itemCount: alreadyDownloaded.length,
      itemBuilder: (context, index) {
        final item = alreadyDownloaded[index];

        return WordTile(
          title: item.name,
          subtitle: item.downloadStatus.title,
          subtitleColor: switch (item.downloadStatus.isNotFound) {
            true => context.colorScheme.error,
            _ => null,
          },
        );
      },
    );
  }
}
