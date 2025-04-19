part of 'explorer_bloc.dart';

sealed class ExplorerEvent {}

final class ExplorerLoadRequested extends ExplorerEvent {
  final Id folderId;

  ExplorerLoadRequested({this.folderId = const Id.empty()});
}

final class ExplorerRefreshRequested extends ExplorerEvent {
  ExplorerRefreshRequested();
}
