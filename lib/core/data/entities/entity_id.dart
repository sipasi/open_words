import 'package:open_words/core/ids/id.dart';

const _emptyId = -1;

extension type const EntityId.exist(int value) implements Id<int> {
  const EntityId.empty() : value = _emptyId;
  factory EntityId.emptyIfNull(int? id) =>
      id == null ? const .empty() : .exist(id);
  factory EntityId.trowIfNull(int? id) =>
      id == null ? throw '[$EntityId] trowIfNull throw exception' : .exist(id);

  EntityId toExist(int id) => EntityId.exist(id);

  int? valueOrNull() => isEmpty ? null : value;
  int valueOrThrow() =>
      isEmpty ? throw '[$EntityId] valueOrThrow throw exception' : value;

  bool get isEmpty => value == _emptyId;
  bool get isNotEmpty => !isEmpty;
}
