import 'package:open_words/core/data/entities/metadata/definition.dart';

class DefinitionDraft {
  final String value;
  final String example;

  DefinitionDraft({required this.value, required this.example});
  DefinitionDraft.fromDefinition(Definition definition)
    : value = definition.value,
      example = definition.example;
}
