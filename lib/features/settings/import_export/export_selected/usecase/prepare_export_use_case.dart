import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/core/data/repository/word_metadata_repository.dart';
import 'package:open_words/core/data/repository/word_repository.dart';
import 'package:open_words/features/settings/import_export/models/word_export.dart';
import 'package:open_words/features/settings/import_export/models/word_group_export.dart';

sealed class PrepareExportUseCase {
  static Future<List<WordGroupExport>> invoke({
    required List<WordGroup> selected,
    required WordRepository wordRepository,
    required WordMetadataRepository metadataRepository,
  }) {
    return List.generate(selected.length, (index) async {
      final item = selected[index];

      final words = await wordRepository.allByGroup(item.id);
      final metadatas = await metadataRepository.mapOf(
        words.map((e) => e.origin).toList(),
      );

      return WordGroupExport.from(
        item,
        words
            .map(
              (e) => WordExport.from(
                e,
                metadatas[e.origin] ?? const .empty(),
              ),
            )
            .toList(),
      );
    }).wait;
  }
}
