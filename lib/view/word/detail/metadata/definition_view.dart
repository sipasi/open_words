import 'package:flutter/material.dart';
import 'package:open_words/data/metadata/definition.dart';

class DefinitionView extends StatelessWidget {
  static const EdgeInsetsGeometry textPadding = EdgeInsets.symmetric(vertical: 10, horizontal: 10);

  final Definition definition;

  final TextStyle firstStyle;
  final TextStyle otherStyle;

  final Function(String text) onDefinitionTap;
  final Function(String text) onDefinitionLongPress;
  final Function(String text) onExampleTap;
  final Function(String text) onExampleLongPress;

  const DefinitionView({
    super.key,
    required this.definition,
    required this.firstStyle,
    required this.otherStyle,
    required this.onDefinitionTap,
    required this.onDefinitionLongPress,
    required this.onExampleTap,
    required this.onExampleLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return IntrinsicHeight(
      child: Row(
        children: [
          Container(
            color: colorScheme.primary,
            width: 2,
          ),
          Expanded(child: _getColumn(firstStyle, otherStyle)),
        ],
      ),
    );
  }

  Widget _getColumn(TextStyle first, TextStyle other) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _getInkWell(
          first: 'Definition: ',
          second: definition.value,
          firstStyle: first,
          otherStyle: other,
          onTap: () => onDefinitionTap(definition.value),
          onLongPress: () => onDefinitionLongPress(definition.value),
        ),
        definition.example != null
            ? _getInkWell(
                first: 'Example: ',
                second: definition.example!,
                firstStyle: first,
                otherStyle: other,
                onTap: () => onExampleTap(definition.example!),
                onLongPress: () => onExampleLongPress(definition.example!),
              )
            : Container(),
      ],
    );
  }

  static Widget _getInkWell({
    required String first,
    required String second,
    required TextStyle firstStyle,
    required TextStyle otherStyle,
    required void Function() onTap,
    required void Function() onLongPress,
  }) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: textPadding,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: first, style: firstStyle),
              TextSpan(text: second, style: otherStyle),
            ],
          ),
        ),
      ),
    );
  }
}
