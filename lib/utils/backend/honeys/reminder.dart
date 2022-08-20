import 'package:hive/hive.dart';
part 'reminder.g.dart';

@HiveType(typeId: 1)
class Pieces {
  @HiveField(0)
  int col;

  Pieces(
    this.col,
  );
}
