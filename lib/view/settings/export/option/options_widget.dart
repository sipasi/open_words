import 'package:flutter/material.dart';
import 'package:open_words/service/export/formatter/format_options.dart';

abstract class OptionsWidget extends Widget {
  const OptionsWidget({super.key});

  FormatOptions getOptions();
}
