import 'package:open_words/shared/theme/color_seed.dart';

class HtmlExtensionProperties {
  final bool removeSearchField;
  final ColorSeed colorScheme;

  const HtmlExtensionProperties({
    required this.removeSearchField,
    required this.colorScheme,
  });
  const HtmlExtensionProperties.initial()
    : removeSearchField = false,
      colorScheme = ColorSeed.green;

  HtmlExtensionProperties copyWith({
    bool? removeSearchField,
    ColorSeed? colorScheme,
  }) {
    return HtmlExtensionProperties(
      removeSearchField: removeSearchField ?? this.removeSearchField,
      colorScheme: colorScheme ?? this.colorScheme,
    );
  }
}
