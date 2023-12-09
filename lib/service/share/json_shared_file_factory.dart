import 'dart:async';
import 'dart:convert' as convert;
import 'package:open_words/service/share/shared_file_factory.dart';
import 'package:share_plus/share_plus.dart';

import 'package:path/path.dart' as dart_path;

import 'temporary_file.dart';

class JsonSharedFileFactory<T> extends SharedFileFactory<T> {
  static final String directory = dart_path.join('open_words', 'json');

  JsonSharedFileFactory({required super.name, required super.manyNamePolicy});

  @override
  Future<XFile> one(List<T> data) {
    return _from(data, name);
  }

  @override
  Future<List<XFile>> many(List<T> data) async {
    final futures = data.map((entity) async => _from(entity, manyNamePolicy(entity))).toList();

    final files = await Future.wait(futures);

    return files;
  }

  static Future<XFile> _from<T>(T data, String name) async {
    final json = convert.json.encode(data);

    final file = await TemporaryFile.create(directory: directory, name: name);

    await file.writeAsString(json, flush: true);

    return XFile(file.path);
  }
}
