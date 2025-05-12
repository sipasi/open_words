import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/data/entities/metadata/definition.dart';
import 'package:open_words/core/services/text_to_speech/text_to_speech_service.dart';
import 'package:open_words/features/word/detail/cubit/word_detail_page_cubit.dart';
import 'package:open_words/features/word_metadata/detail/widgets/definition_list_tile_part.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class DefinitionListTile extends StatelessWidget {
  final Definition definition;

  const DefinitionListTile({super.key, required this.definition});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return IntrinsicHeight(
      child: Row(
        children: [
          Container(color: colorScheme.primary, width: 2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DefinitionListTilePart(
                  title: 'Definition: ',
                  details: definition.value,
                  onTap: () => onDefinitionTap(context, definition.value),
                  onLongPress:
                      () => onDefinitionLongPress(context, definition.value),
                ),
                if (definition.example.isNotEmpty)
                  DefinitionListTilePart(
                    title: 'Example: ',
                    details: definition.example,
                    onTap: () => onExampleTap(context, definition.example),
                    onLongPress:
                        () => onExampleLongPress(context, definition.example),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onDefinitionTap(BuildContext context, String value) =>
      _play(context, value);

  void onDefinitionLongPress(BuildContext context, String value) =>
      _play(context, value);
  void onExampleTap(BuildContext context, String value) =>
      _play(context, value);
  void onExampleLongPress(BuildContext context, String value) =>
      _play(context, value);

  void _play(BuildContext context, String value) {
    final tts = GetIt.I.get<TextToSpeechService>();

    final bloc = context.read<WordDetailPageCubit>();

    tts.stopAndSpeek(text: value, language: bloc.group.origin);
  }
}
