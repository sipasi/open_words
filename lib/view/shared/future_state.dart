import 'package:flutter/material.dart';

abstract class FutureState<T extends StatefulWidget, TData> extends State<T> {
  Future<TData>? _future;

  TData? cache;

  @override
  void initState() {
    super.initState();

    onInitState();

    loadFuture();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TData>(
      future: _future,
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

  @protected
  void onInitState() {}

  @protected
  Future<TData> getFuture();

  @protected
  void loadFuture() {
    _future = getFuture();
  }

  @protected
  Widget loadingBuild(BuildContext context) {
    return const CircularProgressIndicator();
  }

  @protected
  Widget successBuild(BuildContext context, TData data);
}
