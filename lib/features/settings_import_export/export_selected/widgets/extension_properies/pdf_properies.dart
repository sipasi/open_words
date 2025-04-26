import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/settings_import_export/export_selected/bloc/export_selected_bloc.dart';
import 'package:open_words/shared/modal/color_list_modal.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class PdfProperies extends StatelessWidget {
  const PdfProperies({super.key});

  @override
  Widget build(BuildContext context) {
    final properties = context.select(
      (ExportSelectedBloc value) => value.state.pdfProperties,
    );

    final bloc = context.read<ExportSelectedBloc>();

    final bold = TextStyle(fontWeight: FontWeight.bold);

    return Card(
      clipBehavior: Clip.antiAlias,
      color: context.colorScheme.primaryContainer,
      child: Column(
        children: [
          SwitchListTile(
            title: Text('Black & White Print', style: bold),
            subtitle: Text(
              'When enabled, the document will print in black and white.',
            ),
            value: properties.printing,
            onChanged: (value) {
              bloc.add(ExportSelectedPdfChanged(printing: value));
            },
          ),
          if (!properties.printing)
            SwitchListTile(
              title: Text('Dark Pdf Background', style: bold),
              subtitle: Text(
                'When enabled, the background of the PDF will appear dark',
              ),
              value: properties.darkBackground,
              onChanged: (value) {
                bloc.add(ExportSelectedPdfChanged(darkBackground: value));
              },
            ),
          if (!properties.printing)
            ListTile(
              title: Text('Document Color Scheme', style: bold),
              subtitle: Text(
                'Choose the overall color scheme for the document',
              ),
              trailing: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colorScheme.surface,
                ),
                child: Icon(
                  Icons.palette_outlined,
                  color: properties.colorScheme.color,
                ),
              ),
              onTap: () async {
                final color = await ColorListModal.dialog(
                  context: context,
                  current: properties.colorScheme,
                );

                bloc.add(ExportSelectedPdfChanged(colorScheme: color));
              },
            ),
        ],
      ),
    );
  }
}
