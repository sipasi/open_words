import 'package:drift/drift.dart';
import 'package:open_words/core/data/entities/explorer/explorer_data.dart';
import 'package:open_words/core/data/repository/mappers/folder_sql_mapper.dart';
import 'package:open_words/core/data/repository/mappers/word_group_sql_mapper.dart';

sealed class ExplorerSqlMapper {
  static ExplorerData fromList(List<QueryRow> rows) {
    final explorer = ExplorerData(folders: [], groups: []);

    for (var i = 0; i < rows.length; i++) {
      final row = rows[i];
      final data = row.data;

      final type = data['entity_type'];

      if (type == 'WordGroup') {
        final group = WordGroupSqlMapper.from(row);

        explorer.groups.add(group);

        continue;
      }

      final folder = FolderSqlMapper.from(row);

      explorer.folders.add(folder);
    }

    return explorer;
  }
}
