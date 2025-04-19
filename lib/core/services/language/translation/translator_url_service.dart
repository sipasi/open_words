import 'package:open_words/core/services/language/translation/translator_option.dart';
import 'package:open_words/core/services/language/translation/translator_option_storage.dart';
import 'package:open_words/core/services/language/translation/translator_url_builder.dart';

sealed class TranslatorUrlService {
  const TranslatorUrlService();

  TranslatorUrlBuilder get(TranslatorOption option);
  TranslatorUrlBuilder getRememberedOrDefault();
}

final class TranslatorUrlServiceImpl extends TranslatorUrlService {
  final TranslatorOptionStorage optionStorage;

  static const _all = {
    TranslatorOption.google: GoogleTranslatorBuilder(),
    TranslatorOption.deepL: DeeplTranslatorBuilder(),
    TranslatorOption.reverso: ReversoTranslatorBuilder(),
  };

  const TranslatorUrlServiceImpl(this.optionStorage);

  @override
  TranslatorUrlBuilder get(TranslatorOption option) => _all[option]!;

  @override
  TranslatorUrlBuilder getRememberedOrDefault() {
    final remembered = optionStorage.rememberedOrDefault();

    return get(remembered);
  }
}

extension TranslatorUrlServiceExtension on TranslatorUrlService {
  Uri build(TranslationRequest request) {
    final remembered = getRememberedOrDefault();

    return remembered.build(request);
  }
}
