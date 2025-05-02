part of 'result.dart';

typedef AsyncResult<T> = Future<Result<T>>;

extension AsyncResultExtension<T> on AsyncResult<T> {
  static AsyncResult<T> from<T>(Future<T> Function() operation) async {
    try {
      final result = await operation();
      return Result.success(result);
    } catch (e) {
      return Result.failure(e.toString(), e);
    }
  }
}
