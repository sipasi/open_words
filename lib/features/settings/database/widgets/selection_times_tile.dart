import 'package:flutter/material.dart';

class SelectionTimesTile extends StatelessWidget {
  final String title;

  final List<int> pattern;

  final void Function(int value) onTimes;

  const SelectionTimesTile({
    super.key,
    required this.title,
    required this.pattern,
    required this.onTimes,
  });
  const SelectionTimesTile.simple({
    super.key,
    required this.title,
    required this.onTimes,
  }) : pattern = const [10, 100, 1000];

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Row(
        children: [
          for (final times in pattern)
            InkWell(
              onTap: () => onTimes(times),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6.0,
                ),
                child: Text(times.toString()),
              ),
            ),
        ],
      ),
    );
  }
}
