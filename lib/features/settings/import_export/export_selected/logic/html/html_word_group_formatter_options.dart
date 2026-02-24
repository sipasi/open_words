import 'package:open_words/features/settings/import_export/export_selected/logic/word_group_formatter_options.dart';

class HtmlWordGroupFormatterOptions extends WordGroupFormatterOptions {
  final bool removeSearchField;

  const HtmlWordGroupFormatterOptions({
    required this.removeSearchField,
  });

  const HtmlWordGroupFormatterOptions.empty() : removeSearchField = false;
}
