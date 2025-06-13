import 'package:open_words/core/data/entities/language_info.dart';

final class TranslationRequest {
  final LanguageInfo source;
  final LanguageInfo target;
  final String word;

  const TranslationRequest({
    required this.source,
    required this.target,
    required this.word,
  });
}

sealed class TranslatorUrlBuilder {
  const TranslatorUrlBuilder();

  Uri build(TranslationRequest request);

  (String sourceCode, String targetCode, String word) deconstruct(
    TranslationRequest request,
  ) {
    return (request.source.code, request.target.code, request.word);
  }
}

final class GoogleTranslatorBuilder extends TranslatorUrlBuilder {
  const GoogleTranslatorBuilder();

  @override
  Uri build(TranslationRequest request) {
    final (source, target, word) = deconstruct(request);

    // https://translate.google.com.ua/?sl=en&tl=uk&text=best%0A&op=translate
    final address = Uri.https('translate.google.com', '/', {
      'sl': source,
      'tl': target,
      'text': word,
      'op': 'translate',
    });

    return address;
  }
}

final class DeeplTranslatorBuilder extends TranslatorUrlBuilder {
  const DeeplTranslatorBuilder();

  @override
  Uri build(TranslationRequest request) {
    final (source, target, word) = deconstruct(request);

    // https://www.deepl.com/en/translator#en/uk/best
    final address = Uri(
      scheme: 'https',
      host: 'www.deepl.com',
      path: '$source/translator',
      fragment: '$source/$target/$word',
    );

    return address;
  }
}

final class ReversoTranslatorBuilder extends TranslatorUrlBuilder {
  const ReversoTranslatorBuilder();

  @override
  Uri build(TranslationRequest request) {
    final (source, target, word) = deconstruct(request);

    // https://www.reverso.net/text-translation#sl=en&tl=uk&text=best
    final address = Uri.parse(
      'https://www.reverso.net/text-translation#sl=$source&tl=$target&text=$word',
    );

    return address;
  }
}
