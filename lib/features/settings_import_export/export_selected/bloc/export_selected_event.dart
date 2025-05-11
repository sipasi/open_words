part of 'export_selected_bloc.dart';

sealed class ExportSelectedEvent {}

final class ExportSelectedStarded extends ExportSelectedEvent {
  final List<WordGroup> selected;

  ExportSelectedStarded(this.selected);
}

final class ExportSelectedDestinationChanged extends ExportSelectedEvent {
  final ExportDestination value;

  ExportSelectedDestinationChanged(this.value);
}

final class ExportSelectedExtensionChanged extends ExportSelectedEvent {
  final ExportExtension value;

  ExportSelectedExtensionChanged(this.value);
}

final class ExportSelectedPdfChanged extends ExportSelectedEvent {
  final bool? printing;
  final bool? darkBackground;
  final ColorSeed? colorScheme;

  ExportSelectedPdfChanged({
    this.printing,
    this.darkBackground,
    this.colorScheme,
  });
}

final class ExportSelectedShareRequested extends ExportSelectedEvent {}

final class ExportSelectedDownloadRequested extends ExportSelectedEvent {}
