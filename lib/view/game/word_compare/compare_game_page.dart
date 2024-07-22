import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/storage/metadata_storage.dart';
import 'package:open_words/view/game/word_compare/compare_game_view.dart';
import 'package:open_words/view/game/word_compare/word_text_getter.dart';

class CompareGamePage extends StatefulWidget {
  final WordGroup group;
  final WordTextGetter textGetter;

  const CompareGamePage({
    super.key,
    required this.group,
    required this.textGetter,
  });

  @override
  State<CompareGamePage> createState() => _CompareGamePageState();
}

class _CompareGamePageState extends State<CompareGamePage> {
  late final List<Word> words;

  late final MetadataStorage metadataStorage;

  @override
  void initState() {
    super.initState();

    words = widget.group.words.toList(growable: false);

    metadataStorage = GetIt.I.get<MetadataStorage>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0).copyWith(bottom: 20),
          child: CompareGameView(
            words: words,
            metadataStorage: metadataStorage,
            textGetter: widget.textGetter,
          ),
        ),
      ),
    );
  }
}
