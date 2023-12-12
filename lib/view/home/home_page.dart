import 'package:flutter/material.dart';
import 'package:open_words/view/home/adaptive_scaffold.dart';
import 'package:open_words/view/home/app_navigation_bar.dart';
import 'package:open_words/view/settings/settings_page.dart';
import 'package:open_words/view/word_group/list/word_group_list_page.dart';

import 'navigation_destination_base.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;

  final destinations = const [
    NavigationDestinationBase(
      icon: Icons.book_outlined,
      label: "Dictionaries",
    ),
    NavigationDestinationBase(
      icon: Icons.settings_outlined,
      label: "Settings",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final navigation = AppNavigationBar(current: pageIndex, items: destinations, selected: onDestinationSelected);

    return ScaffoldWithNavBar(body: getPageBy(pageIndex), navigationBar: navigation);
  }

  void onDestinationSelected(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  Widget getPageBy(int index) => switch (index) {
        0 => const WordGroupListPage(),
        1 => const SettingsPage(),
        _ => const WordGroupListPage(),
      };
}
