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
  static const VerificationMeta _languageOriginCodeMeta =
      const VerificationMeta('languageOriginCode');
  @override
  late final GeneratedColumn<String> languageOriginCode =
      GeneratedColumn<String>(
        'language_origin_code',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _languageOriginNameMeta =
      const VerificationMeta('languageOriginName');
  @override
  late final GeneratedColumn<String> languageOriginName =
      GeneratedColumn<String>(
        'language_origin_name',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _languageOriginNativeMeta =
      const VerificationMeta('languageOriginNative');
  @override
  late final GeneratedColumn<String> languageOriginNative =
      GeneratedColumn<String>(
        'language_origin_native',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _languageTranslationCodeMeta =
      const VerificationMeta('languageTranslationCode');
  @override
  late final GeneratedColumn<String> languageTranslationCode =
      GeneratedColumn<String>(
        'language_translation_code',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _languageTranslationNameMeta =
      const VerificationMeta('languageTranslationName');
  @override
  late final GeneratedColumn<String> languageTranslationName =
      GeneratedColumn<String>(
        'language_translation_name',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _languageTranslationNativeMeta =
      const VerificationMeta('languageTranslationNative');
  @override
  late final GeneratedColumn<String> languageTranslationNative =
      GeneratedColumn<String>(
        'language_translation_native',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    folderId,
    created,
    modified,
    name,
    languageOriginCode,
    languageOriginName,
    languageOriginNative,
    languageTranslationCode,
    languageTranslationName,
    languageTranslationNative,
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
    if (data.containsKey('language_origin_code')) {
      context.handle(
        _languageOriginCodeMeta,
        languageOriginCode.isAcceptableOrUnknown(
          data['language_origin_code']!,
          _languageOriginCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_languageOriginCodeMeta);
    }
    if (data.containsKey('language_origin_name')) {
      context.handle(
        _languageOriginNameMeta,
        languageOriginName.isAcceptableOrUnknown(
          data['language_origin_name']!,
          _languageOriginNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_languageOriginNameMeta);
    }
    if (data.containsKey('language_origin_native')) {
      context.handle(
        _languageOriginNativeMeta,
        languageOriginNative.isAcceptableOrUnknown(
          data['language_origin_native']!,
          _languageOriginNativeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_languageOriginNativeMeta);
    }
    if (data.containsKey('language_translation_code')) {
      context.handle(
        _languageTranslationCodeMeta,
        languageTranslationCode.isAcceptableOrUnknown(
          data['language_translation_code']!,
          _languageTranslationCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_languageTranslationCodeMeta);
    }
    if (data.containsKey('language_translation_name')) {
      context.handle(
        _languageTranslationNameMeta,
        languageTranslationName.isAcceptableOrUnknown(
          data['language_translation_name']!,
          _languageTranslationNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_languageTranslationNameMeta);
    }
    if (data.containsKey('language_translation_native')) {
      context.handle(
        _languageTranslationNativeMeta,
        languageTranslationNative.isAcceptableOrUnknown(
          data['language_translation_native']!,
          _languageTranslationNativeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_languageTranslationNativeMeta);
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
      languageOriginCode:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}language_origin_code'],
          )!,
      languageOriginName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}language_origin_name'],
          )!,
      languageOriginNative:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}language_origin_native'],
          )!,
      languageTranslationCode:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}language_translation_code'],
          )!,
      languageTranslationName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}language_translation_name'],
          )!,
      languageTranslationNative:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}language_translation_native'],
          )!,
    );
  }

  @override
  $WordGroupsTable createAlias(String alias) {
    return $WordGroupsTable(attachedDatabase, alias);
  }
}

