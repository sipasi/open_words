import 'package:open_words/core/data/entities/language_info.dart';

final class TranslationRequest {
  final String source;
  final String target;
  final String word;

  const TranslationRequest({
    required this.source,
    required this.target,
    required this.word,
  });
  TranslationRequest.languageInfo({
    required LanguageInfo source,
    required LanguageInfo target,
    required this.word,
  }) : source = source.code,
       target = target.code;
}

sealed class TranslatorUrlBuilder {
  const TranslatorUrlBuilder();

  Uri build(TranslationRequest request);
}

final class GoogleTranslatorBuilder extends TranslatorUrlBuilder {
  const GoogleTranslatorBuilder();

  @override
  Uri build(TranslationRequest request) {
    // https://translate.google.com.ua/?sl=en&tl=uk&text=best%0A&op=translate
    final address = Uri.https('translate.google.com', '/', {
      'sl': request.source,
      'tl': request.target,
      'text': request.word,
      'op': 'translate',
    });

    return address;
  }
}

final class DeeplTranslatorBuilder extends TranslatorUrlBuilder {
  const DeeplTranslatorBuilder();

  @override
  Uri build(TranslationRequest request) {
    final (source, target, word) = (
      request.source,
      request.target,
      request.word,
    );

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
    final (source, target, word) = (
      request.source,
      request.target,
      request.word,
    );

    // https://www.reverso.net/text-translation#sl=en&tl=uk&text=best
    final address =
        'https://www.reverso.net/text-translation#sl=$source&tl=$target&text=$word';

    return Uri.parse(address);
  }
}
