import 'package:flutter/material.dart';
import 'package:open_words/features/database/database_info_page.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class DatabaseInfoOpenTile extends StatelessWidget {
  const DatabaseInfoOpenTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.storage_outlined),
      title: OutlinedButton(
        onPressed: () {
          context.push((context) => DatabaseInfoPage());
        },
        child: Text('Open database info'),
      ),
    );
  }
}
