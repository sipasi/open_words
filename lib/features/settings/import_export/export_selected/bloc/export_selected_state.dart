part of 'export_selected_bloc.dart';

class ExportSelectedState {
  final List<WordGroup> selected;
  final String fileName;

  final ExportExtension exportExtension;
  final ExportDestination exportDestination;

  final PdfExtensionProperties pdfProperties;
  final HtmlExtensionProperties htmlProperties;

  final ExportExecutingStatus executingStatus;

  String get fileNameOrDefault => fileName.isNotEmpty
      ? fileName
      : selected.length == 1
      ? selected[0].name
      : 'WordGroups';

  const ExportSelectedState({
    required this.selected,
    required this.fileName,
    required this.exportExtension,
    required this.exportDestination,
    required this.pdfProperties,
    required this.htmlProperties,
    required this.executingStatus,
  });
  const ExportSelectedState.initial()
    : selected = const [],
      fileName = '',
      exportExtension = ExportExtension.json,
      exportDestination = ExportDestination.share,
      pdfProperties = const PdfExtensionProperties.initial(),
      htmlProperties = const HtmlExtensionProperties.initial(),
      executingStatus = ExportExecutingStatus.notStarted;

  ExportSelectedState copyWith({
    List<WordGroup>? selected,
    String? fileName,
    ExportExtension? exportExtension,
    ExportDestination? exportDestination,
    PdfExtensionProperties? pdfProperties,
    HtmlExtensionProperties? htmlProperties,
    ExportExecutingStatus? executingStatus,
  }) {
    return ExportSelectedState(
      selected: selected ?? this.selected,
      fileName: fileName ?? this.fileName,
      exportExtension: exportExtension ?? this.exportExtension,
      exportDestination: exportDestination ?? this.exportDestination,
      pdfProperties: pdfProperties ?? this.pdfProperties,
      htmlProperties: htmlProperties ?? this.htmlProperties,
      executingStatus: executingStatus ?? this.executingStatus,
    );
  }
}
