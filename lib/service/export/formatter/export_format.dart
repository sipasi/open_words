enum ExportFormat {
  excel('xlsx'),
  pdf('pdf'),
  json('json'),
  text('txt');

  const ExportFormat(this.extension);
  final String extension;
}