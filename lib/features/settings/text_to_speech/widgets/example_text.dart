import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/settings/text_to_speech/cubit/text_to_speech_list_cubit.dart';
import 'package:open_words/shared/input_fields/text_edit_controller.dart';
import 'package:open_words/shared/input_fields/text_edit_field.dart';

class ExampleText extends StatefulWidget {
  const ExampleText({super.key});

  @override
  State<ExampleText> createState() => _ExampleTextState();
}

class _ExampleTextState extends State<ExampleText> {
  final TextEditController controller = TextEditController.text();

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextEditField(
        onChanged: context.read<TextToSpeechListCubit>().setExampleText,
        controller: controller,
        border: OutlineInputBorder(),
        label: 'Example text',
      ),
    );
  }
}
