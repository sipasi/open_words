import 'package:flutter/material.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/view/shared/tile/text_tile.dart';

class GameTile extends StatelessWidget {
  final String name;
  final String description;

  final int needWords;

  final int count;

  final Widget Function(BuildContext) route;

  const GameTile({super.key, 
    required this.name,
    required this.description,
    required this.needWords,
    required this.count,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    final scheem = Theme.of(context).colorScheme;

    bool notEnough = count < needWords;

    return Card.outlined(
      child: TextTile(
        padding: const EdgeInsets.all(14.0),
        title: name,
        subtitle: notEnough ? _notEnoughMessage() : description,
        subtitleStyle: notEnough ? TextStyle(color: scheem.error) : null,
        subtitleLines: 2,
        onTap: notEnough ? null : () => MaterialNavigator.push(context, route),
      ),
    );
  }

  String _notEnoughMessage() {
    return 'To play needs at least $needWords words';
  }
}
