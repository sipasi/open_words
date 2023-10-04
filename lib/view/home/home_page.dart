import 'package:flutter/material.dart';
import 'package:open_words/view/settings/settings_page.dart';
import 'package:open_words/view/word_group/list/word_group_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: getPageBy(pageIndex),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: pageIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.book_outlined),
            label: "Dictionaries",
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: "Settings",
          ),
        ],
      ),
    );
  }

  void onDestinationSelected(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  Widget getPageBy(int index) => switch (index) {
        0 => const WordGroupListPage(),
        1 => const SettingsPage(),
        _ => const WordGroupListPage()
      };
}
