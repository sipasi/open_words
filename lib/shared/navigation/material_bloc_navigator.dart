part of 'material_navigator.dart';

class MaterialBlocNavigator {
  static AsyncResult<T> pushBlocValue<
    T extends Object?,
    TBloc extends BlocBase
  >(BuildContext context, TBloc bloc, WidgetBuilder builder) async {
    return MaterialNavigator.push(context, (context) {
      return BlocProvider.value(value: bloc, child: builder(context));
    });
  }

  static AsyncResult<T> pushSmoothSheetBloc<
    T extends Object?,
    TBloc extends BlocBase
  >(BuildContext context, TBloc bloc, WidgetBuilder builder) async {
    return MaterialNavigator.pushSmoothSheet(context, (context) {
      return BlocProvider.value(value: bloc, child: builder(context));
    });
  }
}

extension MaterialBlocNavigatorExtension on BuildContext {
  AsyncResult<T> pushBlocValue<T extends Object?, TBloc extends BlocBase>(
    TBloc bloc,
    WidgetBuilder builder,
  ) {
    return MaterialBlocNavigator.pushBlocValue(this, bloc, builder);
  }

  AsyncResult<T> pushSmoothSheetBloc<T extends Object?, TBloc extends BlocBase>(
    TBloc bloc,
    WidgetBuilder builder,
  ) {
    return MaterialBlocNavigator.pushSmoothSheetBloc(this, bloc, builder);
  }
}
