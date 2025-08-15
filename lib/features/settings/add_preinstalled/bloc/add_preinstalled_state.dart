// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_preinstalled_bloc.dart';

class AddPreinstalledState {
  final List<PreinstalledPack> packs;
  final Set<PreinstalledPack> selected;

  final LoadStatus loadingStatus;
  final AddToLibraryStatus addToLibraryStatus;

  AddPreinstalledState({
    required this.packs,
    required this.selected,
    required this.loadingStatus,
    required this.addToLibraryStatus,
  });

  const AddPreinstalledState.initial()
    : packs = const [],
      selected = const {},
      loadingStatus = LoadStatus.loading,
      addToLibraryStatus = AddToLibraryStatus.notStarted;

  AddPreinstalledState copyWith({
    List<PreinstalledPack>? packs,
    Set<PreinstalledPack>? selected,
    LoadStatus? loadingStatus,
    AddToLibraryStatus? addToLibraryStatus,
  }) {
    return AddPreinstalledState(
      packs: packs ?? this.packs,
      selected: selected ?? this.selected,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      addToLibraryStatus: addToLibraryStatus ?? this.addToLibraryStatus,
    );
  }
}

enum LoadStatus { loading, finished }

enum AddToLibraryStatus {
  notStarted,
  adding,
  finished;

  bool get isNotStarted => this == notStarted;
  bool get isAdding => this == adding;
  bool get isFinished => this == finished;
}