class DriftWordGroup extends DataClass implements Insertable<DriftWordGroup> {
  final int id;
  final int? folderId;
  final DateTime created;
  final DateTime modified;
  final String name;
  final String languageOriginCode;
  final String languageOriginName;
  final String languageOriginNative;
  final String languageTranslationCode;
  final String languageTranslationName;
  final String languageTranslationNative;
  const DriftWordGroup({
    required this.id,
    this.folderId,
    required this.created,
    required this.modified,
    required this.name,
    required this.languageOriginCode,
    required this.languageOriginName,
    required this.languageOriginNative,
    required this.languageTranslationCode,
    required this.languageTranslationName,
    required this.languageTranslationNative,
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
    map['language_origin_code'] = Variable<String>(languageOriginCode);
    map['language_origin_name'] = Variable<String>(languageOriginName);
    map['language_origin_native'] = Variable<String>(languageOriginNative);
    map['language_translation_code'] = Variable<String>(
      languageTranslationCode,
    );
    map['language_translation_name'] = Variable<String>(
      languageTranslationName,
    );
    map['language_translation_native'] = Variable<String>(
      languageTranslationNative,
    );
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
      languageOriginCode: Value(languageOriginCode),
      languageOriginName: Value(languageOriginName),
      languageOriginNative: Value(languageOriginNative),
      languageTranslationCode: Value(languageTranslationCode),
      languageTranslationName: Value(languageTranslationName),
      languageTranslationNative: Value(languageTranslationNative),
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
      languageOriginCode: serializer.fromJson<String>(
        json['languageOriginCode'],
      ),
      languageOriginName: serializer.fromJson<String>(
        json['languageOriginName'],
      ),
      languageOriginNative: serializer.fromJson<String>(
        json['languageOriginNative'],
      ),
      languageTranslationCode: serializer.fromJson<String>(
        json['languageTranslationCode'],
      ),
      languageTranslationName: serializer.fromJson<String>(
        json['languageTranslationName'],
      ),
      languageTranslationNative: serializer.fromJson<String>(
        json['languageTranslationNative'],
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
      'languageOriginCode': serializer.toJson<String>(languageOriginCode),
      'languageOriginName': serializer.toJson<String>(languageOriginName),
      'languageOriginNative': serializer.toJson<String>(languageOriginNative),
      'languageTranslationCode': serializer.toJson<String>(
        languageTranslationCode,
      ),
      'languageTranslationName': serializer.toJson<String>(
        languageTranslationName,
      ),
      'languageTranslationNative': serializer.toJson<String>(
        languageTranslationNative,
      ),
    };
  }

  DriftWordGroup copyWith({
    int? id,
    Value<int?> folderId = const Value.absent(),
    DateTime? created,
    DateTime? modified,
    String? name,
    String? languageOriginCode,
    String? languageOriginName,
    String? languageOriginNative,
    String? languageTranslationCode,
    String? languageTranslationName,
    String? languageTranslationNative,
  }) => DriftWordGroup(
    id: id ?? this.id,
    folderId: folderId.present ? folderId.value : this.folderId,
    created: created ?? this.created,
    modified: modified ?? this.modified,
    name: name ?? this.name,
    languageOriginCode: languageOriginCode ?? this.languageOriginCode,
    languageOriginName: languageOriginName ?? this.languageOriginName,
    languageOriginNative: languageOriginNative ?? this.languageOriginNative,
    languageTranslationCode:
        languageTranslationCode ?? this.languageTranslationCode,
    languageTranslationName:
        languageTranslationName ?? this.languageTranslationName,
    languageTranslationNative:
        languageTranslationNative ?? this.languageTranslationNative,
  );
  DriftWordGroup copyWithCompanion(WordGroupsCompanion data) {
    return DriftWordGroup(
      id: data.id.present ? data.id.value : this.id,
      folderId: data.folderId.present ? data.folderId.value : this.folderId,
      created: data.created.present ? data.created.value : this.created,
      modified: data.modified.present ? data.modified.value : this.modified,
      name: data.name.present ? data.name.value : this.name,
      languageOriginCode:
          data.languageOriginCode.present
              ? data.languageOriginCode.value
              : this.languageOriginCode,
      languageOriginName:
          data.languageOriginName.present
              ? data.languageOriginName.value
              : this.languageOriginName,
      languageOriginNative:
          data.languageOriginNative.present
              ? data.languageOriginNative.value
              : this.languageOriginNative,
      languageTranslationCode:
          data.languageTranslationCode.present
              ? data.languageTranslationCode.value
              : this.languageTranslationCode,
      languageTranslationName:
          data.languageTranslationName.present
              ? data.languageTranslationName.value
              : this.languageTranslationName,
      languageTranslationNative:
          data.languageTranslationNative.present
              ? data.languageTranslationNative.value
              : this.languageTranslationNative,
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
          ..write('languageOriginCode: $languageOriginCode, ')
          ..write('languageOriginName: $languageOriginName, ')
          ..write('languageOriginNative: $languageOriginNative, ')
          ..write('languageTranslationCode: $languageTranslationCode, ')
          ..write('languageTranslationName: $languageTranslationName, ')
          ..write('languageTranslationNative: $languageTranslationNative')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    folderId,
    created,
    modified,
    name,
    languageOriginCode,
    languageOriginName,
    languageOriginNative,
    languageTranslationCode,
    languageTranslationName,
    languageTranslationNative,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftWordGroup &&
          other.id == this.id &&
          other.folderId == this.folderId &&
          other.created == this.created &&
          other.modified == this.modified &&
          other.name == this.name &&
          other.languageOriginCode == this.languageOriginCode &&
          other.languageOriginName == this.languageOriginName &&
          other.languageOriginNative == this.languageOriginNative &&
          other.languageTranslationCode == this.languageTranslationCode &&
          other.languageTranslationName == this.languageTranslationName &&
          other.languageTranslationNative == this.languageTranslationNative);
}

class WordGroupsCompanion extends UpdateCompanion<DriftWordGroup> {
  final Value<int> id;
  final Value<int?> folderId;
  final Value<DateTime> created;
  final Value<DateTime> modified;
  final Value<String> name;
  final Value<String> languageOriginCode;
  final Value<String> languageOriginName;
  final Value<String> languageOriginNative;
  final Value<String> languageTranslationCode;
  final Value<String> languageTranslationName;
  final Value<String> languageTranslationNative;
  const WordGroupsCompanion({
    this.id = const Value.absent(),
    this.folderId = const Value.absent(),
    this.created = const Value.absent(),
    this.modified = const Value.absent(),
    this.name = const Value.absent(),
    this.languageOriginCode = const Value.absent(),
    this.languageOriginName = const Value.absent(),
    this.languageOriginNative = const Value.absent(),
    this.languageTranslationCode = const Value.absent(),
    this.languageTranslationName = const Value.absent(),
    this.languageTranslationNative = const Value.absent(),
  });
  WordGroupsCompanion.insert({
    this.id = const Value.absent(),
    this.folderId = const Value.absent(),
    required DateTime created,
    required DateTime modified,
    required String name,
    required String languageOriginCode,
    required String languageOriginName,
    required String languageOriginNative,
    required String languageTranslationCode,
    required String languageTranslationName,
    required String languageTranslationNative,
  }) : created = Value(created),
       modified = Value(modified),
       name = Value(name),
       languageOriginCode = Value(languageOriginCode),
       languageOriginName = Value(languageOriginName),
       languageOriginNative = Value(languageOriginNative),
       languageTranslationCode = Value(languageTranslationCode),
       languageTranslationName = Value(languageTranslationName),
       languageTranslationNative = Value(languageTranslationNative);
  static Insertable<DriftWordGroup> custom({
    Expression<int>? id,
    Expression<int>? folderId,
    Expression<DateTime>? created,
    Expression<DateTime>? modified,
    Expression<String>? name,
    Expression<String>? languageOriginCode,
    Expression<String>? languageOriginName,
    Expression<String>? languageOriginNative,
    Expression<String>? languageTranslationCode,
    Expression<String>? languageTranslationName,
    Expression<String>? languageTranslationNative,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (folderId != null) 'folder_id': folderId,
      if (created != null) 'created': created,
      if (modified != null) 'modified': modified,
      if (name != null) 'name': name,
      if (languageOriginCode != null)
        'language_origin_code': languageOriginCode,
      if (languageOriginName != null)
        'language_origin_name': languageOriginName,
      if (languageOriginNative != null)
        'language_origin_native': languageOriginNative,
      if (languageTranslationCode != null)
        'language_translation_code': languageTranslationCode,
      if (languageTranslationName != null)
        'language_translation_name': languageTranslationName,
      if (languageTranslationNative != null)
        'language_translation_native': languageTranslationNative,
    });
  }

  WordGroupsCompanion copyWith({
    Value<int>? id,
    Value<int?>? folderId,
    Value<DateTime>? created,
    Value<DateTime>? modified,
    Value<String>? name,
    Value<String>? languageOriginCode,
    Value<String>? languageOriginName,
    Value<String>? languageOriginNative,
    Value<String>? languageTranslationCode,
    Value<String>? languageTranslationName,
    Value<String>? languageTranslationNative,
  }) {
    return WordGroupsCompanion(
      id: id ?? this.id,
      folderId: folderId ?? this.folderId,
      created: created ?? this.created,
      modified: modified ?? this.modified,
      name: name ?? this.name,
      languageOriginCode: languageOriginCode ?? this.languageOriginCode,
      languageOriginName: languageOriginName ?? this.languageOriginName,
      languageOriginNative: languageOriginNative ?? this.languageOriginNative,
      languageTranslationCode:
          languageTranslationCode ?? this.languageTranslationCode,
      languageTranslationName:
          languageTranslationName ?? this.languageTranslationName,
      languageTranslationNative:
          languageTranslationNative ?? this.languageTranslationNative,
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
    if (languageOriginCode.present) {
      map['language_origin_code'] = Variable<String>(languageOriginCode.value);
    }
    if (languageOriginName.present) {
      map['language_origin_name'] = Variable<String>(languageOriginName.value);
    }
    if (languageOriginNative.present) {
      map['language_origin_native'] = Variable<String>(
        languageOriginNative.value,
      );
    }
    if (languageTranslationCode.present) {
      map['language_translation_code'] = Variable<String>(
        languageTranslationCode.value,
      );
    }
    if (languageTranslationName.present) {
      map['language_translation_name'] = Variable<String>(
        languageTranslationName.value,
      );
    }
    if (languageTranslationNative.present) {
      map['language_translation_native'] = Variable<String>(
        languageTranslationNative.value,
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
          ..write('languageOriginCode: $languageOriginCode, ')
          ..write('languageOriginName: $languageOriginName, ')
          ..write('languageOriginNative: $languageOriginNative, ')
          ..write('languageTranslationCode: $languageTranslationCode, ')
          ..write('languageTranslationName: $languageTranslationName, ')
          ..write('languageTranslationNative: $languageTranslationNative')
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

class $WordStatisticsTable extends WordStatistics
    with TableInfo<$WordStatisticsTable, DriftWordAnswerStats> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordStatisticsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<String> word = GeneratedColumn<String>(
    'word',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _correctMeta = const VerificationMeta(
    'correct',
  );
  @override
  late final GeneratedColumn<int> correct = GeneratedColumn<int>(
    'correct',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _incorrectMeta = const VerificationMeta(
    'incorrect',
  );
  @override
  late final GeneratedColumn<int> incorrect = GeneratedColumn<int>(
    'incorrect',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [word, correct, incorrect];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_statistics';
  @override
  VerificationContext validateIntegrity(
    Insertable<DriftWordAnswerStats> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('word')) {
      context.handle(
        _wordMeta,
        word.isAcceptableOrUnknown(data['word']!, _wordMeta),
      );
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('correct')) {
      context.handle(
        _correctMeta,
        correct.isAcceptableOrUnknown(data['correct']!, _correctMeta),
      );
    } else if (isInserting) {
      context.missing(_correctMeta);
    }
    if (data.containsKey('incorrect')) {
      context.handle(
        _incorrectMeta,
        incorrect.isAcceptableOrUnknown(data['incorrect']!, _incorrectMeta),
      );
    } else if (isInserting) {
      context.missing(_incorrectMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  DriftWordAnswerStats map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftWordAnswerStats(
      word:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}word'],
          )!,
      correct:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}correct'],
          )!,
      incorrect:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}incorrect'],
          )!,
    );
  }

  @override
  $WordStatisticsTable createAlias(String alias) {
    return $WordStatisticsTable(attachedDatabase, alias);
  }
}

class DriftWordAnswerStats extends DataClass
    implements Insertable<DriftWordAnswerStats> {
  final String word;
  final int correct;
  final int incorrect;
  const DriftWordAnswerStats({
    required this.word,
    required this.correct,
    required this.incorrect,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['word'] = Variable<String>(word);
    map['correct'] = Variable<int>(correct);
    map['incorrect'] = Variable<int>(incorrect);
    return map;
  }

  WordStatisticsCompanion toCompanion(bool nullToAbsent) {
    return WordStatisticsCompanion(
      word: Value(word),
      correct: Value(correct),
      incorrect: Value(incorrect),
    );
  }

  factory DriftWordAnswerStats.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftWordAnswerStats(
      word: serializer.fromJson<String>(json['word']),
      correct: serializer.fromJson<int>(json['correct']),
      incorrect: serializer.fromJson<int>(json['incorrect']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'word': serializer.toJson<String>(word),
      'correct': serializer.toJson<int>(correct),
      'incorrect': serializer.toJson<int>(incorrect),
    };
  }

  DriftWordAnswerStats copyWith({String? word, int? correct, int? incorrect}) =>
      DriftWordAnswerStats(
        word: word ?? this.word,
        correct: correct ?? this.correct,
        incorrect: incorrect ?? this.incorrect,
      );
  DriftWordAnswerStats copyWithCompanion(WordStatisticsCompanion data) {
    return DriftWordAnswerStats(
      word: data.word.present ? data.word.value : this.word,
      correct: data.correct.present ? data.correct.value : this.correct,
      incorrect: data.incorrect.present ? data.incorrect.value : this.incorrect,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftWordAnswerStats(')
          ..write('word: $word, ')
          ..write('correct: $correct, ')
          ..write('incorrect: $incorrect')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(word, correct, incorrect);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftWordAnswerStats &&
          other.word == this.word &&
          other.correct == this.correct &&
          other.incorrect == this.incorrect);
}

class WordStatisticsCompanion extends UpdateCompanion<DriftWordAnswerStats> {
  final Value<String> word;
  final Value<int> correct;
  final Value<int> incorrect;
  final Value<int> rowid;
  const WordStatisticsCompanion({
    this.word = const Value.absent(),
    this.correct = const Value.absent(),
    this.incorrect = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WordStatisticsCompanion.insert({
    required String word,
    required int correct,
    required int incorrect,
    this.rowid = const Value.absent(),
  }) : word = Value(word),
       correct = Value(correct),
       incorrect = Value(incorrect);
  static Insertable<DriftWordAnswerStats> custom({
    Expression<String>? word,
    Expression<int>? correct,
    Expression<int>? incorrect,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (word != null) 'word': word,
      if (correct != null) 'correct': correct,
      if (incorrect != null) 'incorrect': incorrect,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WordStatisticsCompanion copyWith({
    Value<String>? word,
    Value<int>? correct,
    Value<int>? incorrect,
    Value<int>? rowid,
  }) {
    return WordStatisticsCompanion(
      word: word ?? this.word,
      correct: correct ?? this.correct,
      incorrect: incorrect ?? this.incorrect,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (correct.present) {
      map['correct'] = Variable<int>(correct.value);
    }
    if (incorrect.present) {
      map['incorrect'] = Variable<int>(incorrect.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordStatisticsCompanion(')
          ..write('word: $word, ')
          ..write('correct: $correct, ')
          ..write('incorrect: $incorrect, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WordMetadatasTable extends WordMetadatas
    with TableInfo<$WordMetadatasTable, DriftWordMetadata> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordMetadatasTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<String> word = GeneratedColumn<String>(
    'word',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _etymologyMeta = const VerificationMeta(
    'etymology',
  );
  @override
  late final GeneratedColumn<String> etymology = GeneratedColumn<String>(
    'etymology',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, word, etymology];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_metadatas';
  @override
  VerificationContext validateIntegrity(
    Insertable<DriftWordMetadata> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('word')) {
      context.handle(
        _wordMeta,
        word.isAcceptableOrUnknown(data['word']!, _wordMeta),
      );
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('etymology')) {
      context.handle(
        _etymologyMeta,
        etymology.isAcceptableOrUnknown(data['etymology']!, _etymologyMeta),
      );
    } else if (isInserting) {
      context.missing(_etymologyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftWordMetadata map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftWordMetadata(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      word:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}word'],
          )!,
      etymology:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}etymology'],
          )!,
    );
  }

  @override
  $WordMetadatasTable createAlias(String alias) {
    return $WordMetadatasTable(attachedDatabase, alias);
  }
}

class DriftWordMetadata extends DataClass
    implements Insertable<DriftWordMetadata> {
  final int id;
  final String word;
  final String etymology;
  const DriftWordMetadata({
    required this.id,
    required this.word,
    required this.etymology,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['word'] = Variable<String>(word);
    map['etymology'] = Variable<String>(etymology);
    return map;
  }

  WordMetadatasCompanion toCompanion(bool nullToAbsent) {
    return WordMetadatasCompanion(
      id: Value(id),
      word: Value(word),
      etymology: Value(etymology),
    );
  }

  factory DriftWordMetadata.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftWordMetadata(
      id: serializer.fromJson<int>(json['id']),
      word: serializer.fromJson<String>(json['word']),
      etymology: serializer.fromJson<String>(json['etymology']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'word': serializer.toJson<String>(word),
      'etymology': serializer.toJson<String>(etymology),
    };
  }

  DriftWordMetadata copyWith({int? id, String? word, String? etymology}) =>
      DriftWordMetadata(
        id: id ?? this.id,
        word: word ?? this.word,
        etymology: etymology ?? this.etymology,
      );
  DriftWordMetadata copyWithCompanion(WordMetadatasCompanion data) {
    return DriftWordMetadata(
      id: data.id.present ? data.id.value : this.id,
      word: data.word.present ? data.word.value : this.word,
      etymology: data.etymology.present ? data.etymology.value : this.etymology,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftWordMetadata(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('etymology: $etymology')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, word, etymology);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftWordMetadata &&
          other.id == this.id &&
          other.word == this.word &&
          other.etymology == this.etymology);
}

class WordMetadatasCompanion extends UpdateCompanion<DriftWordMetadata> {
  final Value<int> id;
  final Value<String> word;
  final Value<String> etymology;
  const WordMetadatasCompanion({
    this.id = const Value.absent(),
    this.word = const Value.absent(),
    this.etymology = const Value.absent(),
  });
  WordMetadatasCompanion.insert({
    this.id = const Value.absent(),
    required String word,
    required String etymology,
  }) : word = Value(word),
       etymology = Value(etymology);
  static Insertable<DriftWordMetadata> custom({
    Expression<int>? id,
    Expression<String>? word,
    Expression<String>? etymology,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (word != null) 'word': word,
      if (etymology != null) 'etymology': etymology,
    });
  }

  WordMetadatasCompanion copyWith({
    Value<int>? id,
    Value<String>? word,
    Value<String>? etymology,
  }) {
    return WordMetadatasCompanion(
      id: id ?? this.id,
      word: word ?? this.word,
      etymology: etymology ?? this.etymology,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (etymology.present) {
      map['etymology'] = Variable<String>(etymology.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordMetadatasCompanion(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('etymology: $etymology')
          ..write(')'))
        .toString();
  }
}

class $WordMetadataWebLookupsTable extends WordMetadataWebLookups
    with TableInfo<$WordMetadataWebLookupsTable, DriftWordMetadataWebLookup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordMetadataWebLookupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<String> word = GeneratedColumn<String>(
    'word',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstAttempMeta = const VerificationMeta(
    'firstAttemp',
  );
  @override
  late final GeneratedColumn<DateTime> firstAttemp = GeneratedColumn<DateTime>(
    'first_attemp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastAttempMeta = const VerificationMeta(
    'lastAttemp',
  );
  @override
  late final GeneratedColumn<DateTime> lastAttemp = GeneratedColumn<DateTime>(
    'last_attemp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attempsMeta = const VerificationMeta(
    'attemps',
  );
  @override
  late final GeneratedColumn<int> attemps = GeneratedColumn<int>(
    'attemps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    word,
    firstAttemp,
    lastAttemp,
    attemps,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_metadata_web_lookups';
  @override
  VerificationContext validateIntegrity(
    Insertable<DriftWordMetadataWebLookup> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('word')) {
      context.handle(
        _wordMeta,
        word.isAcceptableOrUnknown(data['word']!, _wordMeta),
      );
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('first_attemp')) {
      context.handle(
        _firstAttempMeta,
        firstAttemp.isAcceptableOrUnknown(
          data['first_attemp']!,
          _firstAttempMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_firstAttempMeta);
    }
    if (data.containsKey('last_attemp')) {
      context.handle(
        _lastAttempMeta,
        lastAttemp.isAcceptableOrUnknown(data['last_attemp']!, _lastAttempMeta),
      );
    } else if (isInserting) {
      context.missing(_lastAttempMeta);
    }
    if (data.containsKey('attemps')) {
      context.handle(
        _attempsMeta,
        attemps.isAcceptableOrUnknown(data['attemps']!, _attempsMeta),
      );
    } else if (isInserting) {
      context.missing(_attempsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  DriftWordMetadataWebLookup map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftWordMetadataWebLookup(
      word:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}word'],
          )!,
      firstAttemp:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}first_attemp'],
          )!,
      lastAttemp:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}last_attemp'],
          )!,
      attemps:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}attemps'],
          )!,
    );
  }

  @override
  $WordMetadataWebLookupsTable createAlias(String alias) {
    return $WordMetadataWebLookupsTable(attachedDatabase, alias);
  }
}

class DriftWordMetadataWebLookup extends DataClass
    implements Insertable<DriftWordMetadataWebLookup> {
  final String word;
  final DateTime firstAttemp;
  final DateTime lastAttemp;
  final int attemps;
  const DriftWordMetadataWebLookup({
    required this.word,
    required this.firstAttemp,
    required this.lastAttemp,
    required this.attemps,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['word'] = Variable<String>(word);
    map['first_attemp'] = Variable<DateTime>(firstAttemp);
    map['last_attemp'] = Variable<DateTime>(lastAttemp);
    map['attemps'] = Variable<int>(attemps);
    return map;
  }

  WordMetadataWebLookupsCompanion toCompanion(bool nullToAbsent) {
    return WordMetadataWebLookupsCompanion(
      word: Value(word),
      firstAttemp: Value(firstAttemp),
      lastAttemp: Value(lastAttemp),
      attemps: Value(attemps),
    );
  }

  factory DriftWordMetadataWebLookup.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftWordMetadataWebLookup(
      word: serializer.fromJson<String>(json['word']),
      firstAttemp: serializer.fromJson<DateTime>(json['firstAttemp']),
      lastAttemp: serializer.fromJson<DateTime>(json['lastAttemp']),
      attemps: serializer.fromJson<int>(json['attemps']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'word': serializer.toJson<String>(word),
      'firstAttemp': serializer.toJson<DateTime>(firstAttemp),
      'lastAttemp': serializer.toJson<DateTime>(lastAttemp),
      'attemps': serializer.toJson<int>(attemps),
    };
  }

  DriftWordMetadataWebLookup copyWith({
    String? word,
    DateTime? firstAttemp,
    DateTime? lastAttemp,
    int? attemps,
  }) => DriftWordMetadataWebLookup(
    word: word ?? this.word,
    firstAttemp: firstAttemp ?? this.firstAttemp,
    lastAttemp: lastAttemp ?? this.lastAttemp,
    attemps: attemps ?? this.attemps,
  );
  DriftWordMetadataWebLookup copyWithCompanion(
    WordMetadataWebLookupsCompanion data,
  ) {
    return DriftWordMetadataWebLookup(
      word: data.word.present ? data.word.value : this.word,
      firstAttemp:
          data.firstAttemp.present ? data.firstAttemp.value : this.firstAttemp,
      lastAttemp:
          data.lastAttemp.present ? data.lastAttemp.value : this.lastAttemp,
      attemps: data.attemps.present ? data.attemps.value : this.attemps,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftWordMetadataWebLookup(')
          ..write('word: $word, ')
          ..write('firstAttemp: $firstAttemp, ')
          ..write('lastAttemp: $lastAttemp, ')
          ..write('attemps: $attemps')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(word, firstAttemp, lastAttemp, attemps);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftWordMetadataWebLookup &&
          other.word == this.word &&
          other.firstAttemp == this.firstAttemp &&
          other.lastAttemp == this.lastAttemp &&
          other.attemps == this.attemps);
}

class WordMetadataWebLookupsCompanion
    extends UpdateCompanion<DriftWordMetadataWebLookup> {
  final Value<String> word;
  final Value<DateTime> firstAttemp;
  final Value<DateTime> lastAttemp;
  final Value<int> attemps;
  final Value<int> rowid;
  const WordMetadataWebLookupsCompanion({
    this.word = const Value.absent(),
    this.firstAttemp = const Value.absent(),
    this.lastAttemp = const Value.absent(),
    this.attemps = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WordMetadataWebLookupsCompanion.insert({
    required String word,
    required DateTime firstAttemp,
    required DateTime lastAttemp,
    required int attemps,
    this.rowid = const Value.absent(),
  }) : word = Value(word),
       firstAttemp = Value(firstAttemp),
       lastAttemp = Value(lastAttemp),
       attemps = Value(attemps);
  static Insertable<DriftWordMetadataWebLookup> custom({
    Expression<String>? word,
    Expression<DateTime>? firstAttemp,
    Expression<DateTime>? lastAttemp,
    Expression<int>? attemps,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (word != null) 'word': word,
      if (firstAttemp != null) 'first_attemp': firstAttemp,
      if (lastAttemp != null) 'last_attemp': lastAttemp,
      if (attemps != null) 'attemps': attemps,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WordMetadataWebLookupsCompanion copyWith({
    Value<String>? word,
    Value<DateTime>? firstAttemp,
    Value<DateTime>? lastAttemp,
    Value<int>? attemps,
    Value<int>? rowid,
  }) {
    return WordMetadataWebLookupsCompanion(
      word: word ?? this.word,
      firstAttemp: firstAttemp ?? this.firstAttemp,
      lastAttemp: lastAttemp ?? this.lastAttemp,
      attemps: attemps ?? this.attemps,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (firstAttemp.present) {
      map['first_attemp'] = Variable<DateTime>(firstAttemp.value);
    }
    if (lastAttemp.present) {
      map['last_attemp'] = Variable<DateTime>(lastAttemp.value);
    }
    if (attemps.present) {
      map['attemps'] = Variable<int>(attemps.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordMetadataWebLookupsCompanion(')
          ..write('word: $word, ')
          ..write('firstAttemp: $firstAttemp, ')
          ..write('lastAttemp: $lastAttemp, ')
          ..write('attemps: $attemps, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PhoneticsTable extends Phonetics
    with TableInfo<$PhoneticsTable, DriftPhonetic> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhoneticsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _metadataIdMeta = const VerificationMeta(
    'metadataId',
  );
  @override
  late final GeneratedColumn<int> metadataId = GeneratedColumn<int>(
    'metadata_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES word_metadatas (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _audioMeta = const VerificationMeta('audio');
  @override
  late final GeneratedColumn<String> audio = GeneratedColumn<String>(
    'audio',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, metadataId, value, audio];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'phonetics';
  @override
  VerificationContext validateIntegrity(
    Insertable<DriftPhonetic> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('metadata_id')) {
      context.handle(
        _metadataIdMeta,
        metadataId.isAcceptableOrUnknown(data['metadata_id']!, _metadataIdMeta),
      );
    } else if (isInserting) {
      context.missing(_metadataIdMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('audio')) {
      context.handle(
        _audioMeta,
        audio.isAcceptableOrUnknown(data['audio']!, _audioMeta),
      );
    } else if (isInserting) {
      context.missing(_audioMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftPhonetic map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftPhonetic(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      metadataId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}metadata_id'],
          )!,
      value:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}value'],
          )!,
      audio:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}audio'],
          )!,
    );
  }

  @override
  $PhoneticsTable createAlias(String alias) {
    return $PhoneticsTable(attachedDatabase, alias);
  }
}

class DriftPhonetic extends DataClass implements Insertable<DriftPhonetic> {
  final int id;
  final int metadataId;
  final String value;
  final String audio;
  const DriftPhonetic({
    required this.id,
    required this.metadataId,
    required this.value,
    required this.audio,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['metadata_id'] = Variable<int>(metadataId);
    map['value'] = Variable<String>(value);
    map['audio'] = Variable<String>(audio);
    return map;
  }

  PhoneticsCompanion toCompanion(bool nullToAbsent) {
    return PhoneticsCompanion(
      id: Value(id),
      metadataId: Value(metadataId),
      value: Value(value),
      audio: Value(audio),
    );
  }

  factory DriftPhonetic.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftPhonetic(
      id: serializer.fromJson<int>(json['id']),
      metadataId: serializer.fromJson<int>(json['metadataId']),
      value: serializer.fromJson<String>(json['value']),
      audio: serializer.fromJson<String>(json['audio']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'metadataId': serializer.toJson<int>(metadataId),
      'value': serializer.toJson<String>(value),
      'audio': serializer.toJson<String>(audio),
    };
  }

  DriftPhonetic copyWith({
    int? id,
    int? metadataId,
    String? value,
    String? audio,
  }) => DriftPhonetic(
    id: id ?? this.id,
    metadataId: metadataId ?? this.metadataId,
    value: value ?? this.value,
    audio: audio ?? this.audio,
  );
  DriftPhonetic copyWithCompanion(PhoneticsCompanion data) {
    return DriftPhonetic(
      id: data.id.present ? data.id.value : this.id,
      metadataId:
          data.metadataId.present ? data.metadataId.value : this.metadataId,
      value: data.value.present ? data.value.value : this.value,
      audio: data.audio.present ? data.audio.value : this.audio,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftPhonetic(')
          ..write('id: $id, ')
          ..write('metadataId: $metadataId, ')
          ..write('value: $value, ')
          ..write('audio: $audio')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, metadataId, value, audio);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftPhonetic &&
          other.id == this.id &&
          other.metadataId == this.metadataId &&
          other.value == this.value &&
          other.audio == this.audio);
}

class PhoneticsCompanion extends UpdateCompanion<DriftPhonetic> {
  final Value<int> id;
  final Value<int> metadataId;
  final Value<String> value;
  final Value<String> audio;
  const PhoneticsCompanion({
    this.id = const Value.absent(),
    this.metadataId = const Value.absent(),
    this.value = const Value.absent(),
    this.audio = const Value.absent(),
  });
  PhoneticsCompanion.insert({
    this.id = const Value.absent(),
    required int metadataId,
    required String value,
    required String audio,
  }) : metadataId = Value(metadataId),
       value = Value(value),
       audio = Value(audio);
  static Insertable<DriftPhonetic> custom({
    Expression<int>? id,
    Expression<int>? metadataId,
    Expression<String>? value,
    Expression<String>? audio,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (metadataId != null) 'metadata_id': metadataId,
      if (value != null) 'value': value,
      if (audio != null) 'audio': audio,
    });
  }

  PhoneticsCompanion copyWith({
    Value<int>? id,
    Value<int>? metadataId,
    Value<String>? value,
    Value<String>? audio,
  }) {
    return PhoneticsCompanion(
      id: id ?? this.id,
      metadataId: metadataId ?? this.metadataId,
      value: value ?? this.value,
      audio: audio ?? this.audio,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (metadataId.present) {
      map['metadata_id'] = Variable<int>(metadataId.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (audio.present) {
      map['audio'] = Variable<String>(audio.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhoneticsCompanion(')
          ..write('id: $id, ')
          ..write('metadataId: $metadataId, ')
          ..write('value: $value, ')
          ..write('audio: $audio')
          ..write(')'))
        .toString();
  }
}

class $MeaningsTable extends Meanings
    with TableInfo<$MeaningsTable, DriftMeaning> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MeaningsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _metadataIdMeta = const VerificationMeta(
    'metadataId',
  );
  @override
  late final GeneratedColumn<int> metadataId = GeneratedColumn<int>(
    'metadata_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES word_metadatas (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _partOfSpeechMeta = const VerificationMeta(
    'partOfSpeech',
  );
  @override
  late final GeneratedColumn<String> partOfSpeech = GeneratedColumn<String>(
    'part_of_speech',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> synonyms =
      GeneratedColumn<String>(
        'synonyms',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<List<String>>($MeaningsTable.$convertersynonyms);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> antonyms =
      GeneratedColumn<String>(
        'antonyms',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<List<String>>($MeaningsTable.$converterantonyms);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    metadataId,
    partOfSpeech,
    synonyms,
    antonyms,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meanings';
  @override
  VerificationContext validateIntegrity(
    Insertable<DriftMeaning> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('metadata_id')) {
      context.handle(
        _metadataIdMeta,
        metadataId.isAcceptableOrUnknown(data['metadata_id']!, _metadataIdMeta),
      );
    } else if (isInserting) {
      context.missing(_metadataIdMeta);
    }
    if (data.containsKey('part_of_speech')) {
      context.handle(
        _partOfSpeechMeta,
        partOfSpeech.isAcceptableOrUnknown(
          data['part_of_speech']!,
          _partOfSpeechMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_partOfSpeechMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftMeaning map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftMeaning(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      metadataId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}metadata_id'],
          )!,
      partOfSpeech:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}part_of_speech'],
          )!,
      synonyms: $MeaningsTable.$convertersynonyms.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}synonyms'],
        )!,
      ),
      antonyms: $MeaningsTable.$converterantonyms.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}antonyms'],
        )!,
      ),
    );
  }

  @override
  $MeaningsTable createAlias(String alias) {
    return $MeaningsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<List<String>, String, Map<String, Object?>>
  $convertersynonyms = const SynonymAntonymConverter();
  static JsonTypeConverter2<List<String>, String, Map<String, Object?>>
  $converterantonyms = const SynonymAntonymConverter();
}

class DriftMeaning extends DataClass implements Insertable<DriftMeaning> {
  final int id;
  final int metadataId;
  final String partOfSpeech;
  final List<String> synonyms;
  final List<String> antonyms;
  const DriftMeaning({
    required this.id,
    required this.metadataId,
    required this.partOfSpeech,
    required this.synonyms,
    required this.antonyms,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['metadata_id'] = Variable<int>(metadataId);
    map['part_of_speech'] = Variable<String>(partOfSpeech);
    {
      map['synonyms'] = Variable<String>(
        $MeaningsTable.$convertersynonyms.toSql(synonyms),
      );
    }
    {
      map['antonyms'] = Variable<String>(
        $MeaningsTable.$converterantonyms.toSql(antonyms),
      );
    }
    return map;
  }

  MeaningsCompanion toCompanion(bool nullToAbsent) {
    return MeaningsCompanion(
      id: Value(id),
      metadataId: Value(metadataId),
      partOfSpeech: Value(partOfSpeech),
      synonyms: Value(synonyms),
      antonyms: Value(antonyms),
    );
  }

  factory DriftMeaning.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftMeaning(
      id: serializer.fromJson<int>(json['id']),
      metadataId: serializer.fromJson<int>(json['metadataId']),
      partOfSpeech: serializer.fromJson<String>(json['partOfSpeech']),
      synonyms: $MeaningsTable.$convertersynonyms.fromJson(
        serializer.fromJson<Map<String, Object?>>(json['synonyms']),
      ),
      antonyms: $MeaningsTable.$converterantonyms.fromJson(
        serializer.fromJson<Map<String, Object?>>(json['antonyms']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'metadataId': serializer.toJson<int>(metadataId),
      'partOfSpeech': serializer.toJson<String>(partOfSpeech),
      'synonyms': serializer.toJson<Map<String, Object?>>(
        $MeaningsTable.$convertersynonyms.toJson(synonyms),
      ),
      'antonyms': serializer.toJson<Map<String, Object?>>(
        $MeaningsTable.$converterantonyms.toJson(antonyms),
      ),
    };
  }

  DriftMeaning copyWith({
    int? id,
    int? metadataId,
    String? partOfSpeech,
    List<String>? synonyms,
    List<String>? antonyms,
  }) => DriftMeaning(
    id: id ?? this.id,
    metadataId: metadataId ?? this.metadataId,
    partOfSpeech: partOfSpeech ?? this.partOfSpeech,
    synonyms: synonyms ?? this.synonyms,
    antonyms: antonyms ?? this.antonyms,
  );
  DriftMeaning copyWithCompanion(MeaningsCompanion data) {
    return DriftMeaning(
      id: data.id.present ? data.id.value : this.id,
      metadataId:
          data.metadataId.present ? data.metadataId.value : this.metadataId,
      partOfSpeech:
          data.partOfSpeech.present
              ? data.partOfSpeech.value
              : this.partOfSpeech,
      synonyms: data.synonyms.present ? data.synonyms.value : this.synonyms,
      antonyms: data.antonyms.present ? data.antonyms.value : this.antonyms,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftMeaning(')
          ..write('id: $id, ')
          ..write('metadataId: $metadataId, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('synonyms: $synonyms, ')
          ..write('antonyms: $antonyms')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, metadataId, partOfSpeech, synonyms, antonyms);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftMeaning &&
          other.id == this.id &&
          other.metadataId == this.metadataId &&
          other.partOfSpeech == this.partOfSpeech &&
          other.synonyms == this.synonyms &&
          other.antonyms == this.antonyms);
}

class MeaningsCompanion extends UpdateCompanion<DriftMeaning> {
  final Value<int> id;
  final Value<int> metadataId;
  final Value<String> partOfSpeech;
  final Value<List<String>> synonyms;
  final Value<List<String>> antonyms;
  const MeaningsCompanion({
    this.id = const Value.absent(),
    this.metadataId = const Value.absent(),
    this.partOfSpeech = const Value.absent(),
    this.synonyms = const Value.absent(),
    this.antonyms = const Value.absent(),
  });
  MeaningsCompanion.insert({
    this.id = const Value.absent(),
    required int metadataId,
    required String partOfSpeech,
    required List<String> synonyms,
    required List<String> antonyms,
  }) : metadataId = Value(metadataId),
       partOfSpeech = Value(partOfSpeech),
       synonyms = Value(synonyms),
       antonyms = Value(antonyms);
  static Insertable<DriftMeaning> custom({
    Expression<int>? id,
    Expression<int>? metadataId,
    Expression<String>? partOfSpeech,
    Expression<String>? synonyms,
    Expression<String>? antonyms,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (metadataId != null) 'metadata_id': metadataId,
      if (partOfSpeech != null) 'part_of_speech': partOfSpeech,
      if (synonyms != null) 'synonyms': synonyms,
      if (antonyms != null) 'antonyms': antonyms,
    });
  }

  MeaningsCompanion copyWith({
    Value<int>? id,
    Value<int>? metadataId,
    Value<String>? partOfSpeech,
    Value<List<String>>? synonyms,
    Value<List<String>>? antonyms,
  }) {
    return MeaningsCompanion(
      id: id ?? this.id,
      metadataId: metadataId ?? this.metadataId,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      synonyms: synonyms ?? this.synonyms,
      antonyms: antonyms ?? this.antonyms,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (metadataId.present) {
      map['metadata_id'] = Variable<int>(metadataId.value);
    }
    if (partOfSpeech.present) {
      map['part_of_speech'] = Variable<String>(partOfSpeech.value);
    }
    if (synonyms.present) {
      map['synonyms'] = Variable<String>(
        $MeaningsTable.$convertersynonyms.toSql(synonyms.value),
      );
    }
    if (antonyms.present) {
      map['antonyms'] = Variable<String>(
        $MeaningsTable.$converterantonyms.toSql(antonyms.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MeaningsCompanion(')
          ..write('id: $id, ')
          ..write('metadataId: $metadataId, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('synonyms: $synonyms, ')
          ..write('antonyms: $antonyms')
          ..write(')'))
        .toString();
  }
}

class $DefinitionsTable extends Definitions
    with TableInfo<$DefinitionsTable, DriftDefinition> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DefinitionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _meaningIdMeta = const VerificationMeta(
    'meaningId',
  );
  @override
  late final GeneratedColumn<int> meaningId = GeneratedColumn<int>(
    'meaning_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES meanings (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exampleMeta = const VerificationMeta(
    'example',
  );
  @override
  late final GeneratedColumn<String> example = GeneratedColumn<String>(
    'example',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, meaningId, value, example];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'definitions';
  @override
  VerificationContext validateIntegrity(
    Insertable<DriftDefinition> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('meaning_id')) {
      context.handle(
        _meaningIdMeta,
        meaningId.isAcceptableOrUnknown(data['meaning_id']!, _meaningIdMeta),
      );
    } else if (isInserting) {
      context.missing(_meaningIdMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('example')) {
      context.handle(
        _exampleMeta,
        example.isAcceptableOrUnknown(data['example']!, _exampleMeta),
      );
    } else if (isInserting) {
      context.missing(_exampleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftDefinition map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftDefinition(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      meaningId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}meaning_id'],
          )!,
      value:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}value'],
          )!,
      example:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}example'],
          )!,
    );
  }

  @override
  $DefinitionsTable createAlias(String alias) {
    return $DefinitionsTable(attachedDatabase, alias);
  }
}

class DriftDefinition extends DataClass implements Insertable<DriftDefinition> {
  final int id;
  final int meaningId;
  final String value;
  final String example;
  const DriftDefinition({
    required this.id,
    required this.meaningId,
    required this.value,
    required this.example,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['meaning_id'] = Variable<int>(meaningId);
    map['value'] = Variable<String>(value);
    map['example'] = Variable<String>(example);
    return map;
  }

  DefinitionsCompanion toCompanion(bool nullToAbsent) {
    return DefinitionsCompanion(
      id: Value(id),
      meaningId: Value(meaningId),
      value: Value(value),
      example: Value(example),
    );
  }

  factory DriftDefinition.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftDefinition(
      id: serializer.fromJson<int>(json['id']),
      meaningId: serializer.fromJson<int>(json['meaningId']),
      value: serializer.fromJson<String>(json['value']),
      example: serializer.fromJson<String>(json['example']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'meaningId': serializer.toJson<int>(meaningId),
      'value': serializer.toJson<String>(value),
      'example': serializer.toJson<String>(example),
    };
  }

  DriftDefinition copyWith({
    int? id,
    int? meaningId,
    String? value,
    String? example,
  }) => DriftDefinition(
    id: id ?? this.id,
    meaningId: meaningId ?? this.meaningId,
    value: value ?? this.value,
    example: example ?? this.example,
  );
  DriftDefinition copyWithCompanion(DefinitionsCompanion data) {
    return DriftDefinition(
      id: data.id.present ? data.id.value : this.id,
      meaningId: data.meaningId.present ? data.meaningId.value : this.meaningId,
      value: data.value.present ? data.value.value : this.value,
      example: data.example.present ? data.example.value : this.example,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftDefinition(')
          ..write('id: $id, ')
          ..write('meaningId: $meaningId, ')
          ..write('value: $value, ')
          ..write('example: $example')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, meaningId, value, example);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftDefinition &&
          other.id == this.id &&
          other.meaningId == this.meaningId &&
          other.value == this.value &&
          other.example == this.example);
}

class DefinitionsCompanion extends UpdateCompanion<DriftDefinition> {
  final Value<int> id;
  final Value<int> meaningId;
  final Value<String> value;
  final Value<String> example;
  const DefinitionsCompanion({
    this.id = const Value.absent(),
    this.meaningId = const Value.absent(),
    this.value = const Value.absent(),
    this.example = const Value.absent(),
  });
  DefinitionsCompanion.insert({
    this.id = const Value.absent(),
    required int meaningId,
    required String value,
    required String example,
  }) : meaningId = Value(meaningId),
       value = Value(value),
       example = Value(example);
  static Insertable<DriftDefinition> custom({
    Expression<int>? id,
    Expression<int>? meaningId,
    Expression<String>? value,
    Expression<String>? example,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (meaningId != null) 'meaning_id': meaningId,
      if (value != null) 'value': value,
      if (example != null) 'example': example,
    });
  }

  DefinitionsCompanion copyWith({
    Value<int>? id,
    Value<int>? meaningId,
    Value<String>? value,
    Value<String>? example,
  }) {
    return DefinitionsCompanion(
      id: id ?? this.id,
      meaningId: meaningId ?? this.meaningId,
      value: value ?? this.value,
      example: example ?? this.example,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (meaningId.present) {
      map['meaning_id'] = Variable<int>(meaningId.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (example.present) {
      map['example'] = Variable<String>(example.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DefinitionsCompanion(')
          ..write('id: $id, ')
          ..write('meaningId: $meaningId, ')
          ..write('value: $value, ')
          ..write('example: $example')
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
  late final $WordStatisticsTable wordStatistics = $WordStatisticsTable(this);
  late final $WordMetadatasTable wordMetadatas = $WordMetadatasTable(this);
  late final $WordMetadataWebLookupsTable wordMetadataWebLookups =
      $WordMetadataWebLookupsTable(this);
  late final $PhoneticsTable phonetics = $PhoneticsTable(this);
  late final $MeaningsTable meanings = $MeaningsTable(this);
  late final $DefinitionsTable definitions = $DefinitionsTable(this);
  late final Index folderCreated = Index(
    'folder_created',
    'CREATE INDEX folder_created ON folders (created)',
  );
  late final Index folderName = Index(
    'folder_name',
    'CREATE INDEX folder_name ON folders (name)',
  );
  late final Index groupCreated = Index(
    'group_created',
    'CREATE INDEX group_created ON word_groups (created)',
  );
  late final Index groupName = Index(
    'group_name',
    'CREATE INDEX group_name ON word_groups (name)',
  );
  late final Index groupLanguageOriginCode = Index(
    'group_language_origin_code',
    'CREATE INDEX group_language_origin_code ON word_groups (language_origin_code)',
  );
  late final Index groupLanguageTranslationCode = Index(
    'group_language_translation_code',
    'CREATE INDEX group_language_translation_code ON word_groups (language_translation_code)',
  );
  late final Index groupLanguageOriginTranslationCode = Index(
    'group_language_origin_translation_code',
    'CREATE INDEX group_language_origin_translation_code ON word_groups (language_origin_code, language_translation_code)',
  );
  late final Index wordCreated = Index(
    'word_created',
    'CREATE INDEX word_created ON words (created)',
  );
  late final Index indexWord = Index(
    'index_word',
    'CREATE INDEX index_word ON word_statistics (word)',
  );
  late final Index indexCorrect = Index(
    'index_correct',
    'CREATE INDEX index_correct ON word_statistics (correct)',
  );
  late final Index indexIncorrect = Index(
    'index_incorrect',
    'CREATE INDEX index_incorrect ON word_statistics (incorrect)',
  );
  late final Index indexWordCorrectIncorrect = Index(
    'index_word_correct_incorrect',
    'CREATE INDEX index_word_correct_incorrect ON word_statistics (word, correct, incorrect)',
  );
  late final Index metadataWordIndex = Index(
    'metadata_word_index',
    'CREATE INDEX metadata_word_index ON word_metadatas (word)',
  );
  late final Index webLookupsWord = Index(
    'web_lookups_word',
    'CREATE INDEX web_lookups_word ON word_metadata_web_lookups (word)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    folders,
    wordGroups,
    words,
    wordStatistics,
    wordMetadatas,
    wordMetadataWebLookups,
    phonetics,
    meanings,
    definitions,
    folderCreated,
    folderName,
    groupCreated,
    groupName,
    groupLanguageOriginCode,
    groupLanguageTranslationCode,
    groupLanguageOriginTranslationCode,
    wordCreated,
    indexWord,
    indexCorrect,
    indexIncorrect,
    indexWordCorrectIncorrect,
    metadataWordIndex,
    webLookupsWord,
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
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'word_metadatas',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('phonetics', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'word_metadatas',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('meanings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'meanings',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('definitions', kind: UpdateKind.delete)],
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
      required String languageOriginCode,
      required String languageOriginName,
      required String languageOriginNative,
      required String languageTranslationCode,
      required String languageTranslationName,
      required String languageTranslationNative,
    });
typedef $$WordGroupsTableUpdateCompanionBuilder =
    WordGroupsCompanion Function({
      Value<int> id,
      Value<int?> folderId,
      Value<DateTime> created,
      Value<DateTime> modified,
      Value<String> name,
      Value<String> languageOriginCode,
      Value<String> languageOriginName,
      Value<String> languageOriginNative,
      Value<String> languageTranslationCode,
      Value<String> languageTranslationName,
      Value<String> languageTranslationNative,
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

  ColumnFilters<String> get languageOriginCode => $composableBuilder(
    column: $table.languageOriginCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get languageOriginName => $composableBuilder(
    column: $table.languageOriginName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get languageOriginNative => $composableBuilder(
    column: $table.languageOriginNative,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get languageTranslationCode => $composableBuilder(
    column: $table.languageTranslationCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get languageTranslationName => $composableBuilder(
    column: $table.languageTranslationName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get languageTranslationNative => $composableBuilder(
    column: $table.languageTranslationNative,
    builder: (column) => ColumnFilters(column),
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

  ColumnOrderings<String> get languageOriginCode => $composableBuilder(
    column: $table.languageOriginCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get languageOriginName => $composableBuilder(
    column: $table.languageOriginName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get languageOriginNative => $composableBuilder(
    column: $table.languageOriginNative,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get languageTranslationCode => $composableBuilder(
    column: $table.languageTranslationCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get languageTranslationName => $composableBuilder(
    column: $table.languageTranslationName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get languageTranslationNative => $composableBuilder(
    column: $table.languageTranslationNative,
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

  GeneratedColumn<String> get languageOriginCode => $composableBuilder(
    column: $table.languageOriginCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get languageOriginName => $composableBuilder(
    column: $table.languageOriginName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get languageOriginNative => $composableBuilder(
    column: $table.languageOriginNative,
    builder: (column) => column,
  );

  GeneratedColumn<String> get languageTranslationCode => $composableBuilder(
    column: $table.languageTranslationCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get languageTranslationName => $composableBuilder(
    column: $table.languageTranslationName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get languageTranslationNative => $composableBuilder(
    column: $table.languageTranslationNative,
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
                Value<String> languageOriginCode = const Value.absent(),
                Value<String> languageOriginName = const Value.absent(),
                Value<String> languageOriginNative = const Value.absent(),
                Value<String> languageTranslationCode = const Value.absent(),
                Value<String> languageTranslationName = const Value.absent(),
                Value<String> languageTranslationNative = const Value.absent(),
              }) => WordGroupsCompanion(
                id: id,
                folderId: folderId,
                created: created,
                modified: modified,
                name: name,
                languageOriginCode: languageOriginCode,
                languageOriginName: languageOriginName,
                languageOriginNative: languageOriginNative,
                languageTranslationCode: languageTranslationCode,
                languageTranslationName: languageTranslationName,
                languageTranslationNative: languageTranslationNative,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> folderId = const Value.absent(),
                required DateTime created,
                required DateTime modified,
                required String name,
                required String languageOriginCode,
                required String languageOriginName,
                required String languageOriginNative,
                required String languageTranslationCode,
                required String languageTranslationName,
                required String languageTranslationNative,
              }) => WordGroupsCompanion.insert(
                id: id,
                folderId: folderId,
                created: created,
                modified: modified,
                name: name,
                languageOriginCode: languageOriginCode,
                languageOriginName: languageOriginName,
                languageOriginNative: languageOriginNative,
                languageTranslationCode: languageTranslationCode,
                languageTranslationName: languageTranslationName,
                languageTranslationNative: languageTranslationNative,
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
typedef $$WordStatisticsTableCreateCompanionBuilder =
    WordStatisticsCompanion Function({
      required String word,
      required int correct,
      required int incorrect,
      Value<int> rowid,
    });
typedef $$WordStatisticsTableUpdateCompanionBuilder =
    WordStatisticsCompanion Function({
      Value<String> word,
      Value<int> correct,
      Value<int> incorrect,
      Value<int> rowid,
    });

class $$WordStatisticsTableFilterComposer
    extends Composer<_$AppDriftDatabase, $WordStatisticsTable> {
  $$WordStatisticsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correct => $composableBuilder(
    column: $table.correct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get incorrect => $composableBuilder(
    column: $table.incorrect,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WordStatisticsTableOrderingComposer
    extends Composer<_$AppDriftDatabase, $WordStatisticsTable> {
  $$WordStatisticsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correct => $composableBuilder(
    column: $table.correct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get incorrect => $composableBuilder(
    column: $table.incorrect,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WordStatisticsTableAnnotationComposer
    extends Composer<_$AppDriftDatabase, $WordStatisticsTable> {
  $$WordStatisticsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get word =>
      $composableBuilder(column: $table.word, builder: (column) => column);

  GeneratedColumn<int> get correct =>
      $composableBuilder(column: $table.correct, builder: (column) => column);

  GeneratedColumn<int> get incorrect =>
      $composableBuilder(column: $table.incorrect, builder: (column) => column);
}

class $$WordStatisticsTableTableManager
    extends
        RootTableManager<
          _$AppDriftDatabase,
          $WordStatisticsTable,
          DriftWordAnswerStats,
          $$WordStatisticsTableFilterComposer,
          $$WordStatisticsTableOrderingComposer,
          $$WordStatisticsTableAnnotationComposer,
          $$WordStatisticsTableCreateCompanionBuilder,
          $$WordStatisticsTableUpdateCompanionBuilder,
          (
            DriftWordAnswerStats,
            BaseReferences<
              _$AppDriftDatabase,
              $WordStatisticsTable,
              DriftWordAnswerStats
            >,
          ),
          DriftWordAnswerStats,
          PrefetchHooks Function()
        > {
  $$WordStatisticsTableTableManager(
    _$AppDriftDatabase db,
    $WordStatisticsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$WordStatisticsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$WordStatisticsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$WordStatisticsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> word = const Value.absent(),
                Value<int> correct = const Value.absent(),
                Value<int> incorrect = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WordStatisticsCompanion(
                word: word,
                correct: correct,
                incorrect: incorrect,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String word,
                required int correct,
                required int incorrect,
                Value<int> rowid = const Value.absent(),
              }) => WordStatisticsCompanion.insert(
                word: word,
                correct: correct,
                incorrect: incorrect,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WordStatisticsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDriftDatabase,
      $WordStatisticsTable,
      DriftWordAnswerStats,
      $$WordStatisticsTableFilterComposer,
      $$WordStatisticsTableOrderingComposer,
      $$WordStatisticsTableAnnotationComposer,
      $$WordStatisticsTableCreateCompanionBuilder,
      $$WordStatisticsTableUpdateCompanionBuilder,
      (
        DriftWordAnswerStats,
        BaseReferences<
          _$AppDriftDatabase,
          $WordStatisticsTable,
          DriftWordAnswerStats
        >,
      ),
      DriftWordAnswerStats,
      PrefetchHooks Function()
    >;
typedef $$WordMetadatasTableCreateCompanionBuilder =
    WordMetadatasCompanion Function({
      Value<int> id,
      required String word,
      required String etymology,
    });
typedef $$WordMetadatasTableUpdateCompanionBuilder =
    WordMetadatasCompanion Function({
      Value<int> id,
      Value<String> word,
      Value<String> etymology,
    });

final class $$WordMetadatasTableReferences
    extends
        BaseReferences<
          _$AppDriftDatabase,
          $WordMetadatasTable,
          DriftWordMetadata
        > {
  $$WordMetadatasTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$PhoneticsTable, List<DriftPhonetic>>
  _phoneticsRefsTable(_$AppDriftDatabase db) => MultiTypedResultKey.fromTable(
    db.phonetics,
    aliasName: $_aliasNameGenerator(
      db.wordMetadatas.id,
      db.phonetics.metadataId,
    ),
  );

  $$PhoneticsTableProcessedTableManager get phoneticsRefs {
    final manager = $$PhoneticsTableTableManager(
      $_db,
      $_db.phonetics,
    ).filter((f) => f.metadataId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_phoneticsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MeaningsTable, List<DriftMeaning>>
  _meaningsRefsTable(_$AppDriftDatabase db) => MultiTypedResultKey.fromTable(
    db.meanings,
    aliasName: $_aliasNameGenerator(
      db.wordMetadatas.id,
      db.meanings.metadataId,
    ),
  );

  $$MeaningsTableProcessedTableManager get meaningsRefs {
    final manager = $$MeaningsTableTableManager(
      $_db,
      $_db.meanings,
    ).filter((f) => f.metadataId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_meaningsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WordMetadatasTableFilterComposer
    extends Composer<_$AppDriftDatabase, $WordMetadatasTable> {
  $$WordMetadatasTableFilterComposer({
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

  ColumnFilters<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get etymology => $composableBuilder(
    column: $table.etymology,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> phoneticsRefs(
    Expression<bool> Function($$PhoneticsTableFilterComposer f) f,
  ) {
    final $$PhoneticsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.phonetics,
      getReferencedColumn: (t) => t.metadataId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhoneticsTableFilterComposer(
            $db: $db,
            $table: $db.phonetics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> meaningsRefs(
    Expression<bool> Function($$MeaningsTableFilterComposer f) f,
  ) {
    final $$MeaningsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.meanings,
      getReferencedColumn: (t) => t.metadataId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeaningsTableFilterComposer(
            $db: $db,
            $table: $db.meanings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WordMetadatasTableOrderingComposer
    extends Composer<_$AppDriftDatabase, $WordMetadatasTable> {
  $$WordMetadatasTableOrderingComposer({
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

  ColumnOrderings<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get etymology => $composableBuilder(
    column: $table.etymology,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WordMetadatasTableAnnotationComposer
    extends Composer<_$AppDriftDatabase, $WordMetadatasTable> {
  $$WordMetadatasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get word =>
      $composableBuilder(column: $table.word, builder: (column) => column);

  GeneratedColumn<String> get etymology =>
      $composableBuilder(column: $table.etymology, builder: (column) => column);

  Expression<T> phoneticsRefs<T extends Object>(
    Expression<T> Function($$PhoneticsTableAnnotationComposer a) f,
  ) {
    final $$PhoneticsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.phonetics,
      getReferencedColumn: (t) => t.metadataId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhoneticsTableAnnotationComposer(
            $db: $db,
            $table: $db.phonetics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> meaningsRefs<T extends Object>(
    Expression<T> Function($$MeaningsTableAnnotationComposer a) f,
  ) {
    final $$MeaningsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.meanings,
      getReferencedColumn: (t) => t.metadataId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeaningsTableAnnotationComposer(
            $db: $db,
            $table: $db.meanings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WordMetadatasTableTableManager
    extends
        RootTableManager<
          _$AppDriftDatabase,
          $WordMetadatasTable,
          DriftWordMetadata,
          $$WordMetadatasTableFilterComposer,
          $$WordMetadatasTableOrderingComposer,
          $$WordMetadatasTableAnnotationComposer,
          $$WordMetadatasTableCreateCompanionBuilder,
          $$WordMetadatasTableUpdateCompanionBuilder,
          (DriftWordMetadata, $$WordMetadatasTableReferences),
          DriftWordMetadata,
          PrefetchHooks Function({bool phoneticsRefs, bool meaningsRefs})
        > {
  $$WordMetadatasTableTableManager(
    _$AppDriftDatabase db,
    $WordMetadatasTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$WordMetadatasTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$WordMetadatasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$WordMetadatasTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> word = const Value.absent(),
                Value<String> etymology = const Value.absent(),
              }) => WordMetadatasCompanion(
                id: id,
                word: word,
                etymology: etymology,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String word,
                required String etymology,
              }) => WordMetadatasCompanion.insert(
                id: id,
                word: word,
                etymology: etymology,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$WordMetadatasTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            phoneticsRefs = false,
            meaningsRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (phoneticsRefs) db.phonetics,
                if (meaningsRefs) db.meanings,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (phoneticsRefs)
                    await $_getPrefetchedData<
                      DriftWordMetadata,
                      $WordMetadatasTable,
                      DriftPhonetic
                    >(
                      currentTable: table,
                      referencedTable: $$WordMetadatasTableReferences
                          ._phoneticsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$WordMetadatasTableReferences(
                                db,
                                table,
                                p0,
                              ).phoneticsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.metadataId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (meaningsRefs)
                    await $_getPrefetchedData<
                      DriftWordMetadata,
                      $WordMetadatasTable,
                      DriftMeaning
                    >(
                      currentTable: table,
                      referencedTable: $$WordMetadatasTableReferences
                          ._meaningsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$WordMetadatasTableReferences(
                                db,
                                table,
                                p0,
                              ).meaningsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.metadataId == item.id,
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

typedef $$WordMetadatasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDriftDatabase,
      $WordMetadatasTable,
      DriftWordMetadata,
      $$WordMetadatasTableFilterComposer,
      $$WordMetadatasTableOrderingComposer,
      $$WordMetadatasTableAnnotationComposer,
      $$WordMetadatasTableCreateCompanionBuilder,
      $$WordMetadatasTableUpdateCompanionBuilder,
      (DriftWordMetadata, $$WordMetadatasTableReferences),
      DriftWordMetadata,
      PrefetchHooks Function({bool phoneticsRefs, bool meaningsRefs})
    >;
typedef $$WordMetadataWebLookupsTableCreateCompanionBuilder =
    WordMetadataWebLookupsCompanion Function({
      required String word,
      required DateTime firstAttemp,
      required DateTime lastAttemp,
      required int attemps,
      Value<int> rowid,
    });
typedef $$WordMetadataWebLookupsTableUpdateCompanionBuilder =
    WordMetadataWebLookupsCompanion Function({
      Value<String> word,
      Value<DateTime> firstAttemp,
      Value<DateTime> lastAttemp,
      Value<int> attemps,
      Value<int> rowid,
    });

class $$WordMetadataWebLookupsTableFilterComposer
    extends Composer<_$AppDriftDatabase, $WordMetadataWebLookupsTable> {
  $$WordMetadataWebLookupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get firstAttemp => $composableBuilder(
    column: $table.firstAttemp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAttemp => $composableBuilder(
    column: $table.lastAttemp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attemps => $composableBuilder(
    column: $table.attemps,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WordMetadataWebLookupsTableOrderingComposer
    extends Composer<_$AppDriftDatabase, $WordMetadataWebLookupsTable> {
  $$WordMetadataWebLookupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get firstAttemp => $composableBuilder(
    column: $table.firstAttemp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAttemp => $composableBuilder(
    column: $table.lastAttemp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attemps => $composableBuilder(
    column: $table.attemps,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WordMetadataWebLookupsTableAnnotationComposer
    extends Composer<_$AppDriftDatabase, $WordMetadataWebLookupsTable> {
  $$WordMetadataWebLookupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get word =>
      $composableBuilder(column: $table.word, builder: (column) => column);

  GeneratedColumn<DateTime> get firstAttemp => $composableBuilder(
    column: $table.firstAttemp,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastAttemp => $composableBuilder(
    column: $table.lastAttemp,
    builder: (column) => column,
  );

  GeneratedColumn<int> get attemps =>
      $composableBuilder(column: $table.attemps, builder: (column) => column);
}

class $$WordMetadataWebLookupsTableTableManager
    extends
        RootTableManager<
          _$AppDriftDatabase,
          $WordMetadataWebLookupsTable,
          DriftWordMetadataWebLookup,
          $$WordMetadataWebLookupsTableFilterComposer,
          $$WordMetadataWebLookupsTableOrderingComposer,
          $$WordMetadataWebLookupsTableAnnotationComposer,
          $$WordMetadataWebLookupsTableCreateCompanionBuilder,
          $$WordMetadataWebLookupsTableUpdateCompanionBuilder,
          (
            DriftWordMetadataWebLookup,
            BaseReferences<
              _$AppDriftDatabase,
              $WordMetadataWebLookupsTable,
              DriftWordMetadataWebLookup
            >,
          ),
          DriftWordMetadataWebLookup,
          PrefetchHooks Function()
        > {
  $$WordMetadataWebLookupsTableTableManager(
    _$AppDriftDatabase db,
    $WordMetadataWebLookupsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$WordMetadataWebLookupsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$WordMetadataWebLookupsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$WordMetadataWebLookupsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> word = const Value.absent(),
                Value<DateTime> firstAttemp = const Value.absent(),
                Value<DateTime> lastAttemp = const Value.absent(),
                Value<int> attemps = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WordMetadataWebLookupsCompanion(
                word: word,
                firstAttemp: firstAttemp,
                lastAttemp: lastAttemp,
                attemps: attemps,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String word,
                required DateTime firstAttemp,
                required DateTime lastAttemp,
                required int attemps,
                Value<int> rowid = const Value.absent(),
              }) => WordMetadataWebLookupsCompanion.insert(
                word: word,
                firstAttemp: firstAttemp,
                lastAttemp: lastAttemp,
                attemps: attemps,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WordMetadataWebLookupsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDriftDatabase,
      $WordMetadataWebLookupsTable,
      DriftWordMetadataWebLookup,
      $$WordMetadataWebLookupsTableFilterComposer,
      $$WordMetadataWebLookupsTableOrderingComposer,
      $$WordMetadataWebLookupsTableAnnotationComposer,
      $$WordMetadataWebLookupsTableCreateCompanionBuilder,
      $$WordMetadataWebLookupsTableUpdateCompanionBuilder,
      (
        DriftWordMetadataWebLookup,
        BaseReferences<
          _$AppDriftDatabase,
          $WordMetadataWebLookupsTable,
          DriftWordMetadataWebLookup
        >,
      ),
      DriftWordMetadataWebLookup,
      PrefetchHooks Function()
    >;
typedef $$PhoneticsTableCreateCompanionBuilder =
    PhoneticsCompanion Function({
      Value<int> id,
      required int metadataId,
      required String value,
      required String audio,
    });
typedef $$PhoneticsTableUpdateCompanionBuilder =
    PhoneticsCompanion Function({
      Value<int> id,
      Value<int> metadataId,
      Value<String> value,
      Value<String> audio,
    });

final class $$PhoneticsTableReferences
    extends BaseReferences<_$AppDriftDatabase, $PhoneticsTable, DriftPhonetic> {
  $$PhoneticsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WordMetadatasTable _metadataIdTable(_$AppDriftDatabase db) =>
      db.wordMetadatas.createAlias(
        $_aliasNameGenerator(db.phonetics.metadataId, db.wordMetadatas.id),
      );

  $$WordMetadatasTableProcessedTableManager get metadataId {
    final $_column = $_itemColumn<int>('metadata_id')!;

    final manager = $$WordMetadatasTableTableManager(
      $_db,
      $_db.wordMetadatas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_metadataIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PhoneticsTableFilterComposer
    extends Composer<_$AppDriftDatabase, $PhoneticsTable> {
  $$PhoneticsTableFilterComposer({
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

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audio => $composableBuilder(
    column: $table.audio,
    builder: (column) => ColumnFilters(column),
  );

  $$WordMetadatasTableFilterComposer get metadataId {
    final $$WordMetadatasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.metadataId,
      referencedTable: $db.wordMetadatas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordMetadatasTableFilterComposer(
            $db: $db,
            $table: $db.wordMetadatas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhoneticsTableOrderingComposer
    extends Composer<_$AppDriftDatabase, $PhoneticsTable> {
  $$PhoneticsTableOrderingComposer({
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

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audio => $composableBuilder(
    column: $table.audio,
    builder: (column) => ColumnOrderings(column),
  );

  $$WordMetadatasTableOrderingComposer get metadataId {
    final $$WordMetadatasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.metadataId,
      referencedTable: $db.wordMetadatas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordMetadatasTableOrderingComposer(
            $db: $db,
            $table: $db.wordMetadatas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhoneticsTableAnnotationComposer
    extends Composer<_$AppDriftDatabase, $PhoneticsTable> {
  $$PhoneticsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get audio =>
      $composableBuilder(column: $table.audio, builder: (column) => column);

  $$WordMetadatasTableAnnotationComposer get metadataId {
    final $$WordMetadatasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.metadataId,
      referencedTable: $db.wordMetadatas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordMetadatasTableAnnotationComposer(
            $db: $db,
            $table: $db.wordMetadatas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhoneticsTableTableManager
    extends
        RootTableManager<
          _$AppDriftDatabase,
          $PhoneticsTable,
          DriftPhonetic,
          $$PhoneticsTableFilterComposer,
          $$PhoneticsTableOrderingComposer,
          $$PhoneticsTableAnnotationComposer,
          $$PhoneticsTableCreateCompanionBuilder,
          $$PhoneticsTableUpdateCompanionBuilder,
          (DriftPhonetic, $$PhoneticsTableReferences),
          DriftPhonetic,
          PrefetchHooks Function({bool metadataId})
        > {
  $$PhoneticsTableTableManager(_$AppDriftDatabase db, $PhoneticsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$PhoneticsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$PhoneticsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$PhoneticsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> metadataId = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<String> audio = const Value.absent(),
              }) => PhoneticsCompanion(
                id: id,
                metadataId: metadataId,
                value: value,
                audio: audio,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int metadataId,
                required String value,
                required String audio,
              }) => PhoneticsCompanion.insert(
                id: id,
                metadataId: metadataId,
                value: value,
                audio: audio,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$PhoneticsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({metadataId = false}) {
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
                if (metadataId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.metadataId,
                            referencedTable: $$PhoneticsTableReferences
                                ._metadataIdTable(db),
                            referencedColumn:
                                $$PhoneticsTableReferences
                                    ._metadataIdTable(db)
                                    .id,
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

typedef $$PhoneticsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDriftDatabase,
      $PhoneticsTable,
      DriftPhonetic,
      $$PhoneticsTableFilterComposer,
      $$PhoneticsTableOrderingComposer,
      $$PhoneticsTableAnnotationComposer,
      $$PhoneticsTableCreateCompanionBuilder,
      $$PhoneticsTableUpdateCompanionBuilder,
      (DriftPhonetic, $$PhoneticsTableReferences),
      DriftPhonetic,
      PrefetchHooks Function({bool metadataId})
    >;
typedef $$MeaningsTableCreateCompanionBuilder =
    MeaningsCompanion Function({
      Value<int> id,
      required int metadataId,
      required String partOfSpeech,
      required List<String> synonyms,
      required List<String> antonyms,
    });
typedef $$MeaningsTableUpdateCompanionBuilder =
    MeaningsCompanion Function({
      Value<int> id,
      Value<int> metadataId,
      Value<String> partOfSpeech,
      Value<List<String>> synonyms,
      Value<List<String>> antonyms,
    });

final class $$MeaningsTableReferences
    extends BaseReferences<_$AppDriftDatabase, $MeaningsTable, DriftMeaning> {
  $$MeaningsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WordMetadatasTable _metadataIdTable(_$AppDriftDatabase db) =>
      db.wordMetadatas.createAlias(
        $_aliasNameGenerator(db.meanings.metadataId, db.wordMetadatas.id),
      );

  $$WordMetadatasTableProcessedTableManager get metadataId {
    final $_column = $_itemColumn<int>('metadata_id')!;

    final manager = $$WordMetadatasTableTableManager(
      $_db,
      $_db.wordMetadatas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_metadataIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$DefinitionsTable, List<DriftDefinition>>
  _definitionsRefsTable(_$AppDriftDatabase db) => MultiTypedResultKey.fromTable(
    db.definitions,
    aliasName: $_aliasNameGenerator(db.meanings.id, db.definitions.meaningId),
  );

  $$DefinitionsTableProcessedTableManager get definitionsRefs {
    final manager = $$DefinitionsTableTableManager(
      $_db,
      $_db.definitions,
    ).filter((f) => f.meaningId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_definitionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MeaningsTableFilterComposer
    extends Composer<_$AppDriftDatabase, $MeaningsTable> {
  $$MeaningsTableFilterComposer({
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

  ColumnFilters<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get synonyms => $composableBuilder(
    column: $table.synonyms,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get antonyms => $composableBuilder(
    column: $table.antonyms,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$WordMetadatasTableFilterComposer get metadataId {
    final $$WordMetadatasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.metadataId,
      referencedTable: $db.wordMetadatas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordMetadatasTableFilterComposer(
            $db: $db,
            $table: $db.wordMetadatas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> definitionsRefs(
    Expression<bool> Function($$DefinitionsTableFilterComposer f) f,
  ) {
    final $$DefinitionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.definitions,
      getReferencedColumn: (t) => t.meaningId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DefinitionsTableFilterComposer(
            $db: $db,
            $table: $db.definitions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MeaningsTableOrderingComposer
    extends Composer<_$AppDriftDatabase, $MeaningsTable> {
  $$MeaningsTableOrderingComposer({
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

  ColumnOrderings<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get synonyms => $composableBuilder(
    column: $table.synonyms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get antonyms => $composableBuilder(
    column: $table.antonyms,
    builder: (column) => ColumnOrderings(column),
  );

  $$WordMetadatasTableOrderingComposer get metadataId {
    final $$WordMetadatasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.metadataId,
      referencedTable: $db.wordMetadatas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordMetadatasTableOrderingComposer(
            $db: $db,
            $table: $db.wordMetadatas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MeaningsTableAnnotationComposer
    extends Composer<_$AppDriftDatabase, $MeaningsTable> {
  $$MeaningsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<String>, String> get synonyms =>
      $composableBuilder(column: $table.synonyms, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get antonyms =>
      $composableBuilder(column: $table.antonyms, builder: (column) => column);

  $$WordMetadatasTableAnnotationComposer get metadataId {
    final $$WordMetadatasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.metadataId,
      referencedTable: $db.wordMetadatas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordMetadatasTableAnnotationComposer(
            $db: $db,
            $table: $db.wordMetadatas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> definitionsRefs<T extends Object>(
    Expression<T> Function($$DefinitionsTableAnnotationComposer a) f,
  ) {
    final $$DefinitionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.definitions,
      getReferencedColumn: (t) => t.meaningId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DefinitionsTableAnnotationComposer(
            $db: $db,
            $table: $db.definitions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MeaningsTableTableManager
    extends
        RootTableManager<
          _$AppDriftDatabase,
          $MeaningsTable,
          DriftMeaning,
          $$MeaningsTableFilterComposer,
          $$MeaningsTableOrderingComposer,
          $$MeaningsTableAnnotationComposer,
          $$MeaningsTableCreateCompanionBuilder,
          $$MeaningsTableUpdateCompanionBuilder,
          (DriftMeaning, $$MeaningsTableReferences),
          DriftMeaning,
          PrefetchHooks Function({bool metadataId, bool definitionsRefs})
        > {
  $$MeaningsTableTableManager(_$AppDriftDatabase db, $MeaningsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$MeaningsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$MeaningsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$MeaningsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> metadataId = const Value.absent(),
                Value<String> partOfSpeech = const Value.absent(),
                Value<List<String>> synonyms = const Value.absent(),
                Value<List<String>> antonyms = const Value.absent(),
              }) => MeaningsCompanion(
                id: id,
                metadataId: metadataId,
                partOfSpeech: partOfSpeech,
                synonyms: synonyms,
                antonyms: antonyms,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int metadataId,
                required String partOfSpeech,
                required List<String> synonyms,
                required List<String> antonyms,
              }) => MeaningsCompanion.insert(
                id: id,
                metadataId: metadataId,
                partOfSpeech: partOfSpeech,
                synonyms: synonyms,
                antonyms: antonyms,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$MeaningsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            metadataId = false,
            definitionsRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (definitionsRefs) db.definitions],
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
                if (metadataId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.metadataId,
                            referencedTable: $$MeaningsTableReferences
                                ._metadataIdTable(db),
                            referencedColumn:
                                $$MeaningsTableReferences
                                    ._metadataIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (definitionsRefs)
                    await $_getPrefetchedData<
                      DriftMeaning,
                      $MeaningsTable,
                      DriftDefinition
                    >(
                      currentTable: table,
                      referencedTable: $$MeaningsTableReferences
                          ._definitionsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$MeaningsTableReferences(
                                db,
                                table,
                                p0,
                              ).definitionsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.meaningId == item.id,
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

typedef $$MeaningsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDriftDatabase,
      $MeaningsTable,
      DriftMeaning,
      $$MeaningsTableFilterComposer,
      $$MeaningsTableOrderingComposer,
      $$MeaningsTableAnnotationComposer,
      $$MeaningsTableCreateCompanionBuilder,
      $$MeaningsTableUpdateCompanionBuilder,
      (DriftMeaning, $$MeaningsTableReferences),
      DriftMeaning,
      PrefetchHooks Function({bool metadataId, bool definitionsRefs})
    >;
typedef $$DefinitionsTableCreateCompanionBuilder =
    DefinitionsCompanion Function({
      Value<int> id,
      required int meaningId,
      required String value,
      required String example,
    });
typedef $$DefinitionsTableUpdateCompanionBuilder =
    DefinitionsCompanion Function({
      Value<int> id,
      Value<int> meaningId,
      Value<String> value,
      Value<String> example,
    });

final class $$DefinitionsTableReferences
    extends
        BaseReferences<_$AppDriftDatabase, $DefinitionsTable, DriftDefinition> {
  $$DefinitionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MeaningsTable _meaningIdTable(_$AppDriftDatabase db) =>
      db.meanings.createAlias(
        $_aliasNameGenerator(db.definitions.meaningId, db.meanings.id),
      );

  $$MeaningsTableProcessedTableManager get meaningId {
    final $_column = $_itemColumn<int>('meaning_id')!;

    final manager = $$MeaningsTableTableManager(
      $_db,
      $_db.meanings,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_meaningIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DefinitionsTableFilterComposer
    extends Composer<_$AppDriftDatabase, $DefinitionsTable> {
  $$DefinitionsTableFilterComposer({
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

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get example => $composableBuilder(
    column: $table.example,
    builder: (column) => ColumnFilters(column),
  );

  $$MeaningsTableFilterComposer get meaningId {
    final $$MeaningsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.meaningId,
      referencedTable: $db.meanings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeaningsTableFilterComposer(
            $db: $db,
            $table: $db.meanings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DefinitionsTableOrderingComposer
    extends Composer<_$AppDriftDatabase, $DefinitionsTable> {
  $$DefinitionsTableOrderingComposer({
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

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get example => $composableBuilder(
    column: $table.example,
    builder: (column) => ColumnOrderings(column),
  );

  $$MeaningsTableOrderingComposer get meaningId {
    final $$MeaningsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.meaningId,
      referencedTable: $db.meanings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeaningsTableOrderingComposer(
            $db: $db,
            $table: $db.meanings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DefinitionsTableAnnotationComposer
    extends Composer<_$AppDriftDatabase, $DefinitionsTable> {
  $$DefinitionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get example =>
      $composableBuilder(column: $table.example, builder: (column) => column);

  $$MeaningsTableAnnotationComposer get meaningId {
    final $$MeaningsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.meaningId,
      referencedTable: $db.meanings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MeaningsTableAnnotationComposer(
            $db: $db,
            $table: $db.meanings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DefinitionsTableTableManager
    extends
        RootTableManager<
          _$AppDriftDatabase,
          $DefinitionsTable,
          DriftDefinition,
          $$DefinitionsTableFilterComposer,
          $$DefinitionsTableOrderingComposer,
          $$DefinitionsTableAnnotationComposer,
          $$DefinitionsTableCreateCompanionBuilder,
          $$DefinitionsTableUpdateCompanionBuilder,
          (DriftDefinition, $$DefinitionsTableReferences),
          DriftDefinition,
          PrefetchHooks Function({bool meaningId})
        > {
  $$DefinitionsTableTableManager(_$AppDriftDatabase db, $DefinitionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$DefinitionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$DefinitionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$DefinitionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> meaningId = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<String> example = const Value.absent(),
              }) => DefinitionsCompanion(
                id: id,
                meaningId: meaningId,
                value: value,
                example: example,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int meaningId,
                required String value,
                required String example,
              }) => DefinitionsCompanion.insert(
                id: id,
                meaningId: meaningId,
                value: value,
                example: example,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$DefinitionsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({meaningId = false}) {
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
                if (meaningId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.meaningId,
                            referencedTable: $$DefinitionsTableReferences
                                ._meaningIdTable(db),
                            referencedColumn:
                                $$DefinitionsTableReferences
                                    ._meaningIdTable(db)
                                    .id,
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

typedef $$DefinitionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDriftDatabase,
      $DefinitionsTable,
      DriftDefinition,
      $$DefinitionsTableFilterComposer,
      $$DefinitionsTableOrderingComposer,
      $$DefinitionsTableAnnotationComposer,
      $$DefinitionsTableCreateCompanionBuilder,
      $$DefinitionsTableUpdateCompanionBuilder,
      (DriftDefinition, $$DefinitionsTableReferences),
      DriftDefinition,
      PrefetchHooks Function({bool meaningId})
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
  $$WordStatisticsTableTableManager get wordStatistics =>
      $$WordStatisticsTableTableManager(_db, _db.wordStatistics);
  $$WordMetadatasTableTableManager get wordMetadatas =>
      $$WordMetadatasTableTableManager(_db, _db.wordMetadatas);
  $$WordMetadataWebLookupsTableTableManager get wordMetadataWebLookups =>
      $$WordMetadataWebLookupsTableTableManager(
        _db,
        _db.wordMetadataWebLookups,
      );
  $$PhoneticsTableTableManager get phonetics =>
      $$PhoneticsTableTableManager(_db, _db.phonetics);
  $$MeaningsTableTableManager get meanings =>
      $$MeaningsTableTableManager(_db, _db.meanings);
  $$DefinitionsTableTableManager get definitions =>
      $$DefinitionsTableTableManager(_db, _db.definitions);
}
