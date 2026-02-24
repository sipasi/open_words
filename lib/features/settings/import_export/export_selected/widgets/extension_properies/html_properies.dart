import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/settings/import_export/export_selected/bloc/export_selected_bloc.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class HtmlProperies extends StatelessWidget {
  const HtmlProperies({super.key});

  @override
  Widget build(BuildContext context) {
    final properties = context.select(
      (ExportSelectedBloc value) => value.state.htmlProperties,
    );

    final bloc = context.read<ExportSelectedBloc>();

    final bold = TextStyle(fontWeight: FontWeight.bold);

    return Card(
      clipBehavior: Clip.antiAlias,
      color: context.colorScheme.primaryContainer,
      child: Column(
        children: [
          SwitchListTile(
            title: Text('Remove Search Field', style: bold),
            subtitle: Text(
              'When enabled, you cannot search for words or dictionaries on the page',
            ),
            value: properties.removeSearchField,
            onChanged: (value) {
              bloc.add(ExportSelectedHtmlChanged(removeSearchField: value));
            },
          ),
        ],
      ),
    );
  }
}
