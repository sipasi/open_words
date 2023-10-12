import 'package:path/path.dart' as path_provider;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class SembastHelper {
  static Future<Database> openDatabase() async {
    // get the application documents directory
    var directory = await path_provider.getApplicationDocumentsDirectory();
    // make sure it exists
    await directory.create(recursive: true);
    // build the database path
    var path = path_provider.join(directory.path, 'word_group_sembast.db');
    // open the database
    return await databaseFactoryIo.openDatabase(path);
  }
}
