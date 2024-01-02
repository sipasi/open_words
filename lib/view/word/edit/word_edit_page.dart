import 'package:flutter/material.dart';
import 'package:open_words/data/metadata/definition.dart';
import 'package:open_words/data/metadata/meaning.dart';
import 'package:open_words/data/metadata/phonetic.dart';
import 'package:open_words/data/metadata/word_metadata.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/service/result.dart';

class WordEditPage extends StatefulWidget {
  final Word word;
  final WordMetadata? metadata;

  const WordEditPage({
    super.key,
    required this.word,
    this.metadata,
  });

  @override
  State<WordEditPage> createState() => _WordEditPageState();
}

class _WordEditPageState extends State<WordEditPage> {
  late final List<Phonetic> _phonetics;
  late final List<Meaning> _meanings;

  final TextEditingController _translation = TextEditingController();

  @override
  void initState() {
    super.initState();
    WordMetadata? metadata = widget.metadata;

    _phonetics = metadata?.phonetics.toList() ?? [];
    _meanings = metadata?.meanings.toList() ?? [];

    _translation.text = widget.word.translation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.word.origin),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () async {
              final result = await PhoneticEdit.pageCreate(context);

              result.contain<Phonetic>((value) {
                setState(() {
                  _phonetics.add(value);
                });
              });
            },
            icon: const Icon(Icons.music_note),
            label: const Text('phonetic'),
            heroTag: 'save_phonetic_hero',
            isExtended: true,
          ),
          const SizedBox(width: 10),
          FloatingActionButton.extended(
            onPressed: () async {
              await MeaningEdit.pageCreate(context);
            },
            icon: const Icon(Icons.menu_book_outlined),
            label: const Text('meanings'),
            heroTag: 'save_meaning_hero',
            isExtended: true,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            WordEditControl(translation: _translation, padding: const EdgeInsets.symmetric(horizontal: 10)),
            const Divider(height: 40),
            _phoneticsListView(),
            const Divider(height: 40),
            _meaningsListView(),
          ],
        ),
      ),
    );
  }

  Widget _phoneticsListView() {
    final theme = Theme.of(context);
    final boldStyle = theme.textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.secondary,
    );

    if (_phonetics.isNotEmpty) {
      return Column(
        children: [
          Text(
            'Phonetics',
            style: boldStyle,
          ),
          Card(
            child: Column(
              children: List.generate(
                _phonetics.length,
                (index) {
                  final entity = _phonetics[index];

                  return ListTile(
                    title: Text(entity.value),
                    contentPadding: EdgeInsets.zero,
                    subtitle: entity.audio != null ? Text(entity.audio!) : null,
                    leading: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _phonetics.removeAt(index);
                        });
                      },
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        final result = await PhoneticEdit.pageEdit(context, entity);

                        result.modified<Phonetic>((value) {
                          setState(() {
                            _phonetics[index] = value;
                          });
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );
    }

    return _createFirstText('Definition');
  }

  Widget _meaningsListView() {
    final theme = Theme.of(context);
    final boldStyle = theme.textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.secondary,
    );

    if (_meanings.isNotEmpty) {
      return Column(
        children: [
          Text(
            'Meanings',
            style: boldStyle,
          ),
          Card(
            child: Column(
              children: List.generate(
                _meanings.length,
                (index) {
                  final entity = _meanings[index];

                  return _meaningTile(entity, index);
                },
              ),
            ),
          ),
        ],
      );
    }

    return _createFirstText('Meaning');
  }

  RichText _createFirstText(String text) {
    final theme = Theme.of(context);
    final boldStyle = theme.textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.bold,
    );

    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: 'Create first ',
          style: boldStyle?.copyWith(color: theme.colorScheme.secondary),
        ),
        TextSpan(
          text: text,
          style: boldStyle?.copyWith(color: theme.colorScheme.primary),
        ),
      ]),
      textAlign: TextAlign.center,
    );
  }

  ListTile _meaningTile(Meaning entity, int index) {
    return ListTile(
      title: Text(entity.partOfSpeech),
      contentPadding: EdgeInsets.zero,
      titleAlignment: ListTileTitleAlignment.top,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('synonyms: ${entity.synonyms.length}'),
          Text('antonyms: ${entity.antonyms.length}'),
          Text('definitions: ${entity.definitions.length}'),
        ],
      ),
      leading: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          setState(() {
            _meanings.removeAt(index);
          });
        },
      ),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () async {
          final result = await MeaningEdit.pageEdit(context, entity);

          result.modified<Meaning>((value) {
            setState(() {
              _meanings[index] = value;
            });
          });
        },
      ),
    );
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

class PhoneticEdit extends StatelessWidget {
  final _phonetic = TextEditingController();
  final _source = TextEditingController();

  PhoneticEdit({super.key});
  PhoneticEdit.from({super.key, required Phonetic entity}) {
    _phonetic.text = entity.value;
    _source.text = entity.audio ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return EntityEditScaffold(
      saveHeroTag: 'save_phonetic_hero',
      onSave: () {
        if (_phonetic.text.isEmpty) {
          return;
        }

        final entity = Phonetic(value: _phonetic.text, audio: _source.text);

        MaterialNavigator.popWith(context, CrudResult.create(entity));
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

  static Future<CrudResult> pageCreate(BuildContext context) {
    return MaterialNavigator.push(
      context,
      (context) => PhoneticEdit(),
    );
  }

  static Future<CrudResult> pageEdit(BuildContext context, Phonetic entity) {
    return MaterialNavigator.push(
      context,
      (context) => PhoneticEdit.from(entity: entity),
    );
  }
}

class MeaningEdit extends StatefulWidget {
  static const double _spacing = 10;

  final Meaning? meaning;

  const MeaningEdit({super.key, this.meaning});

  @override
  State<MeaningEdit> createState() => _MeaningEditState();

  static Future<Result> pageCreate(BuildContext context) {
    return MaterialNavigator.push(
      context,
      (context) => const MeaningEdit(),
    );
  }

  static Future<CrudResult> pageEdit(BuildContext context, Meaning meaning) {
    return MaterialNavigator.push(
      context,
      (context) => MeaningEdit(meaning: meaning),
    );
  }
}

class _MeaningEditState extends State<MeaningEdit> {
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
      saveHeroTag: 'save_meaning_hero',
      onSave: () {},
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: _textFields(),
            ),
            const SizedBox(height: MeaningEdit._spacing),
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
            const SizedBox(height: MeaningEdit._spacing),
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
        const SizedBox(height: MeaningEdit._spacing),
        TextField(
          controller: _partOfSpeech,
          decoration: const InputDecoration(
            labelText: 'Part of speech',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: MeaningEdit._spacing),
        TextField(
          controller: _synonyms,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: const InputDecoration(
            labelText: 'synonyms',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: MeaningEdit._spacing),
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

  Widget _definitionList() {
    return Card(
      elevation: 5,
      child: ListView.separated(
          itemCount: _definitions.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final definition = _definitions[index];

            return ListTile(
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
            );
          }),
    );
  }
}

class EntityEditScaffold extends StatelessWidget {
  final Widget body;

  final void Function() onSave;

  final EdgeInsetsGeometry padding;

  final Color? backgroundColor;

  final String saveHeroTag;

  const EntityEditScaffold({
    super.key,
    required this.body,
    required this.onSave,
    this.padding = const EdgeInsets.all(10.0),
    this.backgroundColor,
    this.saveHeroTag = '<default FloatingActionButton tag>',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
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
        heroTag: saveHeroTag,
        label: const Text('Save'),
      ),
      body: Padding(
        padding: padding,
        child: body,
      ),
    );
  }
}
