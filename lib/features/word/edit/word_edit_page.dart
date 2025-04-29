import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/entities/metadata/word_metadata.dart';
import 'package:open_words/features/word/edit/bloc/word_edit_bloc.dart';
import 'package:open_words/features/word/edit/widgets/editable_meaning_tile.dart';
import 'package:open_words/features/word/edit/widgets/editable_phonetic_tile.dart';
import 'package:open_words/features/word/edit/widgets/word_edit_etymology_editor.dart';
import 'package:open_words/features/word/edit/widgets/word_edit_fab.dart';
import 'package:open_words/features/word/edit/widgets/word_edit_title.dart';
import 'package:open_words/features/word/edit/widgets/word_edit_translation_editor.dart';
import 'package:open_words/shared/constants/list_padding_constans.dart';
import 'package:open_words/shared/modal/discard_changes_modal.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class WordEditPage extends StatelessWidget {
  final Id id;
  final String origin;
  final String translation;
  final WordMetadata metadata;

  const WordEditPage({
    super.key,
    required this.id,
    required this.metadata,
    required this.origin,
    required this.translation,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => WordEditBloc(
            metadataRepository: GetIt.I.get(),
            wordId: id,
            metadataId: metadata.id,
            initialMetadata: metadata,
            initialOrigin: origin,
            initialTranslation: translation,
          )..add(WordEditStarted(translation: translation, metadata: metadata)),
      child: WordEditView(),
    );
  }
}

class WordEditView extends StatelessWidget {
  const WordEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        _onPopInvoked(context, didPop, result);
      },
      child: BlocListener<WordEditBloc, WordEditState>(
        listener: (context, state) {
          if (state.saveStatus == WordEditSaveStatus.saved) {
            context.pop();
          }
        },
        child: Scaffold(
          appBar: AppBar(title: WordEditTitle()),
          body: ListView(
            padding: const EdgeInsets.only(
              bottom: ListPaddingConstans.bottomForFab,
            ),
            children: [
              WordEditTranslationEditor(),
              WordEditEtymologyEditor(),
              EditablePhoneticTile(),
              EditableMeaningTile(),
            ],
          ),
          floatingActionButton: WordEditFab(),
        ),
      ),
    );
  }

  Future _onPopInvoked(BuildContext context, bool didPop, result) async {
    final bloc = context.read<WordEditBloc>();
    final state = bloc.state;

    if (didPop || state.saveStatus == WordEditSaveStatus.saved) {
      return;
    }

    final changes =
        bloc.initialTranslation != state.translation ||
        bloc.initialMetadata.etymology != state.etymology ||
        listEquals(bloc.initialMetadata.meanings, state.meanings) == false ||
        listEquals(bloc.initialMetadata.phonetics, state.phonetics) == false ||
        state.phoneticsRemoved.isNotEmpty ||
        state.meaningsRemoved.isNotEmpty;

    if (changes == false) {
      return context.pop();
    }

    final shouldPop = await DiscardChangesModal.dialog(context: context);

    if (context.mounted && shouldPop) {
      return context.pop();
    }
  }
}
