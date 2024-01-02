import 'dart:html' as html;

import 'package:open_words/service/export/save_provider/save_provider.dart';

class WebBrowserSaver extends SaveProvider {
  @override
  Future save(List<int> data, String path) async {
    final blob = html.Blob([data]);

    final url = html.Url.createObjectUrlFromBlob(blob);

    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = path;

    html.document.body?.children.add(anchor);

// download
    anchor.click();

// cleanup
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }
}
