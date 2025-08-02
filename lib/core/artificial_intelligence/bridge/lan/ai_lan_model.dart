enum AiLanModel {
  gemma3("gemma3"),
  gemma3_1b("gemma3:1b"),
  // ignore: constant_identifier_names
  mistral_7b_instruct("mistral:7b-instruct"),
  cogito("cogito");

  final String name;
  const AiLanModel(this.name);
}
