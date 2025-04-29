part of 'theme_extension.dart';

extension TileStyleExtension on BuildContext {
  TextStyle? title({FontWeight? fontWeight, Color? color}) {
    return textTheme.bodyLarge?.copyWith(
      color: color ?? colorScheme.secondary,
      fontWeight: fontWeight,
    );
  }

  TextStyle? subtitle() {
    return textTheme.bodyMedium?.copyWith(color: _subtitleColor());
  }

  Color? _subtitleColor() {
    return theme.brightness == Brightness.dark
        ? Colors.grey[400]
        : Colors.grey[600];
  }
}
