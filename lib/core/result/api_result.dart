part of 'result.dart';

extension ApiResult<T> on Result<T> {
  static Result<T> notFounded<T>(String message, [Object? error]) =>
      NotFoundResult(message, error);

  bool get isNotFound => this is NotFoundResult<T>;

  void onNotFounded(void Function(T value) callback) {
    if (this is CreatedResult<T>) callback((this as CreatedResult<T>).value);
  }
}

final class NotFoundResult<T> extends FailureResult<T> {
  const NotFoundResult(super.value, [super.error]);
}
