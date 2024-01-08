// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordGroup _$WordGroupFromJson(Map<String, dynamic> json) => WordGroup(
      id: json['id'] as String,
      created: DateTime.parse(json['created'] as String),
      modified: DateTime.parse(json['modified'] as String),
      name: json['name'] as String,
      origin: LanguageInfo.fromJson(json['origin'] as Map<String, dynamic>),
      translation:
          LanguageInfo.fromJson(json['translation'] as Map<String, dynamic>),
      words: (json['words'] as List<dynamic>)
          .map((e) => Word.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WordGroupToJson(WordGroup instance) => <String, dynamic>{
      'id': instance.id,
      'created': instance.created.toIso8601String(),
      'modified': instance.modified.toIso8601String(),
      'name': instance.name,
      'origin': instance.origin.toJson(),
      'translation': instance.translation.toJson(),
      'words': instance.words.map((e) => e.toJson()).toList(),
    };
