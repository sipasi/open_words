import 'package:flutter/material.dart';
import 'package:open_words/data/metadata/definition.dart';
import 'package:open_words/data/metadata/meaning.dart';
import 'package:open_words/data/metadata/phonetic.dart';
import 'package:open_words/data/metadata/word_metadata.dart';
import 'package:open_words/data/metadata/word_metadata_genarator.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/service/navigation/material_navigator.dart';

class WordEditPage extends StatefulWidget {
  final Word word = const Word(origin: 'advise', translation: 'порада', index: 0);

  const WordEditPage({super.key});

  @override
  State<WordEditPage> createState() => _WordEditPageState();
}

class _WordEditPageState extends State<WordEditPage> {
  final WordMetadata metadata = WordMetadataGenarator.get();

  final List<Phonetic> phonetics = [];

  final TextEditingController _translation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.word.origin),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FilledButton.tonalIcon(
            onPressed: () async {
              final result = await PhoneticBottomSheet.showCreate(context);

              result.contain<Phonetic>((value) {
                setState(() {
                  phonetics.add(value);
                });
              });
            },
            icon: const Icon(Icons.music_note),
            label: const Text('phonetic'),
          ),
          const SizedBox(width: 10),
          FilledButton.tonalIcon(
            onPressed: () async {
              final meaning = Meaning(
                partOfSpeech: 'adv',
                definitions: [
                  Definition(
                    value: 'Duis nisi minim nostrud aliquip quis exercitation nostrud.',
                    example: 'Est qui mollit aliqua qui.',
                  ),
                  Definition(
                    value: 'Duis nisi minim nostrud aliquip quis exercitation nostrud.',
                    example: 'Est qui mollit aliqua qui.',
                  ),
                  Definition(
                    value: 'Duis nisi minim nostrud aliquip quis exercitation nostrud.',
                    example: 'Est qui mollit aliqua qui.',
                  ),
                  Definition(
                    value: 'Duis nisi minim nostrud aliquip quis exercitation nostrud.',
                    example: 'Est qui mollit aliqua qui.',
                  ),
                ],
                synonyms: [
                  'nisi',
                  'minim',
                  'aliquip',
                  'exercitation',
                  'nostrud',
                  'mollit' 'aliquip',
                  'exercitation',
                  'nostrud',
                  'mollit',
                ],
                antonyms: ['nisi'],
              );
              await MeaningBottomSheet.showEdit(context, meaning);
            },
            icon: const Icon(Icons.menu_book_outlined),
            label: const Text('meanings'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            WordEditControl(translation: _translation, padding: const EdgeInsets.symmetric(horizontal: 10)),
            const Divider(height: 50),
            _phoneticsListView(),
            const Divider(height: 30),
            _meaningsListView(),
          ],
        ),
      ),
    );
  }

  Widget _phoneticsListView() {
    if (phonetics.isNotEmpty) {
      return Column(
        children: [
          Text(
            'Phonetics',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Card(
            child: Column(
              children: List.generate(
                phonetics.length,
                (index) {
                  final phonetic = phonetics[index];

                  return ListTile(
                    title: Text(phonetic.value),
                    contentPadding: EdgeInsets.zero,
                    subtitle: phonetic.audio != null ? Text(phonetic.audio!) : null,
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {},
                    ),
                    leading: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {},
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );
    }
    return Container();
  }

  Widget _meaningsListView() {
    if (phonetics.isNotEmpty) {
      return Column(
        children: [
          Text(
            'Meanings',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Card(
            child: Column(
              children: List.generate(
                phonetics.length,
                (index) {
                  final phonetic = phonetics[index];

                  return ListTile(
                    title: Text(phonetic.value),
                    contentPadding: EdgeInsets.zero,
                    subtitle: phonetic.audio != null ? Text(phonetic.audio!) : null,
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {},
                    ),
                    leading: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {},
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );
    }
    return Container();
  }
}

class WordEditControl extends StatelessWidget {
  final TextEditingController translation;
  final EdgeInsetsGeometry padding;

  const WordEditControl({super.key, required this.translation, required this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextField(
        controller: translation,
        decoration: const InputDecoration(labelText: 'translation'),
      ),
    );
  }
}

class PhoneticBottomSheet extends StatelessWidget {
  final _phonetic = TextEditingController();
  final _source = TextEditingController();

  PhoneticBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return EntityEditScaffold(
      onSave: () {
        if (_phonetic.text.isEmpty) {
          return;
        }

        final entity = Phonetic(value: _phonetic.text, audio: _source.text);

        MaterialNavigator.popWith(context, Result.create(entity));
      },
      body: Column(
        children: [
          const SizedBox(height: 10),
          TextField(
            controller: _phonetic,
            decoration: const InputDecoration(
              labelText: 'phonetic',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _source,
            decoration: const InputDecoration(
              labelText: 'source',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  static Future<Result> showCreate(BuildContext context) {
    return MaterialNavigator.bottomSheet(
      context: context,
      builder: (context) => PhoneticBottomSheet(),
      isScrollControlled: true,
      useSafeArea: true,
    );
  }
}

class MeaningBottomSheet extends StatefulWidget {
  static const double _spacing = 10;

  final Meaning? meaning;

  const MeaningBottomSheet({super.key, this.meaning});

  @override
  State<MeaningBottomSheet> createState() => _MeaningBottomSheetState();

  static Future<Result> showCreate(BuildContext context) {
    return MaterialNavigator.bottomSheet(
      context: context,
      builder: (context) => const MeaningBottomSheet(),
      isScrollControlled: true,
      useSafeArea: true,
    );
  }

  static Future<Result> showEdit(BuildContext context, Meaning meaning) {
    return MaterialNavigator.bottomSheet(
      context: context,
      builder: (context) => MeaningBottomSheet(meaning: meaning),
      isScrollControlled: true,
      useSafeArea: true,
    );
  }
}

class _MeaningBottomSheetState extends State<MeaningBottomSheet> {
  final List<Definition> _definitions = [];

  final _partOfSpeech = TextEditingController();
  final _synonyms = TextEditingController();
  final _antonyms = TextEditingController();

  @override
  void initState() {
    super.initState();

    final meaning = widget.meaning;

    if (meaning == null) {
      return;
    }

    _partOfSpeech.text = meaning.partOfSpeech;
    _synonyms.text = meaning.synonyms.join(', ');
    _antonyms.text = meaning.antonyms.join(', ');

    _definitions.addAll(meaning.definitions);
  }

  @override
  Widget build(BuildContext context) {
    return EntityEditScaffold(
      padding: EdgeInsets.zero,
      onSave: () {},
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: _textFields(),
            ),
            const SizedBox(height: MeaningBottomSheet._spacing),
            TextButton(
                onPressed: () {
                  setState(() {
                    _definitions.add(
                      Definition(
                          value:
                              'Non fugiat mollit eu veniam ullamco nostrud eiusmod eiusmod dolore aute adipisicing labore incididunt.',
                          example:
                              'Fugiat Lorem ullamco adipisicing deserunt irure magna veniam eu adipisicing nisi occaecat.'),
                    );
                  });
                },
                child: const Text('Add definition')),
            const SizedBox(height: MeaningBottomSheet._spacing),
            _definitionList(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _textFields() {
    return Column(
      children: [
        const SizedBox(height: MeaningBottomSheet._spacing),
        TextField(
          controller: _partOfSpeech,
          decoration: const InputDecoration(
            labelText: 'Part of speech',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: MeaningBottomSheet._spacing),
        TextField(
          controller: _synonyms,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: const InputDecoration(
            labelText: 'synonyms',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: MeaningBottomSheet._spacing),
        TextField(
          controller: _antonyms,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: const InputDecoration(
            labelText: 'antonyms',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  // keyboardType: TextInputType.multiline,
  // maxLines: null,

  Widget _definitionList() {
    return Card(
      elevation: 5,
      child: Column(
        children: List.generate(_definitions.length, (index) {
          final definition = _definitions[index];

          return Column(
            children: [
              if (index > 0) const Divider(),
              ListTile(
                title: Text(definition.value),
                contentPadding: EdgeInsets.zero,
                subtitle: definition.example != null ? Text(definition.example!) : null,
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {},
                ),
                leading: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {},
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class EntityEditScaffold extends StatelessWidget {
  final Widget body;

  final void Function() onSave;

  final EdgeInsetsGeometry padding;

  const EntityEditScaffold({
    super.key,
    required this.body,
    required this.onSave,
    this.padding = const EdgeInsets.all(20.0),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Container(),
        actions: [
          TextButton(
            onPressed: () => MaterialNavigator.pop(context),
            child: const Text('Discard'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onSave,
        label: const Text('Save'),
      ),
      body: Padding(
        padding: padding,
        child: body,
      ),
    );
  }
}

class PhoneticView extends StatelessWidget {
  final Phonetic phonetic;

  const PhoneticView({super.key, required this.phonetic});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(phonetic.value),
        if (phonetic.audio != null) Text(phonetic.value),
      ],
    );
  }
}
