import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/settings/add_preinstalled/bloc/add_preinstalled_bloc.dart';
import 'package:open_words/features/settings/add_preinstalled/model/preinstalled_pack.dart';

class AddPreinsalledListView extends StatelessWidget {
  const AddPreinsalledListView({super.key});

  @override
  Widget build(BuildContext context) {
    final packs = context.select(
      (AddPreinstalledBloc value) => value.state.packs,
    );
    final selected = context.select(
      (AddPreinstalledBloc value) => value.state.selected,
    );

    return ListView.builder(
      itemCount: packs.length,
      itemBuilder: (context, index) => _tile(
        context: context,
        pack: packs[index],
        selected: selected.contains(packs[index]),
      ),
    );
  }

  Widget _tile({
    required BuildContext context,
    required PreinstalledPack pack,
    required bool selected,
  }) {
    return Card.outlined(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        onTap: () => _onTileTap(context, pack),
        onLongPress: () => _onShowDictionaryTap(context, pack),
        selected: selected,
        title: Text(pack.name),
        subtitle: Text('${pack.origin.native} - ${pack.translation.native}'),
        trailing: selected
            ? Icon(Icons.check_box)
            : Icon(Icons.check_box_outline_blank),
      ),
    );
  }

  Future _onTileTap(
    BuildContext context,
    PreinstalledPack pack,
  ) async {
    context.read<AddPreinstalledBloc>().add(AddPreinstalledPackTapped(pack));
  }

  Future _onShowDictionaryTap(
    BuildContext context,
    PreinstalledPack pack,
  ) async {}
}
