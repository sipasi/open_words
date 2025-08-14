// ignore_for_file: public_member_api_docs, sort_constructors_first

class AiRequest {
  final String message;
  final double temperature;
  final int maxTokens;

  AiRequest({
    required this.message,
    required this.temperature,
    required this.maxTokens,
  });

  AiRequest copyWith({
    String? message,
    double? temperature,
    int? maxTokens,
  }) {
    return AiRequest(
      message: message ?? this.message,
      temperature: temperature ?? this.temperature,
      maxTokens: maxTokens ?? this.maxTokens,
    );
  }
}
