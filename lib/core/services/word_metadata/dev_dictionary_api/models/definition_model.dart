class DefinitionModel {
  DefinitionModel({required this.definition, required this.example});

  final String? definition;
  final String? example;

  factory DefinitionModel.fromJson(Map<String, dynamic> json) {
    return DefinitionModel(
      definition: json["definition"],
      example: json["example"],
    );
  }

  Map<String, dynamic> toJson() => {
    "definition": definition,
    "example": example,
  };
}
