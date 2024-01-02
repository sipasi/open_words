import 'package:flutter/material.dart';
import 'package:open_words/service/export/formatter/format_options.dart';
import 'package:open_words/theme/color/color_seed.dart';
import 'package:open_words/theme/theme_storage.dart';
import 'package:open_words/view/settings/export/option/options_view_model.dart';
import 'package:open_words/view/settings/export/option/options_widget.dart';
import 'package:open_words/view/shared/dialog/color_list_dialog.dart';

class PdfOptions extends StatefulWidget implements OptionsWidget {
  final _viewmodel = PdfOptionsViewModel();

  PdfOptions({super.key});

  @override
  State<PdfOptions> createState() => _PdfOptionsState();

  @override
  FormatOptions getOptions() => _viewmodel.asOption();
}

class _PdfOptionsState extends State<PdfOptions> {
  @override
  void initState() {
    super.initState();

    widget._viewmodel.setColor(ThemeStorage.colorValue());
    widget._viewmodel.setMode(ThemeStorage.modeValue());
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = widget._viewmodel;

    return _cardWithPadding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      children: [
        ListTile(
          title: const Text('For printing'),
          trailing: Switch(
            value: viewmodel.print,
            onChanged: (value) {
              setState(() {
                viewmodel.setPrint(value);
              });
            },
          ),
        ),
        if (viewmodel.notPrint)
          _cardWithPadding(
            color: Theme.of(context).colorScheme.secondaryContainer,
            padding: const EdgeInsets.symmetric(vertical: 10),
            children: [
              ListTile(
                title: const Text('Dark'),
                trailing: Switch(
                  value: viewmodel.mode == ThemeMode.dark,
                  onChanged: (value) {
                    setState(() {
                      viewmodel.setMode(value ? ThemeMode.dark : ThemeMode.light);
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Color scheme'),
                trailing: Icon(
                  Icons.color_lens,
                  color: ColorSeed.values[viewmodel.color].color,
                ),
                onTap: () async {
                  ColorListDialog.show(
                    context: context,
                    current: ColorSeed.values[viewmodel.color],
                    selected: (value) => setState(() {
                      viewmodel.setColor(value.index);
                    }),
                  );
                },
              ),
            ],
          )
      ],
    );
  }

  Widget _cardWithPadding({required EdgeInsetsGeometry padding, required List<Widget> children, Color? color}) {
    return Card(
      color: color,
      child: Padding(
        padding: padding,
        child: Column(children: children),
      ),
    );
  }
}
