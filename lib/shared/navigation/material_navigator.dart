import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/result/result.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

part 'material_bloc_navigator.dart';

sealed class MaterialNavigator {
  static AsyncResult<T> push<T extends Object?>(
    BuildContext context,
    WidgetBuilder builder,
  ) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: builder),
    );

    if (result is! Result<T>) {
      return Result.empty();
    }

    return result;
  }

  static AsyncResult<T> pushDelayed<T extends Object?>({
    required BuildContext context,
    required WidgetBuilder builder,
    required Duration duration,
  }) async {
    await Future.delayed(duration);

    if (!context.mounted) {
      return Result.empty();
    }

    return push(context, builder);
  }

  static AsyncResult<T> pushSmoothSheet<T>(
    BuildContext context,
    WidgetBuilder builder,
  ) async {
    final result = await Navigator.push(
      context,
      ModalSheetRoute(
        swipeDismissible: true,
        builder: builder,
      ),
    );

    if (result is! Result<T>) {
      return Result.empty();
    }

    return result;
  }

  static void pop<T>(BuildContext context, {int times = 1}) {
    for (var i = 0; i < times; i++) {
      Navigator.pop(context, Result.empty());
    }
  }

  static void popSuccess<T>(BuildContext context, T value) {
    Navigator.pop(context, Result.success(value));
  }

  static void popWith<T>(BuildContext context, Result<T> value) {
    Navigator.pop(context, value);
  }

  static Future<Result> popAndPush<T extends Object?>(
    BuildContext context,
    WidgetBuilder builder,
  ) {
    pop(context);

    return push(context, builder);
  }
}

extension MaterialNavigatorExtension on BuildContext {
  AsyncResult<T> push<T extends Object?>(WidgetBuilder builder) {
    return MaterialNavigator.push(this, builder);
  }

  AsyncResult<T> pushDelayed<T extends Object?>(
    WidgetBuilder builder, {
    required Duration duration,
  }) {
    return MaterialNavigator.pushDelayed(
      context: this,
      builder: builder,
      duration: duration,
    );
  }

  AsyncResult<T> pushSmoothSheet<T extends Object?>(WidgetBuilder builder) {
    return MaterialNavigator.pushSmoothSheet(this, builder);
  }

  void pop<T>({int times = 1}) {
    MaterialNavigator.pop(this, times: times);
  }

  void popSuccess<T>(T value) {
    MaterialNavigator.popSuccess(this, value);
  }

  void popWith<T>(Result<T> value) {
    MaterialNavigator.popWith(this, value);
  }

  AsyncResult<T> popAndPush<T extends Object?>(WidgetBuilder builder) {
    pop();

    return push(builder);
  }
}
