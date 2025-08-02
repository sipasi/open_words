import 'package:flutter/material.dart';
import 'package:open_words/core/services/language/translation/translator_brand.dart';
import 'package:open_words/core/services/language/translation/translator_launch_type.dart';
import 'package:open_words/core/services/language/translation/translator_template.dart';
import 'package:open_words/shared/card/radio_card.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class TranslatorTemplateView extends StatelessWidget {
  final TranslatorTemplate template;
  final void Function(TranslatorTemplate template) onChanged;

  const TranslatorTemplateView({
    super.key,
    required this.template,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      shrinkWrap: true,
      children: [
        _labledCard(
          context: context,
          label: "Brand",
          children: List.generate(
            TranslatorBrand.values.length,
            (index) {
              final brand = TranslatorBrand.values[index];

              return RadioCard.outlined(
                data: brand,
                id: brand,
                groupId: template.brand,
                title: Text(brand.name),
                onTap: (brand) => onChanged(template.copyWith(brand: brand)),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        _labledCard(
          context: context,
          label: "Launch via",
          children: List.generate(
            TranslatorBrand.values.length,
            (index) {
              final launch = TranslatorLaunchType.values[index];

              return RadioCard.outlined(
                data: launch,
                id: launch,
                groupId: template.launch,
                title: Text(_getLaunchMessage(launch)),
                onTap: (launch) => onChanged(template.copyWith(launch: launch)),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _labledCard({
    required BuildContext context,
    required String label,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        ...children,
      ],
    );
  }

  String _getLaunchMessage(TranslatorLaunchType launch) {
    return switch (launch) {
      TranslatorLaunchType.translatorApp => 'Translator app',
      TranslatorLaunchType.webView => 'In app WebView',
      TranslatorLaunchType.externalBrowser => 'External Browser',
    };
  }
}
