import 'package:flutter/material.dart';
import 'package:open_words/view/home/app_navigation_bar.dart';
import 'package:open_words/view/shared/layout/constraints_adaptive_layout.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final AppNavigationBar navigationBar;

  final Widget body;

  const ScaffoldWithNavBar({super.key, required this.navigationBar, required this.body});

  @override
  Widget build(BuildContext context) {
    return ConstraintsAdaptiveLayout(
      portrait: (context) {
        return Scaffold(
          appBar: AppBar(toolbarHeight: 0),
          body: SafeArea(child: body),
          bottomNavigationBar: navigationBar.asBottom(),
        );
      },
      landscape: (context) {
        return Scaffold(
          appBar: AppBar(toolbarHeight: 0),
          body: SafeArea(
            child: Row(
              children: [
                navigationBar.asRail(),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: body,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
