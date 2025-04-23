import 'package:flutter/material.dart';
import 'package:open_words/shared/widget_builder/value_builder.dart';

class PhoneticListTile extends StatelessWidget {
  final String value;
  final String audio;

  const PhoneticListTile({super.key, required this.value, required this.audio});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: value.isNotEmptyBuilder(Text.new),
      subtitle: audio.isNotEmptyBuilder(Text.new),
      onTap: audio.isNotEmptyBuilder((value) => () => {}),
      trailing: audio.isNotEmptyBuilder(
        (value) => const Icon(Icons.volume_up_outlined),
      ),
    );
  }
}
