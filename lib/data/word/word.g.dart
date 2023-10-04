// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Word _$WordFromJson(Map<String, dynamic> json) => Word(
      origin: json['origin'] as String,
      translation: json['translation'] as String,
      index: json['index'] as int,
    );

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
      'origin': instance.origin,
      'translation': instance.translation,
      'index': instance.index,
    };
