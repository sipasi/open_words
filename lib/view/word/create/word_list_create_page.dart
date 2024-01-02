import 'package:flutter/material.dart';
import 'package:open_words/data/language_info.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/service/result.dart';
import 'package:open_words/view/shared/layout/constraints_adaptive_layout.dart';
import 'package:open_words/view/shared/layout/orientation_adaptive_layout.dart';
import '../../shared/layout/column_row_view.dart';
import 'text_edit_card.dart';
import 'text_editing_view_model.dart';
import 'word_list_create_view_model.dart';

class WordListCreatePage extends StatefulWidget {
  final String name;
  final LanguageInfo origin;
  final LanguageInfo translation;
  final int startIndex;

  const WordListCreatePage({
    super.key,
    required this.name,
    required this.origin,
    required this.translation,
    required this.startIndex,
  });

  @override
  State<WordListCreatePage> createState() => _WordListCreatePageState();
}

class _WordListCreatePageState extends State<WordListCreatePage> {
  late WordListCreateViewModel viewmodel;

  @override
  void initState() {
    super.initState();

    viewmodel = WordListCreateViewModel(
      startIndex: widget.startIndex,
      originInfo: widget.origin,
      translationInfo: widget.translation,
    );
  }

  @override
  void dispose() {
    super.dispose();

    viewmodel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(widget.name),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Save'),
        icon: const Icon(Icons.save),
        onPressed: () => MaterialNavigator.popWith(
          context,
          CrudResult.create(viewmodel.toList()),
        ),
      ),
      body: _adaptive(),
    );
  }

  Widget _adaptive() {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: OrientationAdaptiveLayout(
        portrait: (context) {
          return Column(children: [
            _inputFields(),
            const SizedBox(height: 10),
            _bottons(),
            Expanded(child: _list()),
          ]);
        },
        landscape: (context) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _list()),
              const VerticalDivider(),
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Column(
                    children: [
                      _inputFields(),
                      const SizedBox(height: 10),
                      _bottons(),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _inputFields() {
    return Column(children: [
      toTextEditCart(viewmodel: viewmodel.origin, hint: 'Enter origin', autofocus: true),
      const SizedBox(height: 10),
      toTextEditCart(viewmodel: viewmodel.translation, hint: 'Enter translation'),
    ]);
  }

  Widget _bottons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FilledButton.tonalIcon(
          label: const Text('Translator'),
          icon: const Icon(Icons.translate_outlined),
          onPressed: () => viewmodel.tryTranslate(setState),
        ),
        FilledButton.icon(
          label: const Text('Add'),
          icon: const Icon(Icons.add),
          onPressed: () => viewmodel.tryAdd(setState),
        ),
      ],
    );
  }

  Widget _list() {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 100),
      itemCount: viewmodel.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final word = viewmodel.get(index);

        return ListTile(
          title: Text(word.origin),
          subtitle: Text(word.translation),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => viewmodel.remove(index, setState),
          ),
        );
      },
    );
  }

  static Widget toTextEditCart({
    required TextEditingViewModel viewmodel,
    required String hint,
    bool autofocus = false,
  }) {
    return TextEditCard(
      controller: viewmodel.controller,
      autofocus: autofocus,
      focusNode: viewmodel.focusNode,
      hint: hint,
      onClear: () => viewmodel.clear(),
      onCopy: () => viewmodel.copyToClipboard(),
      onPaste: () => viewmodel.pasteFromClipboard(),
      error: viewmodel.error,
    );
  }
}
