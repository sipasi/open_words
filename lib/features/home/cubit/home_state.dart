part of 'home_cubit.dart';

enum HomeScreen { explorer, settings }

final class HomeState {
  final HomeScreen screen;

  HomeState({required this.screen});
  HomeState.initial() : screen = HomeScreen.explorer;

  HomeState copyWith({HomeScreen? screen}) {
    return HomeState(screen: screen ?? this.screen);
  }
}
