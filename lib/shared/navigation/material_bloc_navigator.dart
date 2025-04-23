import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/result/result.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

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
