import 'dart:async';
import 'package:open_words/view/shared/card/flip/flip_card.dart';

class FlipCardController {
  FlipCardState? _state;

  /// The internal widget state. Use only if you know what you're doing!
  ///
  /// This will throw an [AssertionError] if controller has not been
  /// assigned to a [FlipCard] widget or state has not been initialized
  FlipCardState get state {
    assert(
      _state != null,
      'Controller not attached to any FlipCard. Did you forget to pass the controller to the FlipCard?',
    );
    return _state!;
  }

  CardSide get oppositeSide => state.getOppositeSide();

  set state(FlipCardState? value) => _state = value;

  Future flip({CardSide? side}) => state.flip(side);

  void flipWithoutAnimation([CardSide? targetSide]) => state.flipWithoutAnimation(targetSide);
}
