import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/features/word_metadata/update/cubit/word_metadata_update_cubit.dart';
import 'package:open_words/features/word_metadata/update/widgets/word_metadata_update_fab.dart';
import 'package:open_words/features/word_metadata/update/widgets/word_metadata_update_grid_view.dart';
import 'package:open_words/shared/appbar/app_bar_title.dart';
import 'package:open_words/shared/constants/hero_tag_constants.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class WordMetadataUpdatePage extends StatelessWidget {
  final String groupName;
  final List<Word> words;

  const WordMetadataUpdatePage({
    super.key,
    required this.words,
    required this.groupName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => WordMetadataUpdateCubit(
            words: words,
            groupName: groupName,
            metadataRepository: GetIt.I.get(),
            metadataWebApi: GetIt.I.get(),
            vibrationService: GetIt.I.get(),
          )..init(),
      child: WordMetadataUpdateView(),
    );
  }
}

class WordMetadataUpdateView extends StatelessWidget {
  const WordMetadataUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult:
          (didPop, result) => _onPopInvoked(context, didPop, result),
      child: Scaffold(
        appBar: AppBar(
          title: AppBarTitle(
            title: context.read<WordMetadataUpdateCubit>().groupName,
            heroTag: HeroTagConstants.appbarTitleTag,
          ),
        ),
        floatingActionButton: WordMetadataUpdateFab(),
        body: WordMetadataUpdateGridView(),
      ),
    );
  }

  void _onPopInvoked(BuildContext context, bool didPop, Object? result) {
    final updateStatus =
        context.read<WordMetadataUpdateCubit>().state.updateStatus;

    if (didPop || updateStatus.inProgress) {
      return;
    }

    context.pop();
  }
}
