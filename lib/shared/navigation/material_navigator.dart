import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/result/result.dart';
import 'package:open_words/shared/navigation/material_bloc_navigator.dart';

sealed class MaterialNavigator {
  static AsyncResult<T> push<T extends Object?>(
    BuildContext context,
    WidgetBuilder builder,
  ) async {
    final result = await Navigator.push<Result<T>?>(
      context,
      MaterialPageRoute(builder: builder),
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

  static void popWith<T>(BuildContext context, T value) {
    Navigator.pop(context, Result.success(value));
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
  Future<Result> push<T extends Object?>(WidgetBuilder builder) {
    return MaterialNavigator.push(this, builder);
  }

  Future<Result> pushBlocValue<T extends Object?, TBloc extends BlocBase>(
    BuildContext context,
    TBloc bloc,
    WidgetBuilder builder,
  ) {
    return MaterialBlocNavigator.pushBlocValue(context, bloc, builder);
  }

  void pop<T>({int times = 1}) {
    MaterialNavigator.pop(this, times: times);
  }

  void popWith<T>(T value) {
    MaterialNavigator.popWith(this, Result.success(value));
  }

  Future<Result> popAndPush<T extends Object?>(WidgetBuilder builder) {
    pop();

    return push(builder);
  }
}
