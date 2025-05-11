import 'package:open_words/core/services/path/app_directory.dart';

final class AppDirectoryProvider {
  final AppDirectory temporary;
  final AppDirectory support;
  final AppDirectory documents;
  final AppDirectory cache;

  final AppDirectory? downloads;

  final List<AppDirectory> all;

  AppDirectory get downloadsOrDocuments => downloads ?? documents;

  AppDirectoryProvider({
    required this.temporary,
    required this.support,
    required this.documents,
    required this.cache,
    required this.downloads,
  }) : all = List.unmodifiable([
         temporary,
         support,
         documents,
         cache,
         downloads,
       ]);
}
