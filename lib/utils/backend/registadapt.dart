import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'honeys/link.dart';
import 'honeys/reminder.dart';
import 'honeys/urlpath.dart';

Future<void> regisTnAdpt() async {
  var appDoc = await path.getApplicationDocumentsDirectory();
  Hive.init(appDoc.path);

  Hive.registerAdapter(UrlPathAdapter());
  Hive.registerAdapter(LinkAdapter());
  Hive.registerAdapter(PiecesAdapter());
}
