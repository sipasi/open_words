import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/features/word/detail/cubit/word_detail_page_cubit.dart';
import 'package:open_words/features/word/detail/widgets/text_to_speech_card.dart';
import 'package:open_words/features/word/detail/widgets/word_detail_fab.dart';
import 'package:open_words/features/word/detail/widgets/word_detail_metadata_view.dart';
import 'package:open_words/features/word/detail/widgets/word_detail_page.dart';
import 'package:open_words/features/word/detail/widgets/word_info_card.dart';
import 'package:open_words/shared/constants/list_padding_constans.dart';

class WordDetailPage extends StatelessWidget {
  final WordGroup group;
  final Word word;

  const WordDetailPage({super.key, required this.group, required this.word});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => WordDetailPageCubit(
            metadataService: GetIt.I.get(),
            group: group,
            word: word,
          )..init(),
      child: WordDetailView(),
    );
  }
}

class WordDetailView extends StatelessWidget {
  const WordDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WordDetailTitle(),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.delete_outline)),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(bottom: ListPaddingConstans.bottomForFab),
        children: [
          WordInfoCard(),
          const SizedBox(height: 12),
          TextToSpeechCard(),
          WordDetailMetadataView(),
        ],
      ),
      floatingActionButton: WordDetailFab(),
    );
  }
}
