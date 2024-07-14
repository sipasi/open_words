import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:open_words/data/metadata/definition.dart';
import 'package:open_words/data/metadata/meaning.dart';
import 'package:open_words/data/metadata/phonetic.dart';
import 'package:open_words/data/metadata/word_metadata.dart';
import 'package:open_words/service/metadata/word_metadata_web_api.dart';

class DevDictionaryApi extends WordMetadataWebApi {
  final logger = GetIt.I.get<Logger>();

  final parcer = DevDictionaryApiParcer();

  @override
  Future<WordMetadata?> find(String word) async {
    final url = _createUri(word);

    try {
      final response = await http.get(url);

      final decoded = json.decode(response.body);

      final metadata = parcer.parce(decoded);

      return metadata;
    } catch (e) {
      final logger = GetIt.I.get<Logger>();

      logger.e('$word\n$e');
    }

    return null;
  }

  Uri _createUri(String word) {
    final path = 'https://api.dictionaryapi.dev/api/v2/entries/en/$word';

    final url = Uri.parse(path);

    return url;
  }
}

abstract class MetadataParcer {
  WordMetadata? parce(dynamic object);
}

class MetadataJoiner {
  static WordMetadata? join(List<WordMetadata> list) {
    if (list.isEmpty) {
      return null;
    }

    if (list.length == 1) {
      return list[0];
    }

    return WordMetadata(
      word: list[0].word,
      phonetics: list.expand((e) => e.phonetics).toList(),
      meanings: list.expand((e) => e.meanings).toList(),
    );
  }
}

class DevDictionaryApiParcer extends MetadataParcer {
  @override
  WordMetadata? parce(object) {
    final result = switch (object) {
      List<dynamic> list => parceList(list),
      Map<String, dynamic> map => parceSingle(map),
      _ => null,
    };

    return result;
  }

  WordMetadata? parceList(List<dynamic> list) {
    final metadatas = <WordMetadata>[];

    for (var map in list) {
      WordMetadata? metadata = parceSingle(map);

      if (metadata == null) {
        continue;
      }

      metadatas.add(metadata);
    }

    return MetadataJoiner.join(metadatas);
  }

  WordMetadata? parceSingle(Map<String, dynamic> map) {
    return WordMetadata(
      word: map['word'] as String,
      phonetics: asPhoneticList(map['phonetics']),
      meanings: asMeaningList(map['meanings']),
    );
  }

  List<Phonetic> asPhoneticList(dynamic object) {
    List<dynamic>? list = object as List<dynamic>?;

    if (list == null) {
      return List.empty();
    }

    return list.map((e) {
      final map = e as Map<String, dynamic>;

      return Phonetic(
        value: map['text'] as String,
        audio: map['audio'] as String?,
      );
    }).toList();
  }

  List<Meaning> asMeaningList(dynamic object) {
    List<dynamic>? list = object as List<dynamic>?;

    if (list == null) {
      return List.empty();
    }

    return list.map((e) {
      final map = e as Map<String, dynamic>;

      return Meaning(
        partOfSpeech: map['partOfSpeech'] as String,
        definitions: (map['definitions'] as List<dynamic>).map((e) {
          final map = e as Map<String, dynamic>;

          return Definition(
            value: map['definition'] as String,
            example: map['example'] as String?,
          );
        }).toList(),
        synonyms: (map['synonyms'] as List<dynamic>).map((e) => e as String).toList(),
        antonyms: (map['antonyms'] as List<dynamic>).map((e) => e as String).toList(),
      );
    }).toList();
  }
}
