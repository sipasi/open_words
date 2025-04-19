import 'package:flutter/material.dart';

typedef ScreenBuilder = Widget Function();
typedef AppBarBuilder = PreferredSizeWidget Function();
typedef FabBuilder = Widget Function();

class HomeScreenBuilder {
  final ScreenBuilder body;
  final AppBarBuilder appBar;
  final FabBuilder? fab;

  const HomeScreenBuilder({required this.body, required this.appBar, this.fab});
}
