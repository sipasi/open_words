import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/explorer/list/explorer_screen.dart';
import 'package:open_words/features/explorer/list/widgets/explorer_app_bar.dart';
import 'package:open_words/features/explorer/list/widgets/explorer_fab.dart';
import 'package:open_words/features/home/cubit/home_cubit.dart';
import 'package:open_words/features/home/utils/destination_converter.dart';
import 'package:open_words/features/home/widgets/app_navigation/home_destination.dart';
import 'package:open_words/features/home/widgets/app_navigation/home_navigation_bar.dart';
import 'package:open_words/features/home/widgets/app_navigation/home_scaffold_builder.dart';
import 'package:open_words/features/home/widgets/app_navigation/home_screen_builder.dart';
import 'package:open_words/features/settings/list/settings_screen.dart';

class HomePage extends StatelessWidget {
  static const _destinations = [
    HomeDestination(icon: Icons.explore_outlined, label: "Explorer"),
    HomeDestination(icon: Icons.settings_outlined, label: "Settings"),
  ];

  static final _rails = DestinationConverter.asRails(_destinations);
  static final _bottoms = DestinationConverter.asBottoms(_destinations);

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = context.select((HomeCubit value) => value.state.screen);

    return HomeScaffoldBuilder(
      navigationBar: _getNavBar(screen, context),
      screenBuilder: _getScreenBy(screen),
    );
  }

  HomeNavigationBar _getNavBar(HomeScreen screen, BuildContext context) {
    return HomeNavigationBar(
      rails: _rails,
      bottoms: _bottoms,
      current: screen.index,
      selected: (index) {
        final cubit = context.read<HomeCubit>();

        cubit.setScreen(HomeScreen.values[index]);
      },
    );
  }

  HomeScreenBuilder _getScreenBy(HomeScreen screen) => switch (screen) {
    HomeScreen.explorer => HomeScreenBuilder(
      body: () => ExplorerScreen(),
      appBar: () => ExplorerAppBar(),
      fab: () => ExplorerFab(),
    ),
    HomeScreen.settings => HomeScreenBuilder(
      body: () => SettingsScreen(),
      appBar: () => AppBar(toolbarHeight: 0),
    ),
  };
}
