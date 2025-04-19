import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/shared/navigation/result.dart';

sealed class MaterialNavigator {
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

  static void popWith<T>(BuildContext context, T value) {
    Navigator.pop(context, Result.contain(value));
  }

  static Future<Result> popAndPush<T extends Object?>(
    BuildContext context,
    WidgetBuilder builder,
  ) {
    pop(context);

    return push(context, builder);
  }

  static bool isNot<T>(dynamic object) {
    if (object is Result) {
      return false;
    }

    return true;
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
    MaterialNavigator.popWith(this, Result.contain(value));
  }

  Future<Result> popAndPush<T extends Object?>(WidgetBuilder builder) {
    pop();

    return push(builder);
  }

  bool isNot<T>(dynamic object) {
    return MaterialNavigator.isNot(object);
  }
}

class MaterialBlocNavigator {
  static Future<Result> pushBlocValue<
    T extends Object?,
    TBloc extends BlocBase
  >(BuildContext context, TBloc bloc, WidgetBuilder builder) async {
    return MaterialNavigator.push(context, (context) {
      return BlocProvider.value(value: bloc, child: builder(context));
    });
  }
}
