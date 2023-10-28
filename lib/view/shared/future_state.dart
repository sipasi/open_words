import 'package:flutter/material.dart';
import 'package:open_words/view/shared/future_base_state.dart';

abstract class FutureState<T extends StatefulWidget, TData> extends FutureBaseState<T, TData> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TData>(
      future: future,
      builder: (context, AsyncSnapshot<TData> snapshot) {
        if (snapshot.hasError) {
          return Text('$runtimeType: has error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingBuild(context);
        }

        cache = snapshot.data;

        return successBuild(context, snapshot.data as TData);
      },
    );
  }
}
