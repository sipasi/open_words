enum ExportExtension {
  pdf('Pdf', '.pdf'),
  json('Json', '.json'),
  text('Text', '.txt');

  final String name;
  final String extension;
  const ExportExtension(this.name, this.extension);
}
