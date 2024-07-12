import 'package:flutter/material.dart';
import 'package:open_words/data/word/word_group.dart';

import 'game_list_view.dart';

class GameListPage extends StatelessWidget {
  final WordGroup group;

  const GameListPage({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(group.name)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          children: [
            GameListView(group: group),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
