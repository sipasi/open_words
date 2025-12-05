import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/app/cubit/open_words_app_cubit.dart';
import 'package:open_words/features/home/widgets/app_navigation/home_navigation_bar.dart';
import 'package:open_words/features/home/widgets/app_navigation/home_screen_builder.dart';
import 'package:open_words/shared/layout/constraints_adaptive_layout.dart';

class HomeScaffoldBuilder extends StatelessWidget {
  final HomeNavigationBar navigationBar;
  final HomeScreenBuilder screenBuilder;

  const HomeScaffoldBuilder({
    super.key,
    required this.navigationBar,
    required this.screenBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ConstraintsAdaptiveLayout(
      portrait: (context) {
        final oledBackground = context.select(
          (OpenWordsAppCubit value) => value.state.theme.oledBackground,
        );

        return Scaffold(
          appBar: screenBuilder.appBar.call(),
          floatingActionButton: screenBuilder.fab?.call(),
          body: screenBuilder.body.call(),
          bottomNavigationBar: navigationBar.asBottom(
            oledBackground,
          ),
        );
      },
      landscape: (context) {
        return Scaffold(
          floatingActionButton: screenBuilder.fab?.call(),
          body: Row(
            children: [
              navigationBar.asRail(),
              const VerticalDivider(thickness: 1, width: 1),

              Expanded(
                child: Column(
                  children: [
                    screenBuilder.appBar.call(),
                    Expanded(child: screenBuilder.body.call()),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
