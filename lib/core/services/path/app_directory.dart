import 'dart:io';

final class AppDirectory {
  final String label;
  final String path;

  const AppDirectory({required this.label, required this.path});

  AppDirectory.fromDirectory(this.label, Directory directory)
    : path = directory.path;
}
