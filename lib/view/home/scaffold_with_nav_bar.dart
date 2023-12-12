import 'package:flutter/material.dart';
import 'package:open_words/view/home/app_navigation_bar.dart';
import 'package:open_words/view/shared/layout/adaptive_layout_by_constraints_height.dart';

class ScaffoldWithNavBar extends StatefulWidget {
  final AppNavigationBar navigationBar;

  final Widget body;

  const ScaffoldWithNavBar({super.key, required this.navigationBar, required this.body});

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  @override
  Widget build(BuildContext context) {
    return AdaptiveLayoutByConstraintsHeight(
      portrait: (context) {
        return Scaffold(
          body: SafeArea(child: widget.body),
          bottomNavigationBar: widget.navigationBar.asBottom(),
        );
      },
      landscape: (context) {
        return Scaffold(
          body: SafeArea(
            top: false,
            child: Row(
              children: [
                widget.navigationBar.asRail(),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: widget.body,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
