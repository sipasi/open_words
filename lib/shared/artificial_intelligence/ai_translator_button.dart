import 'package:flutter/material.dart';
import 'package:open_words/core/artificial_intelligence/ai_translator.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class AiTranslatorButton extends StatefulWidget {
  final AiTranslator translator;

  final String Function() text;
  final void Function(String response) onSuccess;

  const AiTranslatorButton({
    super.key,
    required this.translator,
    required this.text,
    required this.onSuccess,
  });

  @override
  State<AiTranslatorButton> createState() => _AiTranslatorButtonState();
}

class _AiTranslatorButtonState extends State<AiTranslatorButton> {
  bool _executing = false;

  @override
  Widget build(BuildContext context) {
    if (_executing) {
      return FilledButton.tonalIcon(
        onPressed: () {},
        icon: Icon(Icons.psychology),
        label: SizedBox(
          height: 12,
          child: CircularProgressIndicator(color: context.colorScheme.primary),
        ),
      );
    }

    return FilledButton.tonalIcon(
      onPressed: _onSendFuture,
      label: Text('With AI'),
      icon: Icon(Icons.psychology_outlined),
    );
  }

  Future _onSendFuture() async {
    final text = widget.text();

    if (text.isEmpty) {
      return;
    }

    setState(() => _executing = true);

    final response = await widget.translator.translate(text);

    setState(() => _executing = false);

    if (response.isNotEmpty) {
      widget.onSuccess(response);
    }
  }
}
