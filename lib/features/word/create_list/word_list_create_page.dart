import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/data/draft/word_draft.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/features/explorer/bloc/explorer_bloc.dart';
import 'package:open_words/features/word/create_list/cubit/word_list_create_cubit.dart';
import 'package:open_words/features/word/create_list/widgets/word_draft_editor.dart';
import 'package:open_words/features/word/create_list/widgets/word_draft_list_view.dart';
import 'package:open_words/features/word_group/detail/cubit/word_group_detail_cubit.dart';
import 'package:open_words/shared/input_fields/text_edit_controller.dart';
import 'package:open_words/shared/modal/discard_changes_modal.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class WordListCreatePage extends StatelessWidget {
  final WordGroup group;

  const WordListCreatePage({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WordListCreateCubit>(
      create:
          (context) => WordListCreateCubit(
            group: group,
            groupRepository: GetIt.I.get(),
            wordRepository: GetIt.I.get(),
          ),
      child: WordListCreateView(),
    );
  }
}

class WordListCreateView extends StatefulWidget {
  const WordListCreateView({super.key});

  @override
  State<WordListCreateView> createState() => _WordListCreateViewState();
}

class _WordListCreateViewState extends State<WordListCreateView> {
  final TextEditController origin = TextEditController.text();
  final TextEditController translation = TextEditController.text();

  late final StreamSubscription<WordListUiEvent> _clearInputSubscription;
  late final StreamSubscription<WordDraft> _daraftRemovedSubscription;

  @override
  void initState() {
    super.initState();

    final bloc = context.read<WordListCreateCubit>();

    _clearInputSubscription = bloc.uiEvents.listen((event) {
      if (event == WordListUiEvent.clearAllInput) {
        origin.clear();
        translation.clear();
      }
    });
    _daraftRemovedSubscription = bloc.draftRemovedEvent.listen((event) {
      origin.setText(event.origin);
      translation.setText(event.translation);
    });
  }

  @override
  void dispose() {
    _clearInputSubscription.cancel();
    _daraftRemovedSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult:
          (didPop, result) => _onPopHandler(context, didPop, result),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => _onSave(context),
              icon: Icon(Icons.save_outlined),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              WordDraftEditor(origin: origin, translation: translation),
              const SizedBox(height: 8),
              WordDraftListView(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Future _onPopHandler(
    BuildContext context,
    bool didPop,
    Object? result,
  ) async {
    if (didPop) {
      return;
    }
    if (context.read<WordListCreateCubit>().state.drafts.isEmpty) {
      context.pop();
      return;
    }

    final shouldPop = await DiscardChangesModal.dialog(context: context);

    if (shouldPop && context.mounted) {
      context.pop();
    }
  }

  Future _onSave(BuildContext context) async {
    await context.read<WordListCreateCubit>().save();

    if (!context.mounted) {
      return;
    }

    context.read<WordGroupDetailCubit>().init();
    context.read<ExplorerBloc>().add(ExplorerRefreshRequested());
    context.pop();
  }
}
