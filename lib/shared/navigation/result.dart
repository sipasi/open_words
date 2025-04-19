sealed class Result {
  const Result._();

  static Result empty() => const _EmptyResult();
  static Result contain(dynamic value) => _ContainedResult(value);
  static Result fail(String message) => _FailedResult(message);

  T? tryGet<T>() {
    if (this case _ContainedResult result) {
      return result.value as T?;
    }

    return null;
  }

  void emptied(void Function() perform) {
    if (this is _EmptyResult) {
      perform();
    }
  }

  void failed(void Function(String message) perform) {
    if (this case _FailedResult result) {
      perform(result.message);
    }
  }

  void contained<T>(void Function(T item) perform) =>
      _performWhen<_ContainedResult, T>(this, perform);

  static void _performWhen<TResult extends _ContainedResult, T2>(
    Result result,
    void Function(T2 item) perform,
  ) {
    if (result case TResult result when result.value is T2) {
      perform(result.value);
    }
  }
}

extension CrudResult on Result {
  static Result create(dynamic result) => _CreatedResult(result);
  static Result delete(dynamic result) => _DeletedResult(result);
  static Result modify(dynamic result) => _ModifiedResult(result);

  bool get isCreated => this is _CreatedResult;
  bool get isDeleted => this is _DeletedResult;
  bool get isModified => this is _ModifiedResult;

  void created<T>(void Function(T item) perform) =>
      Result._performWhen<_CreatedResult, T>(this, perform);
  void deleted<T>(void Function(T item) perform) =>
      Result._performWhen<_DeletedResult, T>(this, perform);
  void modified<T>(void Function(T item) perform) =>
      Result._performWhen<_ModifiedResult, T>(this, perform);
}

final class _EmptyResult extends Result {
  const _EmptyResult() : super._();
}

final class _FailedResult extends Result {
  final String message;

  const _FailedResult(this.message) : super._();
}

final class _ContainedResult extends Result {
  final dynamic value;

  const _ContainedResult(this.value) : super._();
}

final class _CreatedResult extends _ContainedResult {
  _CreatedResult(super.value);
}

final class _DeletedResult extends _ContainedResult {
  _DeletedResult(super.value);
}

final class _ModifiedResult extends _ContainedResult {
  _ModifiedResult(super.value);
}
