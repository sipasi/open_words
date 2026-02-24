import 'package:open_words/features/settings/import_export/export_selected/bloc/export_selected_bloc.dart';
import 'package:open_words/features/settings/import_export/export_selected/logic/html/html_word_group_formatter_options.dart';
import 'package:open_words/features/settings/import_export/export_selected/logic/word_group_formatter_options.dart';

sealed class PropertiesToOptionsUseCase {
  static WordGroupFormatterOptions invoke(ExportSelectedState state) {
    return switch (state.exportExtension) {
      .html => HtmlWordGroupFormatterOptions(
        removeSearchField: state.htmlProperties.removeSearchField,
      ),
      _ => .empty(),
    };
  }
}
