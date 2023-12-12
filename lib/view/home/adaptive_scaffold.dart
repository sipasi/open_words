import 'package:flutter/material.dart';
import 'package:open_words/view/home/app_navigation_bar.dart';

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
    return LayoutBuilder(builder: (context, constraints) {
      bool mobile = constraints.maxHeight > constraints.maxWidth;

      return mobile ? _mobile() : _decktop();
    });
  }

  Widget _mobile() {
    return Scaffold(
      body: SafeArea(child: widget.body),
      bottomNavigationBar: widget.navigationBar.asBottom(),
    );
  }

  Widget _decktop() {
    return Scaffold(
      body: SafeArea(
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
  }
}
