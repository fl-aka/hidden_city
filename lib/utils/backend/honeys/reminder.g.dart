// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PiecesAdapter extends TypeAdapter<Pieces> {
  @override
  final int typeId = 1;

  @override
  Pieces read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pieces(
      fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Pieces obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.col);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PiecesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
