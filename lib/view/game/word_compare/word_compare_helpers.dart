import 'package:flutter/material.dart';

class WordCompareHelpers extends StatelessWidget {
  final List<String> helpers;

  final int visibleDefinitions;
  final void Function() onHelpTap;

  const WordCompareHelpers({
    super.key,
    required this.helpers,
    required this.visibleDefinitions,
    required this.onHelpTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemCount: visibleDefinitions,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final definition = helpers[index];

              return Text(
                definition,
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              );
            },
          ),
        ),
        if (canLoad())
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onHelpTap,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Help'),
                  SizedBox(width: 4),
                  Icon(Icons.help_outline),
                ],
              ),
            ),
          ),
      ],
    );
  }

  bool canLoad() {
    return visibleDefinitions != helpers.length;
  }
}
