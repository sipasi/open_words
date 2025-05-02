part 'api_result.dart';
part 'async_result.dart';
part 'crud_result.dart';

sealed class Result<T> {
  const Result();

  factory Result.empty() => EmptyResult();
  factory Result.success(T value) => SuccessResult(value);
  factory Result.failure(String message, [Object? error]) =>
      FailureResult(message, error);

  T? tryValue() => switch (this) {
    SuccessResult<T>(:final value) => value,
    _ => null,
  };

  bool get isEmpty => this is EmptyResult;
  bool get isSuccess => this is SuccessResult<T>;
  bool get isFailure => this is FailureResult<T>;

  void onSuccess(void Function(T value) callback) {
    if (this is SuccessResult<T>) callback((this as SuccessResult<T>).value);
  }

  void onEmpty(void Function() callback) {
    if (this is EmptyResult) callback();
  }
}

final class EmptyResult<T> extends Result<T> {
  const EmptyResult();
}

final class SuccessResult<T> extends Result<T> {
  final T value;
  const SuccessResult(this.value);
}

final class FailureResult<T> extends Result<T> {
  final String message;
  final Object? error;
  const FailureResult(this.message, [this.error]);
}
