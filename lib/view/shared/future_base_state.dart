import 'package:flutter/material.dart';

abstract class FutureBaseState<T extends StatefulWidget, TData> extends State<T> {
  Future<TData>? _future;

  TData? cache;

  @protected
  Future<TData>? get future => _future;

  @override
  void initState() {
    super.initState();

    onInitState();

    loadFuture();
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
    return const LinearProgressIndicator();
  }

  @protected
  Widget successBuild(BuildContext context, TData data);
}
