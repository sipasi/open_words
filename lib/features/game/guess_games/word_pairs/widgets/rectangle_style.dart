import 'package:flutter/material.dart';

class RectangleStyle {
  const RectangleStyle._();

  static filled({double radius = 8}) {
    return FilledButton.styleFrom(shape: _radius(radius));
  }

  static outlined({double radius = 8}) {
    return OutlinedButton.styleFrom(shape: _radius(radius));
  }

  static _radius(double radius) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );
  }
}
