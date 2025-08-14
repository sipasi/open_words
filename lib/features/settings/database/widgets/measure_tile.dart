import 'package:flutter/material.dart';
import 'package:open_words/features/settings/database/models/time_measure_result.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class MeasureTile extends StatelessWidget {
  final String title;
  final TimeMeasureInfo measure;

  String get timesText => measure.measureTimes.toString();
  String get averageText => measure.average.elapsedString;
  String get lastText => measure.last.elapsedString;

  const MeasureTile({super.key, required this.title, required this.measure});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('$title - $timesText'),
      subtitle: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'aver: $averageText',
              style: TextStyle(color: context.colorScheme.primary),
            ),
            TextSpan(text: '\n'),
            TextSpan(
              text: 'last:  $lastText',
              style: TextStyle(color: context.colorScheme.secondary),
            ),
          ],
        ),
      ),
      trailing: Text(
        measure.last.value.length > 10 ? 'too long' : measure.last.value,
      ),
    );
  }
}
