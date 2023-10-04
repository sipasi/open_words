import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/data/language_info.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/language/language_info_service.dart';
import 'package:open_words/view/shared/dialog/language_list_dialog.dart';

class WordGroupEditPage extends StatefulWidget {
  final WordGroup? group;

  const WordGroupEditPage({super.key, this.group});

  @override
  State<WordGroupEditPage> createState() => _WordGroupEditPageState();
}

class _WordGroupEditPageState extends State<WordGroupEditPage> {
  late final bool isEdit;

  final TextEditingController _nameController = TextEditingController();

  late LanguageInfo origin;
  late LanguageInfo translation;

  @override
  void initState() {
    super.initState();

    final group = widget.group;

    isEdit = group != null;

    if (group == null) {
      final service = GetIt.I.get<LanguageInfoService>();

      origin = service.getByCode('en');
      translation = service.getByCode('uk');

      return;
    }

    _nameController.text = group.name;

    origin = group.origin;
    translation = group.translation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_nameController.text),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_outlined),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              controller: _nameController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: const InputDecoration(
                hintText: 'Enter name',
                labelText: 'Name',
              ),
            ),
          ),
          const SizedBox(height: 10),
          LanguageSelectorTile(
            title: 'Origin',
            language: origin,
            selected: (value) => setState(() => origin = value),
          ),
          LanguageSelectorTile(
            title: 'Translation',
            language: translation,
            selected: (value) => setState(() => translation = value),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class LanguageSelectorTile extends StatelessWidget {
  final String title;
  final LanguageInfo language;

  final void Function(LanguageInfo value) selected;

  const LanguageSelectorTile({
    super.key,
    required this.title,
    required this.language,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(language.native),
      trailing: Text(language.code),
      textColor: Theme.of(context).colorScheme.secondary,
      onTap: () => LanguageListDialog.show(
        context: context,
        current: language.code,
        selected: selected,
      ),
    );
  }
}
