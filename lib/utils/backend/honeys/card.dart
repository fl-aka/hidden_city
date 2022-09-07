import 'dart:typed_data';
import 'package:hive/hive.dart';
part 'card.g.dart';

@HiveType(typeId: 3)
class Cards {
  @HiveField(0)
  String name;
  @HiveField(1)
  Uint8List? logo;
  @HiveField(2)
  double saldo;
  @HiveField(3)
  bool isPaylater;
  @HiveField(4)
  double paylater;
  @HiveField(5)
  double maxPaylater;
  @HiveField(6)
  String website;
  @HiveField(7)
  DateTime forHis;
  Cards(this.name, this.logo, this.saldo, this.isPaylater, this.paylater,
      this.maxPaylater, this.website, this.forHis);
}

//flutter packages pub run build_runner build