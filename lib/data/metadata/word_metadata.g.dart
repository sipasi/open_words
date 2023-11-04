// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordMetadata _$WordMetadataFromJson(Map<String, dynamic> json) => WordMetadata(
      id: json['id'] as String?,
      word: json['word'] as String,
      phonetics: (json['phonetics'] as List<dynamic>)
          .map((e) => Phonetic.fromJson(e as Map<String, dynamic>))
          .toList(),
      meanings: (json['meanings'] as List<dynamic>)
          .map((e) => Meaning.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WordMetadataToJson(WordMetadata instance) =>
    <String, dynamic>{
      'id': instance.id,
      'word': instance.word,
      'phonetics': instance.phonetics.map((e) => e.toJson()).toList(),
      'meanings': instance.meanings.map((e) => e.toJson()).toList(),
    };
