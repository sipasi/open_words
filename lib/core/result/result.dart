part 'api_result.dart';
part 'async_result.dart';
part 'crud_result.dart';

sealed class Result<T> {
  const Result();

  factory Result.empty() => EmptyResult<T>();
  factory Result.success(T value) => SuccessResult(value);
  factory Result.failure(String message, [Object? error]) =>
      FailureResult(message, error);

  R when<R>({
    required R Function() onEmpty,
    required R Function(T value) onSuccess,
    required R Function(String message, Object? error) onFailure,
  }) {
    return switch (this) {
      EmptyResult<T>() => onEmpty(),
      SuccessResult<T>(:final value) => onSuccess(value),
      FailureResult<T>(:final message, :final error) => onFailure(
        message,
        error,
      ),
    };
  }

  T? tryValue() => switch (this) {
    SuccessResult<T>(:final value) => value,
    _ => null,
  };

  bool get isEmpty => this is EmptyResult<T>;
  bool get isSuccess => this is SuccessResult<T>;
  bool get isFailure => this is FailureResult<T>;
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
