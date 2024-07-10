import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:open_words/service/result.dart';

abstract class MaterialNavigator {
  static final logger = GetIt.I.get<Logger>();

  static Future<Result> push<T extends Object?>(
    BuildContext context,
    WidgetBuilder builder,
  ) async {
    Result? result = await Navigator.push<Result>(
      context,
      MaterialPageRoute(builder: builder),
    );

    if (isNot<T>(result)) {
      return Result.empty();
    }

    return result as Result;
  }

  static void pop<T>(BuildContext context, {int times = 1}) {
    for (var i = 0; i < times; i++) {
      Navigator.pop(context, Result.empty());
    }
  }

  static void popWith<T>(BuildContext context, Result result) {
    Navigator.pop(context, result);
  }

  static Future<Result> bottomSheet<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool isScrollControlled = false,
    bool useSafeArea = false,
  }) async {
    final result = await showModalBottomSheet(
      context: context,
      builder: builder,
      isScrollControlled: isScrollControlled,
      enableDrag: false,
      useSafeArea: useSafeArea,
    );

    if (isNot<T>(result)) {
      return Result.empty();
    }

    return result as Result;
  }

  static bool isNot<T>(dynamic object) {
    if (object is Result) {
      return false;
    }

    String message = 'Page return $object insead of PageResult<${T.runtimeType}> type';

    logger.e(message);

    return true;
  }
}
