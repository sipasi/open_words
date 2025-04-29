import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:open_words/shared/constants/hero_tag_constants.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class ExpandableFabDefault extends StatelessWidget {
  final GlobalKey<ExpandableFabState> fabKey;

  final ExpandableFabType type;
  final double distance;
  final List<Widget> children;

  const ExpandableFabDefault({
    super.key,
    required this.fabKey,
    required this.type,
    required this.distance,
    required this.children,
  });
  const ExpandableFabDefault.up({
    super.key,
    required this.fabKey,
    required this.children,
  }) : type = ExpandableFabType.up,
       distance = 80;

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      key: fabKey,
      openButtonBuilder: RotateFloatingActionButtonBuilder(
        child: const Icon(Icons.menu),
        fabSize: ExpandableFabSize.regular,
        heroTag: HeroTagConstants.fabDefaultTag,
      ),
      overlayStyle: ExpandableFabOverlayStyle(
        color: context.colorScheme.primary.withValues(alpha: .01),
        blur: 5,
      ),
      type: type,
      distance: distance,
      children: children,
    );
  }
}
