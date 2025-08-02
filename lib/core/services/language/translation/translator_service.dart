import 'package:open_words/core/services/language/translation/translator_brand.dart';
import 'package:open_words/core/services/language/translation/translator_launch_type.dart';
import 'package:open_words/core/services/language/translation/translator_template.dart';
import 'package:open_words/core/services/language/translation/translator_template_storage.dart';
import 'package:open_words/core/services/language/translation/translator_url_builder.dart';
import 'package:url_launcher/url_launcher.dart';

sealed class TranslatorService {
  const TranslatorService();

  Future launch(TranslatorTemplate option, TranslationRequest request);
}

final class TranslatorServiceImpl extends TranslatorService {
  final TranslatorTemplateStorage optionStorage;

  static const _all = {
    TranslatorBrand.google: GoogleTranslatorBuilder(),
    TranslatorBrand.deepL: DeeplTranslatorBuilder(),
    TranslatorBrand.reverso: ReversoTranslatorBuilder(),
  };

  const TranslatorServiceImpl(this.optionStorage);

  TranslatorUrlBuilder get(TranslatorBrand option) => _all[option]!;

  @override
  Future launch(TranslatorTemplate template, TranslationRequest request) {
    final uri = get(template.brand).build(request);

    return launchUrl(
      uri,
      mode: switch (template.launch) {
        TranslatorLaunchType.translatorApp => LaunchMode.externalApplication,
        TranslatorLaunchType.webView => LaunchMode.inAppWebView,
        TranslatorLaunchType.externalBrowser => LaunchMode.externalApplication,
      },
    );
  }
}
