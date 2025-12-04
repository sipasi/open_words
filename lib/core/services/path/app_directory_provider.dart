import 'package:open_words/core/services/path/app_directory.dart';

final class AppDirectoryProvider {
  final AppDirectory temporary;
  final AppDirectory support;
  final AppDirectory documents;
  final AppDirectory cache;

  final AppDirectory? downloads;

  final List<AppDirectory> all;

  final bool isSupported;

  AppDirectory get downloadsOrDocuments => downloads ?? documents;

  AppDirectoryProvider({
    required this.temporary,
    required this.support,
    required this.documents,
    required this.cache,
    required this.downloads,
  }) : isSupported = true,
       all = List.unmodifiable([
         temporary,
         support,
         documents,
         cache,
         downloads,
       ]);

  const AppDirectoryProvider.notSupported()
    : isSupported = false,
      temporary = const .empty(),
      support = const .empty(),
      documents = const .empty(),
      cache = const .empty(),
      downloads = const .empty(),
      all = const [];
}
