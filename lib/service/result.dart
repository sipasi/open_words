typedef SuccessResult<T> = void Function(T value);
typedef FailResult = void Function(String message);

class Result {
  final Object? _result;
  final String? _message;

  final ResultAction _action;

  const Result(Object? result, ResultAction action, [String? message])
      : _result = result,
        _action = action,
        _message = message;

  const Result.empty() : this(null, ResultAction.success, null);
  const Result.success([Object? result]) : this(result, ResultAction.success, null);

  const Result.fail(String message) : this(null, ResultAction.created, message);

  void empty(void Function() perform) {
    if (_result != null) {
      return;
    }

    perform();
  }

  void contain<T>(SuccessResult<T> perform) {
    if (_result == null) {
      return;
    }

    final result = _result as T?;

    if (result == null) {
      return;
    }

    perform(result);
  }

  void failed(FailResult perform) => _error(ResultAction.failed, perform);

  void _success<T>(ResultAction action, SuccessResult<T> event) {
    if (_action != action) {
      return;
    }

    contain(event);
  }

  void _error(ResultAction action, FailResult event) {
    if (_action != action) {
      return;
    }

    event(_message!);
  }
}

enum ResultAction {
  success,
  created,
  deleted,
  modified,
  failed,
}

class CrudResult extends Result {
  const CrudResult.empty() : super.empty();

  const CrudResult.create(Object result) : super(result, ResultAction.created);
  const CrudResult.delete(Object result) : super(result, ResultAction.deleted);
  const CrudResult.modify(Object result) : super(result, ResultAction.modified);

  void created<T>(SuccessResult<T> perform) => _success(ResultAction.created, perform);
  void deleted<T>(SuccessResult<T> perform) => _success(ResultAction.deleted, perform);
  void modified<T>(SuccessResult<T> perform) => _success(ResultAction.modified, perform);
}
