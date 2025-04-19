// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_drift_database.dart';

// ignore_for_file: type=lint
class $FoldersTable extends Folders with TableInfo<$FoldersTable, DriftFolder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoldersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _parentIdMeta = const VerificationMeta(
    'parentId',
  );
  @override
  late final GeneratedColumn<int> parentId = GeneratedColumn<int>(
    'parent_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES folders (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _createdMeta = const VerificationMeta(
    'created',
  );
  @override
  late final GeneratedColumn<DateTime> created = GeneratedColumn<DateTime>(
    'created',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, parentId, created, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'folders';
  @override
  VerificationContext validateIntegrity(
    Insertable<DriftFolder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    }
    if (data.containsKey('created')) {
      context.handle(
        _createdMeta,
        created.isAcceptableOrUnknown(data['created']!, _createdMeta),
      );
    } else if (isInserting) {
      context.missing(_createdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftFolder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftFolder(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}parent_id'],
      ),
      created:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
    );
  }

  @override
  $FoldersTable createAlias(String alias) {
    return $FoldersTable(attachedDatabase, alias);
  }
}

class DriftFolder extends DataClass implements Insertable<DriftFolder> {
  final int id;
  final int? parentId;
  final DateTime created;
  final String name;
  const DriftFolder({
    required this.id,
    this.parentId,
    required this.created,
    required this.name,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<int>(parentId);
    }
    map['created'] = Variable<DateTime>(created);
    map['name'] = Variable<String>(name);
    return map;
  }

  FoldersCompanion toCompanion(bool nullToAbsent) {
    return FoldersCompanion(
      id: Value(id),
      parentId:
          parentId == null && nullToAbsent
              ? const Value.absent()
              : Value(parentId),
      created: Value(created),
      name: Value(name),
    );
  }

  factory DriftFolder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftFolder(
      id: serializer.fromJson<int>(json['id']),
      parentId: serializer.fromJson<int?>(json['parentId']),
      created: serializer.fromJson<DateTime>(json['created']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'parentId': serializer.toJson<int?>(parentId),
      'created': serializer.toJson<DateTime>(created),
      'name': serializer.toJson<String>(name),
    };
  }

