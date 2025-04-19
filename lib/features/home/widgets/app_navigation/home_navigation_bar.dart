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

  NavigationBar asBottom() {
    return NavigationBar(
      destinations: bottoms,
      selectedIndex: current,
      onDestinationSelected: selected,
    );
  }
}
