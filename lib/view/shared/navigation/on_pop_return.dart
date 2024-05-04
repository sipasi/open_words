import 'package:flutter/material.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/service/result.dart';

class OnPopReturn<T> extends StatelessWidget {
  final T Function() value;

  final Widget child;

  const OnPopReturn({super.key, required this.value, required this.child});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: child,
      onPopInvoked: (didPop) {
        if (didPop == false) {
          T item = value();

          MaterialNavigator.popWith(context, CrudResult.modify(item));
        }
      },
    );
  }
}
