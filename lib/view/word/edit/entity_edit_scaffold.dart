import 'package:flutter/material.dart';
import 'package:open_words/service/navigation/material_navigator.dart';

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
