import 'package:flutter/material.dart';
import 'package:open_words/view/shared/future_base_state.dart';

abstract class FutureScaffoldState<T extends StatefulWidget, TData> extends FutureBaseState<T, TData> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TData>(
      future: future,
      builder: (context, AsyncSnapshot<TData> snapshot) {
        if (snapshot.hasError) {
          return Text('$runtimeType: has error');
        }

        return Scaffold(
          appBar: appbarBuild(context, snapshot.connectionState),
          body: switch (snapshot.connectionState) {
            ConnectionState.waiting => loadingBuild(context),
            _ => successBuild(context, snapshot.data as TData),
          },
        );
      },
    );
  }

  @protected
  AppBar appbarBuild(BuildContext context, ConnectionState state);
}
