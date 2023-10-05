import 'package:flutter/material.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:url_launcher/url_launcher.dart';

class WordCreateDialog extends StatefulWidget {
  final WordGroup parent;

  const WordCreateDialog({
    super.key,
    required this.parent,
  });

  @override
  State<WordCreateDialog> createState() => _WordCreateDialogState();

  static Future<List<Word>> show({required BuildContext context, required WordGroup parent}) async {
    final result = await showDialog<List<Word>>(
      context: context,
      builder: (context) => WordCreateDialog(parent: parent),
      barrierDismissible: false,
    );

    return result ?? List.empty();
  }
}

class _WordCreateDialogState extends State<WordCreateDialog> {
  List<Word> created = [];

  final TextEditingController _origin = TextEditingController();

  final TextEditingController _translation = TextEditingController();

  String? _originError;
  String? _translationError;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        shrinkWrap: true,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Saved: ${created.length}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  )),
              IconButton(
                icon: const Icon(Icons.cancel),
                onPressed: () => Navigator.pop(context, created),
              ),
            ],
          ),
          TextField(
            controller: _origin,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Enter origin',
              labelText: 'Origin',
              errorText: _originError,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _translation,
            decoration: InputDecoration(
              hintText: 'Enter translation',
              labelText: 'Translation',
              errorText: _translationError,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FilledButton.tonalIcon(
                label: const Text('Translator'),
                icon: const Icon(Icons.translate_outlined),
                onPressed: () async {
                  bool originEmpty = _origin.text.isEmpty;

                  setState(() {
                    _originError = originEmpty ? 'Can\'t open translator while origin is empty' : null;
                  });

                  if (originEmpty) {
                    return;
                  }

                  final parent = widget.parent;

                  final address = Uri.https(
                    'translate.google.com',
                    '/',
                    {
                      'sl': parent.origin.code,
                      'tl': parent.translation.code,
                      'text': _origin.text,
                      'op': 'translate',
                    },
                  );

                  launchUrl(
                    address,
                    mode: LaunchMode.platformDefault,
                  );
                },
              ),
              FilledButton.icon(
                label: const Text('Save'),
                icon: const Icon(Icons.save_outlined),
                onPressed: () {
                  bool originEmpty = _origin.text.isEmpty;
                  bool translationEmpty = _translation.text.isEmpty;

                  setState(() {
                    _originError = originEmpty ? 'Can\'t save while origin is empty' : null;
                    _translationError = translationEmpty ? 'Can\'t save while translation is empty' : null;
                  });

                  if (originEmpty || translationEmpty) {
                    return;
                  }

                  final startIndex = widget.parent.words.length;

                  final word = Word(
                    index: created.length + startIndex,
                    origin: _origin.text,
                    translation: _translation.text,
                  );

                  created.add(word);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
