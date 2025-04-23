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

  static AsyncResult<T> value<T>(T value) async => Result.success(value);
  static AsyncResult<T> error<T>(String message, [Object? error]) async =>
      Result.failure(message, error);

  Future<R> whenAsync<R>({
    required R Function() onEmpty,
    required R Function(T value) onSuccess,
    required R Function(String message, Object? error) onFailure,
  }) async {
    final result = await this;
    return result.when(
      onEmpty: onEmpty,
      onSuccess: onSuccess,
      onFailure: onFailure,
    );
  }
}
