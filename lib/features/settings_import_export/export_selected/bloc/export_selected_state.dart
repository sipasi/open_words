part of 'export_selected_bloc.dart';

class ExportSelectedState {
  final List<WordGroup> selected;
  final String fileName;
  final String fileDefaultName;

  final ExportExtension exportExtension;
  final ExportDestination exportDestination;

  final PdfExtensionProperties pdfProperties;

  const ExportSelectedState({
    required this.selected,
    required this.fileName,
    required this.fileDefaultName,
    required this.exportExtension,
    required this.exportDestination,
    required this.pdfProperties,
  });
  const ExportSelectedState.initial()
    : selected = const [],
      fileName = '',
      fileDefaultName = '',
      exportExtension = ExportExtension.pdf,
      exportDestination = ExportDestination.share,
      pdfProperties = const PdfExtensionProperties.initial();

  ExportSelectedState copyWith({
    List<WordGroup>? selected,
    String? fileName,
    String? fileDefaultName,
    ExportExtension? exportExtension,
    ExportDestination? exportDestination,
    PdfExtensionProperties? pdfProperties,
  }) {
    return ExportSelectedState(
      selected: selected ?? this.selected,
      fileName: fileName ?? this.fileName,
      fileDefaultName: fileDefaultName ?? this.fileDefaultName,
      exportExtension: exportExtension ?? this.exportExtension,
      exportDestination: exportDestination ?? this.exportDestination,
      pdfProperties: pdfProperties ?? this.pdfProperties,
    );
  }
}
