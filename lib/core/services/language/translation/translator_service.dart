import 'package:open_words/core/services/language/translation/translator_option.dart';
import 'package:open_words/core/services/language/translation/translator_option_storage.dart';
import 'package:open_words/core/services/language/translation/translator_url_builder.dart';
import 'package:url_launcher/url_launcher.dart';

sealed class TranslatorService {
  const TranslatorService();

  Future launch(TranslatorOption option, TranslationRequest request);
}

final class TranslatorServiceImpl extends TranslatorService {
  final TranslatorOptionStorage optionStorage;

  static const _all = {
    TranslatorOption.google: GoogleTranslatorBuilder(),
    TranslatorOption.deepL: DeeplTranslatorBuilder(),
    TranslatorOption.reverso: ReversoTranslatorBuilder(),
  };

  const TranslatorServiceImpl(this.optionStorage);

  TranslatorUrlBuilder get(TranslatorOption option) => _all[option]!;

  @override
  Future launch(TranslatorOption option, TranslationRequest request) {
    final uri = get(option).build(request);

    return launchUrl(uri, mode: LaunchMode.inAppWebView);
  }
}
