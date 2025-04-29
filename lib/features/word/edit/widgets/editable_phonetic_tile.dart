import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/result/result.dart';
import 'package:open_words/features/word/edit/bloc/word_edit_bloc.dart';
import 'package:open_words/features/word/edit/widgets/editable_list_tile.dart';
import 'package:open_words/features/word_metadata/editor_phonetic/editor_phonetic_bottom_sheet.dart';
import 'package:open_words/shared/builders/value_builder_extension.dart';

class EditablePhoneticTile extends StatelessWidget {
  const EditablePhoneticTile({super.key});

  @override
  Widget build(BuildContext context) {
    final phonetics = context.select(
      (WordEditBloc value) => value.state.phonetics,
    );

    return EditableListTile.card(
      title: 'Phonetic',
      itemCount: phonetics.length,
      onCreateTap: () async {
        final result = await EditorPhoneticBottomSheet.create(context: context);

        result.onCreated(
          (value) => context.read<WordEditBloc>().add(
            WordEditPhoneticCreateRequested(
              value: value.value,
              audio: value.audio,
            ),
          ),
        );
      },
      builder: (context, index) {
        final item = phonetics[index];

        return ListTile(
          title: item.value.isNotEmptyBuilder(Text.new),
          subtitle: item.audio.isNotEmptyBuilder(Text.new),
          onTap: () async {
            final result = await EditorPhoneticBottomSheet.edit(
              context: context,
              phonetic: item,
            );

            result.onModified(
              (value) => context.read<WordEditBloc>().add(
                WordEditPhoneticUpdateRequested(
                  toUpdate: item,
                  value: value.value,
                  audio: value.audio,
                ),
              ),
            );
            result.onDeleted(
              (_) => context.read<WordEditBloc>().add(
                WordEditPhoneticDeleteRequested(item),
              ),
            );
          },
        );
      },
    );
  }
}
