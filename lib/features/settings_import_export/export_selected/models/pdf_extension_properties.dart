import 'package:open_words/shared/theme/color_seed.dart';

class PdfExtensionProperties {
  final bool printing;
  final bool darkBackground;
  final ColorSeed colorScheme;

  const PdfExtensionProperties({
    required this.printing,
    required this.darkBackground,
    required this.colorScheme,
  });
  const PdfExtensionProperties.initial()
    : printing = false,
      darkBackground = true,
      colorScheme = ColorSeed.baseColor;

  PdfExtensionProperties copyWith({
    bool? printing,
    bool? darkBackground,
    ColorSeed? colorScheme,
  }) {
    return PdfExtensionProperties(
      printing: printing ?? this.printing,
      darkBackground: darkBackground ?? this.darkBackground,
      colorScheme: colorScheme ?? this.colorScheme,
    );
  }
}
