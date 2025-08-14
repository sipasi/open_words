import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/settings/database/bloc/measure_cubit.dart';
import 'package:open_words/features/settings/database/widgets/measure_tile_group.dart';

class MeasureCubitTile<T extends MeasureCubit> extends StatelessWidget {
  const MeasureCubitTile({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<T>();

    final mesures = cubit.state.mesures;

    return MeasureTileGroup(
      name: cubit.runtimeType.toString(),
      loading: cubit.state.loading,
      mesures: mesures,
      onTimes: cubit.measure,
    );
  }
}
