import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/features/word/detail/cubit/word_detail_page_cubit.dart';
import 'package:open_words/features/word/detail/widgets/text_to_speech_card.dart';
import 'package:open_words/features/word/detail/widgets/word_detail_fab.dart';
import 'package:open_words/features/word/detail/widgets/word_info_card.dart';
import 'package:open_words/shared/constants/hero_tag_constants.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class WordDetailPage extends StatelessWidget {
  final WordGroup group;
  final Word word;

  const WordDetailPage({super.key, required this.group, required this.word});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WordDetailPageCubit(group: group, word: word),
      child: WordDetailView(),
    );
  }
}

class WordDetailView extends StatelessWidget {
  const WordDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordDetailPageCubit, WordDetailPageState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Hero(
              tag: HeroTagConstants.appbarTitleTag,
              child: Text(
                state.group.name,
                style: context.textTheme.titleLarge,
              ),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.delete_outline)),
            ],
          ),
          body: ListView(
            children: [
              WordInfoCard(
                origin: state.origin,
                translation: state.translation,
              ),
              const SizedBox(height: 12),
              TextToSpeechCard(
                origin: state.origin,
                translation: state.translation,
                onOriginTap: (value) {},
                onTranslationTap: (value) {},
              ),
              Card.outlined(),
            ],
          ),
          floatingActionButton: WordDetailFab(),
        );
      },
    );
  }
}
