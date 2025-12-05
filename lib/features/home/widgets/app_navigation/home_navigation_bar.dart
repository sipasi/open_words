import 'package:flutter/material.dart';

class HomeNavigationBar {
  final int current;

  final List<NavigationRailDestination> rails;
  final List<NavigationDestination> bottoms;

  final void Function(int) selected;

  HomeNavigationBar({
    required this.current,
    required this.rails,
    required this.bottoms,
    required this.selected,
  });

  NavigationRail asRail() {
    return NavigationRail(
      destinations: rails,
      selectedIndex: current,
      onDestinationSelected: selected,
      groupAlignment: 0,
    );
  }

  Widget asBottom(bool oled) {
    final navbar = NavigationBar(
      destinations: bottoms,
      selectedIndex: current,
      onDestinationSelected: selected,
    );

    if (oled == false) {
      return navbar;
    }

    return Container(
      decoration: BoxDecoration(
        border: const Border(
          top: BorderSide(width: .1, color: Colors.white),
        ),
      ),
      child: navbar,
    );
  }
}
