part of 'explorer_bloc.dart';

sealed class ExplorerEvent {}

final class ExplorerStarted extends ExplorerEvent {
  ExplorerStarted();
}

final class ExplorerNavigateRequested extends ExplorerEvent {
  final Folder folder;

  ExplorerNavigateRequested({required this.folder});
}

final class ExplorerNavigateBackRequested extends ExplorerEvent {
  ExplorerNavigateBackRequested();
}

final class ExplorerRefreshRequested extends ExplorerEvent {
  ExplorerRefreshRequested();
}
