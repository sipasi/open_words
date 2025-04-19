import 'package:flutter/material.dart';
import 'package:open_words/features/home/widgets/app_navigation/home_destination.dart';

abstract class DestinationConverter {
  static List<NavigationRailDestination> asRails(
    List<HomeDestination> destination,
  ) {
    return destination
        .map(
          (e) => NavigationRailDestination(
            icon: Icon(e.icon),
            label: Text(e.label),
          ),
        )
        .toList();
  }

  static List<NavigationDestination> asBottoms(List<HomeDestination> destination) {
    return destination
        .map((e) => NavigationDestination(icon: Icon(e.icon), label: e.label))
        .toList();
  }
}
