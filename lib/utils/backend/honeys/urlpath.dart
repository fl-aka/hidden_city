import 'package:hive/hive.dart';
part 'urlpath.g.dart';

@HiveType(typeId: 0)
class UrlPath {
  @HiveField(0)
  String label;

  @HiveField(1)
  String link;

  UrlPath(this.link, this.label);
}
