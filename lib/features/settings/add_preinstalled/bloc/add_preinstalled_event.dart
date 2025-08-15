part of 'add_preinstalled_bloc.dart';

sealed class AddPreinstalledEvent {}

final class AddPreinstalledLoadRequested extends AddPreinstalledEvent {}

final class AddPreinstalledAddToLibraryRequested extends AddPreinstalledEvent {}

final class AddPreinstalledPackTapped extends AddPreinstalledEvent {
  final PreinstalledPack value;

  AddPreinstalledPackTapped(this.value);
}
