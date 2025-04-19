const _emptyId = -1;

class Id {
  final int _value;

  bool get isEmpty => !isNotEmpty;
  bool get isNotEmpty => _value >= 0;

  const Id.exist(int id) : assert(id > _emptyId), _value = id;
  const Id.empty() : _value = _emptyId;
  const Id.emptyIfNull(int? id) : _value = id ?? _emptyId;

  Id toExist(int id) => Id.exist(id);

  int? valueOrNull() => isEmpty ? null : _value;
  int valueOrThrow() => isEmpty ? _throw() : _value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Id && _value == other._value;

  @override
  int get hashCode => _value.hashCode;

  @override
  String toString() => _value.toString();

  Never _throw() {
    throw '[Id Exception]: int? valueOrThrow()';
  }
}
