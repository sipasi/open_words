import 'package:flutter/material.dart';
import 'package:open_words/features/settings/database/models/time_measure_result.dart';
import 'package:open_words/features/settings/database/widgets/measure_tile.dart';
import 'package:open_words/features/settings/database/widgets/selection_times_tile.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MeasureTileGroup extends StatelessWidget {
  final String name;

  final bool loading;

  final List<TimeMeasureInfo> mesures;

  final void Function(int times) onTimes;

  const MeasureTileGroup({
    super.key,
    required this.name,
    required this.loading,
    required this.mesures,
    required this.onTimes,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(name),
      children: [
        Skeletonizer(
          enabled: loading,
          child: Column(
            children: [
              SelectionTimesTile.simple(title: 'Times', onTimes: onTimes),
              ...List.generate(mesures.length, (index) {
                final measure = mesures[index];
                return MeasureTile(title: measure.name, measure: measure);
              }),
            ],
          ),
        ),
      ],
    );
  }
}
