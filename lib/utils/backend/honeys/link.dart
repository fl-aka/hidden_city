import 'dart:typed_data';
import 'package:hive/hive.dart';
part 'link.g.dart';

@HiveType(typeId: 2)
class Link {
  @HiveField(0)
  String route;
  @HiveField(1)
  Uint8List? bitImg;
  Link(this.route, {this.bitImg});
}
