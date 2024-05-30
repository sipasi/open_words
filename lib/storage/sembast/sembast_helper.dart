import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path_provider;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

class SembastHelper {
  static Future<Database> openOnDevice(String name) async {
    // get the application documents directory
    var directory = await path_provider.getApplicationDocumentsDirectory();
    // make sure it exists
    await directory.create(recursive: true);
    // build the database path
    var path = path_provider.join(directory.path, '$name.db');
    // open the database
    return await databaseFactoryIo.openDatabase(path);
  }

  static Future<Database> openOnWeb(String name) => databaseFactoryWeb.openDatabase('open_words_web');

  static Future<Database> openForCurrentPlatform(String name) =>
      kIsWeb ? SembastHelper.openOnWeb(name) : SembastHelper.openOnDevice(name);
}
