import 'package:flutter/material.dart';
import 'package:open_words/view/home/navigation_destination_base.dart';

class AppNavigationBar {
  final int current;
  final List<NavigationDestinationBase> items;

  final void Function(int) selected;

  late final List<NavigationRailDestination> _railDestination;
  late final List<Widget> _bottomDestination;

  AppNavigationBar({required this.current, required this.items, required this.selected}) {
    _railDestination = items
        .map((e) => NavigationRailDestination(
              icon: Icon(e.icon),
              label: Text(e.label),
            ))
        .toList();

    _bottomDestination = items
        .map((e) => NavigationDestination(
              icon: Icon(e.icon),
              label: e.label,
            ))
        .toList();
  }

  Widget asRail() {
    return NavigationRail(
      destinations: _railDestination,
      selectedIndex: current,
      onDestinationSelected: selected,
      groupAlignment: 0,
    );
  }

  Widget asBottom() {
    return NavigationBar(
      selectedIndex: current,
      onDestinationSelected: selected,
      destinations: _bottomDestination,
    );
  }
}
