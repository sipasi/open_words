import 'package:flutter/material.dart';

class SynonymAntonymView extends StatelessWidget {
  final String groupName;
  final List<String> values;

  final TextStyle firstStyle;
  final TextStyle otherStyle;

  final Function(String text) onTap;
  final Function(String text) onLongPress;

  const SynonymAntonymView({
    super.key,
    required this.groupName,
    required this.values,
    required this.firstStyle,
    required this.otherStyle,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 3,
      children: [
        Text(
          '$groupName:',
          style: firstStyle,
        ),
        ...List.generate(values.length, (index) {
          final text = values[index];

          return InkWell(
            child: Text('$text;', style: otherStyle),
            onTap: () => onTap(text),
            onLongPress: () => onLongPress(text),
          );
        })
      ],
    );
  }
}
