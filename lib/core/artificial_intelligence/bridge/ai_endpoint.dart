final class AiEndpoint {
  final String _value;

  const AiEndpoint._(this._value);

  String applyTo(String url) {
    return url + _value;
  }

  static const empty = AiEndpoint._('/');
  static const models = AiEndpoint._('/v1/models');
  static const chat = AiEndpoint._('/v1/chat/completions');
  static const completions = AiEndpoint._('/v1/completions');
  static const embeddings = AiEndpoint._('/v1/embeddings');
}
