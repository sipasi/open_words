part of 'export_selected_bloc.dart';

class ExportSelectedState {
  final List<WordGroup> selected;
  final String fileName;

  final ExportExtension exportExtension;
  final ExportDestination exportDestination;

  final PdfExtensionProperties pdfProperties;

  final ExportExecutingStatus executingStatus;

  String get fileNameOrDefault => fileName.isNotEmpty ? fileName : 'WordGroups';

  const ExportSelectedState({
    required this.selected,
    required this.fileName,
    required this.exportExtension,
    required this.exportDestination,
    required this.pdfProperties,
    required this.executingStatus,
  });
  const ExportSelectedState.initial()
    : selected = const [],
      fileName = '',
      exportExtension = ExportExtension.json,
      exportDestination = ExportDestination.share,
      pdfProperties = const PdfExtensionProperties.initial(),
      executingStatus = ExportExecutingStatus.notStarted;

  ExportSelectedState copyWith({
    List<WordGroup>? selected,
    String? fileName,
    ExportExtension? exportExtension,
    ExportDestination? exportDestination,
    PdfExtensionProperties? pdfProperties,
    ExportExecutingStatus? executingStatus,
  }) {
    return ExportSelectedState(
      selected: selected ?? this.selected,
      fileName: fileName ?? this.fileName,
      exportExtension: exportExtension ?? this.exportExtension,
      exportDestination: exportDestination ?? this.exportDestination,
      pdfProperties: pdfProperties ?? this.pdfProperties,
      executingStatus: executingStatus ?? this.executingStatus,
    );
  }
}
