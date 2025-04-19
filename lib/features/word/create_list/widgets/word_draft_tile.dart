import 'package:flutter/material.dart';
import 'package:open_words/core/data/draft/word_draft.dart';

class WordDraftTile extends StatelessWidget {
  final WordDraft draft;
  final void Function() onRemoveTap;

  const WordDraftTile({
    super.key,
    required this.draft,
    required this.onRemoveTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(draft.origin),
      subtitle: Text(draft.translation),
      trailing: IconButton(
        onPressed: onRemoveTap,
        icon: Icon(Icons.delete_outline),
      ),
    );
  }
}
