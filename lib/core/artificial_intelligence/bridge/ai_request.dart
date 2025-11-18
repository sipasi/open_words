// ignore_for_file: public_member_api_docs, sort_constructors_first

class AiRequest {
  final AiRequestContent content;
  final double temperature;
  final int maxTokens;
  final bool stream;

  AiRequest({
    required this.content,
    required this.temperature,
    required this.maxTokens,
    this.stream = false,
  });
  AiRequest.chatCompletions({
    required List<AiRequestMessage> messages,
    required this.temperature,
    required this.maxTokens,
    this.stream = false,
  }) : content = ChatCompletionsContent(messages);

  Map<String, dynamic> toMap() {
    return {
      ...content.toMap(),
      'temperature': temperature,
      'max_tokens': maxTokens,
    };
  }

  AiRequest copyWith({
    AiRequestContent? content,
    double? temperature,
    int? maxTokens,
    bool? stream,
  }) {
    return AiRequest(
      content: content ?? this.content,
      temperature: temperature ?? this.temperature,
      maxTokens: maxTokens ?? this.maxTokens,
      stream: stream ?? this.stream,
    );
  }
}

abstract class AiRequestContent {
  Map<String, dynamic> toMap();
}

class ChatCompletionsContent extends AiRequestContent {
  final List<AiRequestMessage> messages;

  ChatCompletionsContent(this.messages);

  @override
  Map<String, dynamic> toMap() {
    return {
      "messages": messages.map((e) => e.toMap()).toList(),
    };
  }
}

class AiRequestMessage {
  final String role;
  final String content;

  const AiRequestMessage({required this.role, required this.content});

  const AiRequestMessage.system(this.content) : role = "system";
  const AiRequestMessage.user(this.content) : role = "user";

  Map<String, String> toMap() {
    return {
      "role": role,
      "content": content,
    };
  }
}
