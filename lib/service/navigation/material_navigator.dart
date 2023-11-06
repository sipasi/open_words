import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

abstract class MaterialNavigator {
  static final logger = GetIt.I.get<Logger>();

  static Future<Result> push<T extends Object?>(
    BuildContext context,
    Widget Function(BuildContext context) builder,
  ) async {
    Result? result = await Navigator.push<Result>(
      context,
      MaterialPageRoute(builder: builder),
    );

    if (result == null) {
      String message = 'Page don\'t return result of PageResult<${T.runtimeType}> type';

      logger.e(message);

      return const Result.empty();
    }

    return result;
  }

  static void pop<T>(BuildContext context) {
    Navigator.pop(context, const Result.empty());
  }

  static void popWith<T>(BuildContext context, Result result) {
    Navigator.pop(context, result);
  }
}

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

  const Result.empty() : this(null, ResultAction.none, null);

  const Result.create(Object result) : this(result, ResultAction.created);
  const Result.delete(Object result) : this(result, ResultAction.deleted);
  const Result.modify(Object result) : this(result, ResultAction.modified);

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

  void created<T>(SuccessResult<T> perform) => _success(ResultAction.created, perform);
  void deleted<T>(SuccessResult<T> perform) => _success(ResultAction.deleted, perform);
  void modified<T>(SuccessResult<T> perform) => _success(ResultAction.modified, perform);

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
  none,
  created,
  deleted,
  modified,
  failed,
}