  DriftFolder copyWith({
    int? id,
    Value<int?> parentId = const Value.absent(),
    DateTime? created,
    String? name,
  }) => DriftFolder(
    id: id ?? this.id,
    parentId: parentId.present ? parentId.value : this.parentId,
    created: created ?? this.created,
    name: name ?? this.name,
  );
  DriftFolder copyWithCompanion(FoldersCompanion data) {
    return DriftFolder(
      id: data.id.present ? data.id.value : this.id,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      created: data.created.present ? data.created.value : this.created,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftFolder(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('created: $created, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, parentId, created, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftFolder &&
          other.id == this.id &&
          other.parentId == this.parentId &&
          other.created == this.created &&
          other.name == this.name);
}

class FoldersCompanion extends UpdateCompanion<DriftFolder> {
  final Value<int> id;
  final Value<int?> parentId;
  final Value<DateTime> created;
  final Value<String> name;
  const FoldersCompanion({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    this.created = const Value.absent(),
    this.name = const Value.absent(),
  });
  FoldersCompanion.insert({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    required DateTime created,
    required String name,
  }) : created = Value(created),
       name = Value(name);
  static Insertable<DriftFolder> custom({
    Expression<int>? id,
    Expression<int>? parentId,
    Expression<DateTime>? created,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (parentId != null) 'parent_id': parentId,
      if (created != null) 'created': created,
      if (name != null) 'name': name,
    });
  }

  FoldersCompanion copyWith({
    Value<int>? id,
    Value<int?>? parentId,
    Value<DateTime>? created,
    Value<String>? name,
  }) {
    return FoldersCompanion(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      created: created ?? this.created,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<int>(parentId.value);
    }
    if (created.present) {
      map['created'] = Variable<DateTime>(created.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoldersCompanion(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('created: $created, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $WordGroupsTable extends WordGroups
    with TableInfo<$WordGroupsTable, DriftWordGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordGroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _folderIdMeta = const VerificationMeta(
    'folderId',
  );
  @override
  late final GeneratedColumn<int> folderId = GeneratedColumn<int>(
    'folder_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES folders (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _createdMeta = const VerificationMeta(
    'created',
  );
  @override
  late final GeneratedColumn<DateTime> created = GeneratedColumn<DateTime>(
    'created',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modifiedMeta = const VerificationMeta(
    'modified',
  );
  @override
  late final GeneratedColumn<DateTime> modified = GeneratedColumn<DateTime>(
    'modified',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<LanguageInfo, String> origin =
      GeneratedColumn<String>(
        'origin',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<LanguageInfo>($WordGroupsTable.$converterorigin);
  @override
  late final GeneratedColumnWithTypeConverter<LanguageInfo, String>
  translation = GeneratedColumn<String>(
    'translation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<LanguageInfo>($WordGroupsTable.$convertertranslation);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    folderId,
    created,
    modified,
    name,
    origin,
    translation,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<DriftWordGroup> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('folder_id')) {
      context.handle(
        _folderIdMeta,
        folderId.isAcceptableOrUnknown(data['folder_id']!, _folderIdMeta),
      );
    }
    if (data.containsKey('created')) {
      context.handle(
        _createdMeta,
        created.isAcceptableOrUnknown(data['created']!, _createdMeta),
      );
    } else if (isInserting) {
      context.missing(_createdMeta);
    }
    if (data.containsKey('modified')) {
      context.handle(
        _modifiedMeta,
        modified.isAcceptableOrUnknown(data['modified']!, _modifiedMeta),
      );
    } else if (isInserting) {
      context.missing(_modifiedMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftWordGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftWordGroup(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      folderId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}folder_id'],
      ),
      created:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created'],
          )!,
      modified:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}modified'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      origin: $WordGroupsTable.$converterorigin.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}origin'],
        )!,
      ),
      translation: $WordGroupsTable.$convertertranslation.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}translation'],
        )!,
      ),
    );
  }

  @override
  $WordGroupsTable createAlias(String alias) {
    return $WordGroupsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<LanguageInfo, String, Map<String, Object?>>
  $converterorigin = const LanguageInfoConverter();
  static JsonTypeConverter2<LanguageInfo, String, Map<String, Object?>>
  $convertertranslation = const LanguageInfoConverter();
}

class DriftWordGroup extends DataClass implements Insertable<DriftWordGroup> {
  final int id;
  final int? folderId;
  final DateTime created;
  final DateTime modified;
  final String name;
  final LanguageInfo origin;
  final LanguageInfo translation;
  const DriftWordGroup({
    required this.id,
    this.folderId,
    required this.created,
    required this.modified,
    required this.name,
    required this.origin,
    required this.translation,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || folderId != null) {
      map['folder_id'] = Variable<int>(folderId);
    }
    map['created'] = Variable<DateTime>(created);
    map['modified'] = Variable<DateTime>(modified);
    map['name'] = Variable<String>(name);
    {
      map['origin'] = Variable<String>(
        $WordGroupsTable.$converterorigin.toSql(origin),
      );
    }
    {
      map['translation'] = Variable<String>(
        $WordGroupsTable.$convertertranslation.toSql(translation),
      );
    }
    return map;
  }

  WordGroupsCompanion toCompanion(bool nullToAbsent) {
    return WordGroupsCompanion(
      id: Value(id),
      folderId:
          folderId == null && nullToAbsent
              ? const Value.absent()
              : Value(folderId),
      created: Value(created),
      modified: Value(modified),
      name: Value(name),
      origin: Value(origin),
      translation: Value(translation),
    );
  }

  factory DriftWordGroup.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftWordGroup(
      id: serializer.fromJson<int>(json['id']),
      folderId: serializer.fromJson<int?>(json['folderId']),
      created: serializer.fromJson<DateTime>(json['created']),
      modified: serializer.fromJson<DateTime>(json['modified']),
      name: serializer.fromJson<String>(json['name']),
      origin: $WordGroupsTable.$converterorigin.fromJson(
        serializer.fromJson<Map<String, Object?>>(json['origin']),
      ),
      translation: $WordGroupsTable.$convertertranslation.fromJson(
        serializer.fromJson<Map<String, Object?>>(json['translation']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'folderId': serializer.toJson<int?>(folderId),
      'created': serializer.toJson<DateTime>(created),
      'modified': serializer.toJson<DateTime>(modified),
      'name': serializer.toJson<String>(name),
      'origin': serializer.toJson<Map<String, Object?>>(
        $WordGroupsTable.$converterorigin.toJson(origin),
      ),
      'translation': serializer.toJson<Map<String, Object?>>(
        $WordGroupsTable.$convertertranslation.toJson(translation),
      ),
    };
  }

  DriftWordGroup copyWith({
    int? id,
    Value<int?> folderId = const Value.absent(),
    DateTime? created,
    DateTime? modified,
    String? name,
    LanguageInfo? origin,
    LanguageInfo? translation,
  }) => DriftWordGroup(
    id: id ?? this.id,
    folderId: folderId.present ? folderId.value : this.folderId,
    created: created ?? this.created,
    modified: modified ?? this.modified,
    name: name ?? this.name,
    origin: origin ?? this.origin,
    translation: translation ?? this.translation,
  );
  DriftWordGroup copyWithCompanion(WordGroupsCompanion data) {
    return DriftWordGroup(
      id: data.id.present ? data.id.value : this.id,
      folderId: data.folderId.present ? data.folderId.value : this.folderId,
      created: data.created.present ? data.created.value : this.created,
      modified: data.modified.present ? data.modified.value : this.modified,
      name: data.name.present ? data.name.value : this.name,
      origin: data.origin.present ? data.origin.value : this.origin,
      translation:
          data.translation.present ? data.translation.value : this.translation,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftWordGroup(')
          ..write('id: $id, ')
          ..write('folderId: $folderId, ')
          ..write('created: $created, ')
          ..write('modified: $modified, ')
          ..write('name: $name, ')
          ..write('origin: $origin, ')
          ..write('translation: $translation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, folderId, created, modified, name, origin, translation);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftWordGroup &&
          other.id == this.id &&
          other.folderId == this.folderId &&
          other.created == this.created &&
          other.modified == this.modified &&
          other.name == this.name &&
          other.origin == this.origin &&
          other.translation == this.translation);
}

class WordGroupsCompanion extends UpdateCompanion<DriftWordGroup> {
  final Value<int> id;
  final Value<int?> folderId;
  final Value<DateTime> created;
  final Value<DateTime> modified;
  final Value<String> name;
  final Value<LanguageInfo> origin;
  final Value<LanguageInfo> translation;
  const WordGroupsCompanion({
    this.id = const Value.absent(),
    this.folderId = const Value.absent(),
    this.created = const Value.absent(),
    this.modified = const Value.absent(),
    this.name = const Value.absent(),
    this.origin = const Value.absent(),
    this.translation = const Value.absent(),
  });
  WordGroupsCompanion.insert({
    this.id = const Value.absent(),
    this.folderId = const Value.absent(),
    required DateTime created,
    required DateTime modified,
    required String name,
    required LanguageInfo origin,
    required LanguageInfo translation,
  }) : created = Value(created),
       modified = Value(modified),
       name = Value(name),
       origin = Value(origin),
       translation = Value(translation);
  static Insertable<DriftWordGroup> custom({
    Expression<int>? id,
    Expression<int>? folderId,
    Expression<DateTime>? created,
    Expression<DateTime>? modified,
    Expression<String>? name,
    Expression<String>? origin,
    Expression<String>? translation,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (folderId != null) 'folder_id': folderId,
      if (created != null) 'created': created,
      if (modified != null) 'modified': modified,
      if (name != null) 'name': name,
      if (origin != null) 'origin': origin,
      if (translation != null) 'translation': translation,
    });
  }

  WordGroupsCompanion copyWith({
    Value<int>? id,
    Value<int?>? folderId,
    Value<DateTime>? created,
    Value<DateTime>? modified,
    Value<String>? name,
    Value<LanguageInfo>? origin,
    Value<LanguageInfo>? translation,
  }) {
    return WordGroupsCompanion(
      id: id ?? this.id,
      folderId: folderId ?? this.folderId,
      created: created ?? this.created,
      modified: modified ?? this.modified,
      name: name ?? this.name,
      origin: origin ?? this.origin,
      translation: translation ?? this.translation,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (folderId.present) {
      map['folder_id'] = Variable<int>(folderId.value);
    }
    if (created.present) {
      map['created'] = Variable<DateTime>(created.value);
    }
    if (modified.present) {
      map['modified'] = Variable<DateTime>(modified.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (origin.present) {
      map['origin'] = Variable<String>(
        $WordGroupsTable.$converterorigin.toSql(origin.value),
      );
    }
    if (translation.present) {
      map['translation'] = Variable<String>(
        $WordGroupsTable.$convertertranslation.toSql(translation.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordGroupsCompanion(')
          ..write('id: $id, ')
          ..write('folderId: $folderId, ')
          ..write('created: $created, ')
          ..write('modified: $modified, ')
          ..write('name: $name, ')
          ..write('origin: $origin, ')
          ..write('translation: $translation')
          ..write(')'))
        .toString();
  }
}

class $WordsTable extends Words with TableInfo<$WordsTable, DriftWord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<int> groupId = GeneratedColumn<int>(
    'group_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES word_groups (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _createdMeta = const VerificationMeta(
    'created',
  );
  @override
  late final GeneratedColumn<DateTime> created = GeneratedColumn<DateTime>(
    'created',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originMeta = const VerificationMeta('origin');
  @override
  late final GeneratedColumn<String> origin = GeneratedColumn<String>(
    'origin',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _translationMeta = const VerificationMeta(
    'translation',
  );
  @override
  late final GeneratedColumn<String> translation = GeneratedColumn<String>(
    'translation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    groupId,
    created,
    origin,
    translation,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'words';
  @override
  VerificationContext validateIntegrity(
    Insertable<DriftWord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('created')) {
      context.handle(
        _createdMeta,
        created.isAcceptableOrUnknown(data['created']!, _createdMeta),
      );
    } else if (isInserting) {
      context.missing(_createdMeta);
    }
    if (data.containsKey('origin')) {
      context.handle(
        _originMeta,
        origin.isAcceptableOrUnknown(data['origin']!, _originMeta),
      );
    } else if (isInserting) {
      context.missing(_originMeta);
    }
    if (data.containsKey('translation')) {
      context.handle(
        _translationMeta,
        translation.isAcceptableOrUnknown(
          data['translation']!,
          _translationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_translationMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftWord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftWord(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      groupId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}group_id'],
          )!,
      created:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created'],
          )!,
      origin:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}origin'],
          )!,
      translation:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}translation'],
          )!,
    );
  }

  @override
  $WordsTable createAlias(String alias) {
    return $WordsTable(attachedDatabase, alias);
  }
}

class DriftWord extends DataClass implements Insertable<DriftWord> {
  final int id;
  final int groupId;
  final DateTime created;
  final String origin;
  final String translation;
  const DriftWord({
    required this.id,
    required this.groupId,
    required this.created,
    required this.origin,
    required this.translation,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['group_id'] = Variable<int>(groupId);
    map['created'] = Variable<DateTime>(created);
    map['origin'] = Variable<String>(origin);
    map['translation'] = Variable<String>(translation);
    return map;
  }

  WordsCompanion toCompanion(bool nullToAbsent) {
    return WordsCompanion(
      id: Value(id),
      groupId: Value(groupId),
      created: Value(created),
      origin: Value(origin),
      translation: Value(translation),
    );
  }

  factory DriftWord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftWord(
      id: serializer.fromJson<int>(json['id']),
      groupId: serializer.fromJson<int>(json['groupId']),
      created: serializer.fromJson<DateTime>(json['created']),
      origin: serializer.fromJson<String>(json['origin']),
      translation: serializer.fromJson<String>(json['translation']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'groupId': serializer.toJson<int>(groupId),
      'created': serializer.toJson<DateTime>(created),
      'origin': serializer.toJson<String>(origin),
      'translation': serializer.toJson<String>(translation),
    };
  }

  DriftWord copyWith({
    int? id,
    int? groupId,
    DateTime? created,
    String? origin,
    String? translation,
  }) => DriftWord(
    id: id ?? this.id,
    groupId: groupId ?? this.groupId,
    created: created ?? this.created,
    origin: origin ?? this.origin,
    translation: translation ?? this.translation,
  );
  DriftWord copyWithCompanion(WordsCompanion data) {
    return DriftWord(
      id: data.id.present ? data.id.value : this.id,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      created: data.created.present ? data.created.value : this.created,
      origin: data.origin.present ? data.origin.value : this.origin,
      translation:
          data.translation.present ? data.translation.value : this.translation,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftWord(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('created: $created, ')
          ..write('origin: $origin, ')
          ..write('translation: $translation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, groupId, created, origin, translation);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftWord &&
          other.id == this.id &&
          other.groupId == this.groupId &&
          other.created == this.created &&
          other.origin == this.origin &&
          other.translation == this.translation);
}

class WordsCompanion extends UpdateCompanion<DriftWord> {
  final Value<int> id;
  final Value<int> groupId;
  final Value<DateTime> created;
  final Value<String> origin;
  final Value<String> translation;
  const WordsCompanion({
    this.id = const Value.absent(),
    this.groupId = const Value.absent(),
    this.created = const Value.absent(),
    this.origin = const Value.absent(),
    this.translation = const Value.absent(),
  });
  WordsCompanion.insert({
    this.id = const Value.absent(),
    required int groupId,
    required DateTime created,
    required String origin,
    required String translation,
  }) : groupId = Value(groupId),
       created = Value(created),
       origin = Value(origin),
       translation = Value(translation);
  static Insertable<DriftWord> custom({
    Expression<int>? id,
    Expression<int>? groupId,
    Expression<DateTime>? created,
    Expression<String>? origin,
    Expression<String>? translation,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupId != null) 'group_id': groupId,
      if (created != null) 'created': created,
      if (origin != null) 'origin': origin,
      if (translation != null) 'translation': translation,
    });
  }

  WordsCompanion copyWith({
    Value<int>? id,
    Value<int>? groupId,
    Value<DateTime>? created,
    Value<String>? origin,
    Value<String>? translation,
  }) {
    return WordsCompanion(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      created: created ?? this.created,
      origin: origin ?? this.origin,
      translation: translation ?? this.translation,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    if (created.present) {
      map['created'] = Variable<DateTime>(created.value);
    }
    if (origin.present) {
      map['origin'] = Variable<String>(origin.value);
    }
    if (translation.present) {
      map['translation'] = Variable<String>(translation.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordsCompanion(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('created: $created, ')
          ..write('origin: $origin, ')
          ..write('translation: $translation')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDriftDatabase extends GeneratedDatabase {
  _$AppDriftDatabase(QueryExecutor e) : super(e);
  $AppDriftDatabaseManager get managers => $AppDriftDatabaseManager(this);
  late final $FoldersTable folders = $FoldersTable(this);
  late final $WordGroupsTable wordGroups = $WordGroupsTable(this);
  late final $WordsTable words = $WordsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    folders,
    wordGroups,
    words,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'folders',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('folders', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'folders',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('word_groups', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'word_groups',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('words', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$FoldersTableCreateCompanionBuilder =
    FoldersCompanion Function({
      Value<int> id,
      Value<int?> parentId,
      required DateTime created,
      required String name,
    });
typedef $$FoldersTableUpdateCompanionBuilder =
    FoldersCompanion Function({
      Value<int> id,
      Value<int?> parentId,
      Value<DateTime> created,
      Value<String> name,
    });

final class $$FoldersTableReferences
    extends BaseReferences<_$AppDriftDatabase, $FoldersTable, DriftFolder> {
  $$FoldersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FoldersTable _parentIdTable(_$AppDriftDatabase db) => db.folders
      .createAlias($_aliasNameGenerator(db.folders.parentId, db.folders.id));

  $$FoldersTableProcessedTableManager? get parentId {
    final $_column = $_itemColumn<int>('parent_id');
    if ($_column == null) return null;
    final manager = $$FoldersTableTableManager(
      $_db,
      $_db.folders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$WordGroupsTable, List<DriftWordGroup>>
  _wordGroupsRefsTable(_$AppDriftDatabase db) => MultiTypedResultKey.fromTable(
    db.wordGroups,
    aliasName: $_aliasNameGenerator(db.folders.id, db.wordGroups.folderId),
  );

  $$WordGroupsTableProcessedTableManager get wordGroupsRefs {
    final manager = $$WordGroupsTableTableManager(
      $_db,
      $_db.wordGroups,
    ).filter((f) => f.folderId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_wordGroupsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FoldersTableFilterComposer
    extends Composer<_$AppDriftDatabase, $FoldersTable> {
  $$FoldersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  $$FoldersTableFilterComposer get parentId {
    final $$FoldersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.folders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoldersTableFilterComposer(
            $db: $db,
            $table: $db.folders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> wordGroupsRefs(
    Expression<bool> Function($$WordGroupsTableFilterComposer f) f,
  ) {
    final $$WordGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordGroups,
      getReferencedColumn: (t) => t.folderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordGroupsTableFilterComposer(
            $db: $db,
            $table: $db.wordGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FoldersTableOrderingComposer
    extends Composer<_$AppDriftDatabase, $FoldersTable> {
  $$FoldersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  $$FoldersTableOrderingComposer get parentId {
    final $$FoldersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.folders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoldersTableOrderingComposer(
            $db: $db,
            $table: $db.folders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FoldersTableAnnotationComposer
    extends Composer<_$AppDriftDatabase, $FoldersTable> {
  $$FoldersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get created =>
      $composableBuilder(column: $table.created, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  $$FoldersTableAnnotationComposer get parentId {
    final $$FoldersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.folders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoldersTableAnnotationComposer(
            $db: $db,
            $table: $db.folders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> wordGroupsRefs<T extends Object>(
    Expression<T> Function($$WordGroupsTableAnnotationComposer a) f,
  ) {
    final $$WordGroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordGroups,
      getReferencedColumn: (t) => t.folderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordGroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.wordGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FoldersTableTableManager
    extends
        RootTableManager<
          _$AppDriftDatabase,
          $FoldersTable,
          DriftFolder,
          $$FoldersTableFilterComposer,
          $$FoldersTableOrderingComposer,
          $$FoldersTableAnnotationComposer,
          $$FoldersTableCreateCompanionBuilder,
          $$FoldersTableUpdateCompanionBuilder,
          (DriftFolder, $$FoldersTableReferences),
          DriftFolder,
          PrefetchHooks Function({bool parentId, bool wordGroupsRefs})
        > {
  $$FoldersTableTableManager(_$AppDriftDatabase db, $FoldersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$FoldersTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$FoldersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$FoldersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> parentId = const Value.absent(),
                Value<DateTime> created = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => FoldersCompanion(
                id: id,
                parentId: parentId,
                created: created,
                name: name,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> parentId = const Value.absent(),
                required DateTime created,
                required String name,
              }) => FoldersCompanion.insert(
                id: id,
                parentId: parentId,
                created: created,
                name: name,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$FoldersTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({parentId = false, wordGroupsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (wordGroupsRefs) db.wordGroups],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (parentId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.parentId,
                            referencedTable: $$FoldersTableReferences
                                ._parentIdTable(db),
                            referencedColumn:
                                $$FoldersTableReferences._parentIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (wordGroupsRefs)
                    await $_getPrefetchedData<
                      DriftFolder,
                      $FoldersTable,
                      DriftWordGroup
                    >(
                      currentTable: table,
                      referencedTable: $$FoldersTableReferences
                          ._wordGroupsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$FoldersTableReferences(
                                db,
                                table,
                                p0,
                              ).wordGroupsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.folderId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$FoldersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDriftDatabase,
      $FoldersTable,
      DriftFolder,
      $$FoldersTableFilterComposer,
      $$FoldersTableOrderingComposer,
      $$FoldersTableAnnotationComposer,
      $$FoldersTableCreateCompanionBuilder,
      $$FoldersTableUpdateCompanionBuilder,
      (DriftFolder, $$FoldersTableReferences),
      DriftFolder,
      PrefetchHooks Function({bool parentId, bool wordGroupsRefs})
    >;
typedef $$WordGroupsTableCreateCompanionBuilder =
    WordGroupsCompanion Function({
      Value<int> id,
      Value<int?> folderId,
      required DateTime created,
      required DateTime modified,
      required String name,
      required LanguageInfo origin,
      required LanguageInfo translation,
    });
typedef $$WordGroupsTableUpdateCompanionBuilder =
    WordGroupsCompanion Function({
      Value<int> id,
      Value<int?> folderId,
      Value<DateTime> created,
      Value<DateTime> modified,
      Value<String> name,
      Value<LanguageInfo> origin,
      Value<LanguageInfo> translation,
    });

final class $$WordGroupsTableReferences
    extends
        BaseReferences<_$AppDriftDatabase, $WordGroupsTable, DriftWordGroup> {
  $$WordGroupsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FoldersTable _folderIdTable(_$AppDriftDatabase db) => db.folders
      .createAlias($_aliasNameGenerator(db.wordGroups.folderId, db.folders.id));

  $$FoldersTableProcessedTableManager? get folderId {
    final $_column = $_itemColumn<int>('folder_id');
    if ($_column == null) return null;
    final manager = $$FoldersTableTableManager(
      $_db,
      $_db.folders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_folderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$WordsTable, List<DriftWord>> _wordsRefsTable(
    _$AppDriftDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.words,
    aliasName: $_aliasNameGenerator(db.wordGroups.id, db.words.groupId),
  );

  $$WordsTableProcessedTableManager get wordsRefs {
    final manager = $$WordsTableTableManager(
      $_db,
      $_db.words,
    ).filter((f) => f.groupId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_wordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WordGroupsTableFilterComposer
    extends Composer<_$AppDriftDatabase, $WordGroupsTable> {
  $$WordGroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get modified => $composableBuilder(
    column: $table.modified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<LanguageInfo, LanguageInfo, String>
  get origin => $composableBuilder(
    column: $table.origin,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<LanguageInfo, LanguageInfo, String>
  get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$FoldersTableFilterComposer get folderId {
    final $$FoldersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.folderId,
      referencedTable: $db.folders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoldersTableFilterComposer(
            $db: $db,
            $table: $db.folders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> wordsRefs(
    Expression<bool> Function($$WordsTableFilterComposer f) f,
  ) {
    final $$WordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableFilterComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WordGroupsTableOrderingComposer
    extends Composer<_$AppDriftDatabase, $WordGroupsTable> {
  $$WordGroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get modified => $composableBuilder(
    column: $table.modified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get origin => $composableBuilder(
    column: $table.origin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => ColumnOrderings(column),
  );

  $$FoldersTableOrderingComposer get folderId {
    final $$FoldersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.folderId,
      referencedTable: $db.folders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoldersTableOrderingComposer(
            $db: $db,
            $table: $db.folders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordGroupsTableAnnotationComposer
    extends Composer<_$AppDriftDatabase, $WordGroupsTable> {
  $$WordGroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get created =>
      $composableBuilder(column: $table.created, builder: (column) => column);

  GeneratedColumn<DateTime> get modified =>
      $composableBuilder(column: $table.modified, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LanguageInfo, String> get origin =>
      $composableBuilder(column: $table.origin, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LanguageInfo, String> get translation =>
      $composableBuilder(
        column: $table.translation,
        builder: (column) => column,
      );

  $$FoldersTableAnnotationComposer get folderId {
    final $$FoldersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.folderId,
      referencedTable: $db.folders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FoldersTableAnnotationComposer(
            $db: $db,
            $table: $db.folders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> wordsRefs<T extends Object>(
    Expression<T> Function($$WordsTableAnnotationComposer a) f,
  ) {
    final $$WordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableAnnotationComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WordGroupsTableTableManager
    extends
        RootTableManager<
          _$AppDriftDatabase,
          $WordGroupsTable,
          DriftWordGroup,
          $$WordGroupsTableFilterComposer,
          $$WordGroupsTableOrderingComposer,
          $$WordGroupsTableAnnotationComposer,
          $$WordGroupsTableCreateCompanionBuilder,
          $$WordGroupsTableUpdateCompanionBuilder,
          (DriftWordGroup, $$WordGroupsTableReferences),
          DriftWordGroup,
          PrefetchHooks Function({bool folderId, bool wordsRefs})
        > {
  $$WordGroupsTableTableManager(_$AppDriftDatabase db, $WordGroupsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$WordGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$WordGroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$WordGroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> folderId = const Value.absent(),
                Value<DateTime> created = const Value.absent(),
                Value<DateTime> modified = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<LanguageInfo> origin = const Value.absent(),
                Value<LanguageInfo> translation = const Value.absent(),
              }) => WordGroupsCompanion(
                id: id,
                folderId: folderId,
                created: created,
                modified: modified,
                name: name,
                origin: origin,
                translation: translation,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> folderId = const Value.absent(),
                required DateTime created,
                required DateTime modified,
                required String name,
                required LanguageInfo origin,
                required LanguageInfo translation,
              }) => WordGroupsCompanion.insert(
                id: id,
                folderId: folderId,
                created: created,
                modified: modified,
                name: name,
                origin: origin,
                translation: translation,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$WordGroupsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({folderId = false, wordsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (wordsRefs) db.words],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (folderId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.folderId,
                            referencedTable: $$WordGroupsTableReferences
                                ._folderIdTable(db),
                            referencedColumn:
                                $$WordGroupsTableReferences
                                    ._folderIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (wordsRefs)
                    await $_getPrefetchedData<
                      DriftWordGroup,
                      $WordGroupsTable,
                      DriftWord
                    >(
                      currentTable: table,
                      referencedTable: $$WordGroupsTableReferences
                          ._wordsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$WordGroupsTableReferences(
                                db,
                                table,
                                p0,
                              ).wordsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.groupId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$WordGroupsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDriftDatabase,
      $WordGroupsTable,
      DriftWordGroup,
      $$WordGroupsTableFilterComposer,
      $$WordGroupsTableOrderingComposer,
      $$WordGroupsTableAnnotationComposer,
      $$WordGroupsTableCreateCompanionBuilder,
      $$WordGroupsTableUpdateCompanionBuilder,
      (DriftWordGroup, $$WordGroupsTableReferences),
      DriftWordGroup,
      PrefetchHooks Function({bool folderId, bool wordsRefs})
    >;
typedef $$WordsTableCreateCompanionBuilder =
    WordsCompanion Function({
      Value<int> id,
      required int groupId,
      required DateTime created,
      required String origin,
      required String translation,
    });
typedef $$WordsTableUpdateCompanionBuilder =
    WordsCompanion Function({
      Value<int> id,
      Value<int> groupId,
      Value<DateTime> created,
      Value<String> origin,
      Value<String> translation,
    });

final class $$WordsTableReferences
    extends BaseReferences<_$AppDriftDatabase, $WordsTable, DriftWord> {
  $$WordsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WordGroupsTable _groupIdTable(_$AppDriftDatabase db) => db.wordGroups
      .createAlias($_aliasNameGenerator(db.words.groupId, db.wordGroups.id));

  $$WordGroupsTableProcessedTableManager get groupId {
    final $_column = $_itemColumn<int>('group_id')!;

    final manager = $$WordGroupsTableTableManager(
      $_db,
      $_db.wordGroups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WordsTableFilterComposer
    extends Composer<_$AppDriftDatabase, $WordsTable> {
  $$WordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get origin => $composableBuilder(
    column: $table.origin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => ColumnFilters(column),
  );

  $$WordGroupsTableFilterComposer get groupId {
    final $$WordGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.wordGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordGroupsTableFilterComposer(
            $db: $db,
            $table: $db.wordGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordsTableOrderingComposer
    extends Composer<_$AppDriftDatabase, $WordsTable> {
  $$WordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get origin => $composableBuilder(
    column: $table.origin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => ColumnOrderings(column),
  );

  $$WordGroupsTableOrderingComposer get groupId {
    final $$WordGroupsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.wordGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordGroupsTableOrderingComposer(
            $db: $db,
            $table: $db.wordGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordsTableAnnotationComposer
    extends Composer<_$AppDriftDatabase, $WordsTable> {
  $$WordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get created =>
      $composableBuilder(column: $table.created, builder: (column) => column);

  GeneratedColumn<String> get origin =>
      $composableBuilder(column: $table.origin, builder: (column) => column);

  GeneratedColumn<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => column,
  );

  $$WordGroupsTableAnnotationComposer get groupId {
    final $$WordGroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.wordGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordGroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.wordGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordsTableTableManager
    extends
        RootTableManager<
          _$AppDriftDatabase,
          $WordsTable,
          DriftWord,
          $$WordsTableFilterComposer,
          $$WordsTableOrderingComposer,
          $$WordsTableAnnotationComposer,
          $$WordsTableCreateCompanionBuilder,
          $$WordsTableUpdateCompanionBuilder,
          (DriftWord, $$WordsTableReferences),
          DriftWord,
          PrefetchHooks Function({bool groupId})
        > {
  $$WordsTableTableManager(_$AppDriftDatabase db, $WordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$WordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$WordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$WordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> groupId = const Value.absent(),
                Value<DateTime> created = const Value.absent(),
                Value<String> origin = const Value.absent(),
                Value<String> translation = const Value.absent(),
              }) => WordsCompanion(
                id: id,
                groupId: groupId,
                created: created,
                origin: origin,
                translation: translation,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int groupId,
                required DateTime created,
                required String origin,
                required String translation,
              }) => WordsCompanion.insert(
                id: id,
                groupId: groupId,
                created: created,
                origin: origin,
                translation: translation,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$WordsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({groupId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (groupId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.groupId,
                            referencedTable: $$WordsTableReferences
                                ._groupIdTable(db),
                            referencedColumn:
                                $$WordsTableReferences._groupIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDriftDatabase,
      $WordsTable,
      DriftWord,
      $$WordsTableFilterComposer,
      $$WordsTableOrderingComposer,
      $$WordsTableAnnotationComposer,
      $$WordsTableCreateCompanionBuilder,
      $$WordsTableUpdateCompanionBuilder,
      (DriftWord, $$WordsTableReferences),
      DriftWord,
      PrefetchHooks Function({bool groupId})
    >;

class $AppDriftDatabaseManager {
  final _$AppDriftDatabase _db;
  $AppDriftDatabaseManager(this._db);
  $$FoldersTableTableManager get folders =>
      $$FoldersTableTableManager(_db, _db.folders);
  $$WordGroupsTableTableManager get wordGroups =>
      $$WordGroupsTableTableManager(_db, _db.wordGroups);
  $$WordsTableTableManager get words =>
      $$WordsTableTableManager(_db, _db.words);
}
