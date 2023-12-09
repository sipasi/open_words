import 'dart:async';
import 'package:share_plus/share_plus.dart';

abstract class SharedFileFactory<T> {
  final String name;
  final String Function(T) manyNamePolicy;

  SharedFileFactory({required this.name, required this.manyNamePolicy});

  Future<XFile> one(List<T> data);
  Future<List<XFile>> many(List<T> data);
}
