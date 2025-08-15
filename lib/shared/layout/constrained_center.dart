import 'package:flutter/material.dart';
import 'package:open_words/features/settings/add_preinstalled/widgets/add_preinsalled_list_view.dart';

class ConstrainedCenter extends StatelessWidget {
  final Widget child;

  final BoxConstraints constraints;

  const ConstrainedCenter({
    super.key,
    required this.child,
    this.constraints = const BoxConstraints(maxWidth: 800),
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: constraints,
        child: AddPreinsalledListView(),
      ),
    );
  }
}
