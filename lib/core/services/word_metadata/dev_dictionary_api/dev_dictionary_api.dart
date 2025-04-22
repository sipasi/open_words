import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:open_words/core/data/draft/metadata/word_metadata_draft.dart';
import 'package:open_words/core/services/logger/app_logger.dart';
import 'package:open_words/core/services/word_metadata/dev_dictionary_api/dev_dictionary_api_parcer.dart';
import 'package:open_words/core/services/word_metadata/word_metadata_web_api.dart';

class DevDictionaryApi extends WordMetadataWebApi {
  final _logger = GetIt.I.get<AppLogger>();

  final _parcer = DevDictionaryApiParcer();

  @override
  Future<WordMetadataDraft?> find(String word) async {
    final url = _createUri(word);

    try {
      final response = await http.get(url);

      final decoded = json.decode(response.body);

      final metadata = _parcer.parce(decoded);

      return metadata;
    } catch (e) {
      _logger.e('[DevDictionaryApi.find]\n$word\n$e');
    }

    return null;
  }

  Uri _createUri(String word) {
    final path = 'https://api.dictionaryapi.dev/api/v2/entries/en/$word';

    final url = Uri.parse(path);

    return url;
  }
}
