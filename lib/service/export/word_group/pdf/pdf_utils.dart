import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';

abstract class PdfUtils {
  static PdfColor toPdfColor(Color color) {
    return PdfColor(
      color.red / 255,
      color.green / 255,
      color.blue / 255,
      color.alpha / 255,
    );
  }

  static PdfColor? toPdfColorOrNull(Color? color) {
    if (color == null) {
      return null;
    }

    return PdfColor(
      color.red / 255,
      color.green / 255,
      color.blue / 255,
      color.alpha / 255,
    );
  }
}
