import 'package:flutter/material.dart';
import 'package:open_words/collection/readonly_list.dart';
import 'package:open_words/view/game/word_compare/helper_text.dart';

class HelperTextListView extends StatelessWidget {
  final IReadonlyList<HelperText> helpers;

  final bool canRequest;

  final void Function() onHelpTap;

  const HelperTextListView({
    super.key,
    required this.helpers,
    required this.canRequest,
    required this.onHelpTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: _listView(),
        ),
        if (canRequest)
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

  Widget _listView() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemCount: helpers.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final helper = helpers[index];

        return Text(
          helper.toString(),
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        );
      },
    );
  }
}
