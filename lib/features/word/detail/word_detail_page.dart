import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/features/word/detail/cubit/word_detail_page_cubit.dart';
import 'package:open_words/features/word/detail/widgets/text_to_speech_card.dart';
import 'package:open_words/features/word/detail/widgets/word_info_card.dart';
import 'package:open_words/shared/constants/hero_tag_constants.dart';

class WordDetailPage extends StatelessWidget {
  final Id groupId;
  final String groupName;

  final Word word;

  const WordDetailPage({
    super.key,
    required this.word,
    required this.groupId,
    required this.groupName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordDetailPageCubit, WordDetailPageState>(
      bloc: WordDetailPageCubit(),
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(groupName),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.delete_outline)),
            ],
          ),
          body: ListView(
            children: [
              WordInfoCard(origin: word.origin, translation: word.translation),
              const SizedBox(height: 18),
              TextToSpeechCard(
                origin: word.origin,
                translation: word.translation,
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

class WordDetailFab extends StatelessWidget {
  const WordDetailFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: HeroTagConstants.fabDefaultTag,
      label: Icon(Icons.menu),
      onPressed: () async {
        // await WordDetailBottomSheet.show(context: context);
      },
    );
  }
}
