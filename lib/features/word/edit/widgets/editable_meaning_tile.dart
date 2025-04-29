import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/metadata/meaning.dart';
import 'package:open_words/core/result/result.dart';
import 'package:open_words/features/word/edit/bloc/word_edit_bloc.dart';
import 'package:open_words/features/word/edit/widgets/editable_list_tile.dart';
import 'package:open_words/features/word_metadata/editor_meaning/editor_meaning_bottom_sheet.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class EditableMeaningTile extends StatelessWidget {
  const EditableMeaningTile({super.key});

  @override
  Widget build(BuildContext context) {
    final meanings = context.select(
      (WordEditBloc value) => value.state.meanings,
    );

    return EditableListTile.card(
      title: 'Meanings',
      itemCount: meanings.length,
      onCreateTap: () => _onCreate(context),
      builder: (context, index) {
        final meaning = meanings[index];

        return InkWell(
          onTap: () => _onEdit(context, meaning),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                title: Align(
                  alignment: Alignment.centerLeft,
                  child: RawChip(
                    backgroundColor: context.colorScheme.primaryContainer,
                    label: Text(
                      meaning.partOfSpeech,
                      style: TextStyle(
                        color: context.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              if (meaning.synonyms.isNotEmpty)
                ListTile(
                  title: Text('Synonyms'),
                  subtitle: Text(meaning.synonyms.join(', ')),
                ),
              if (meaning.antonyms.isNotEmpty)
                ListTile(
                  title: Text('Antonyms'),
                  subtitle: Text(meaning.antonyms.join(', ')),
                ),
              if (meaning.definitions.isNotEmpty)
                ListTile(
                  title: Text('Definitions'),
                  subtitle: Text(meaning.definitions.length.toString()),
                ),
            ],
          ),
        );
      },
    );
  }

  Future _onCreate(BuildContext context) async {
    final bloc = context.read<WordEditBloc>();

    final result = await EditorMeaningBottomSheet.create(
      context: context,
      metadataId: bloc.metadataId,
    );

    result.onCreated(
      (value) => bloc.add(
        WordEditMeaningCreateRequested(
          partOfSpeech: value.partOfSpeech,
          definitions: value.definitions,
          synonyms: value.synonyms,
          antonyms: value.antonyms,
        ),
      ),
    );
  }

  Future _onEdit(BuildContext context, Meaning meaning) async {
    final bloc = context.read<WordEditBloc>();

    final result = await EditorMeaningBottomSheet.edit(
      context: context,
      metadataId: bloc.metadataId,
      meaning: meaning,
    );

    result.onModified(
      (value) => bloc.add(
        WordEditMeaningUpdateRequested(
          toUpdate: meaning,
          partOfSpeech: value.partOfSpeech,
          definitions: value.definitions,
          synonyms: value.synonyms,
          antonyms: value.antonyms,
        ),
      ),
    );
    result.onDeleted(
      (value) => bloc.add(WordEditMeaningDeleteRequested(meaning)),
    );
  }
}
