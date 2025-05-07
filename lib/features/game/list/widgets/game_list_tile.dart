import 'package:flutter/material.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class GameListTile extends StatelessWidget {
  final String name;
  final String description;

  final int wordsNeed;
  final int words;

  final Widget Function(BuildContext)? route;

  const GameListTile({
    super.key,
    required this.name,
    required this.description,
    required this.wordsNeed,
    required this.words,
    this.route,
  });

  @override
  Widget build(BuildContext context) {
    bool notEnough = words < wordsNeed;

    return ListTile(
      title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: notEnough ? _notEnoughMessage(context) : Text(description),
      onTap: notEnough ? null : () => context.push(route!),
    );
  }

  Widget _notEnoughMessage(BuildContext context) {
    return Text(
      'To play needs at least $wordsNeed words',
      style: TextStyle(color: context.colorScheme.error),
    );
  }
}
