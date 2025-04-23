import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/word/detail/cubit/word_detail_page_cubit.dart';

class TextToSpeechCard extends StatelessWidget {
  const TextToSpeechCard({super.key});

  @override
  Widget build(BuildContext context) {
    final origin = context.select(
      (WordDetailPageCubit value) => value.state.origin,
    );
    final translation = context.select(
      (WordDetailPageCubit value) => value.state.translation,
    );

    return Card.outlined(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            title: Text(origin),
            subtitle: Text('Text to Speech'),
            trailing: const Icon(Icons.volume_up_outlined),
            onTap: () => _tts(origin),
          ),
          ListTile(
            title: Text(translation),
            subtitle: Text('Text to Speech'),
            trailing: const Icon(Icons.volume_up_outlined),
            onTap: () => _tts(translation),
          ),
        ],
      ),
    );
  }

  Future _tts(String text) async {}
}
