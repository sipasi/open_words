import 'dart:io';

final class AppDirectory {
  final String lable;
  final String path;

  const AppDirectory({required this.lable, required this.path});

  AppDirectory.fromDirectory(this.lable, Directory directory)
    : path = directory.path;
}
