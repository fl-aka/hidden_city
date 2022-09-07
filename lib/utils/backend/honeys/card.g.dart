// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardsAdapter extends TypeAdapter<Cards> {
  @override
  final int typeId = 3;

  @override
  Cards read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cards(
      fields[0] as String,
      fields[1] as Uint8List?,
      fields[2] as double,
      fields[3] as bool,
      fields[4] as double,
      fields[5] as double,
      fields[6] as String,
      fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Cards obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.logo)
      ..writeByte(2)
      ..write(obj.saldo)
      ..writeByte(3)
      ..write(obj.isPaylater)
      ..writeByte(4)
      ..write(obj.paylater)
      ..writeByte(5)
      ..write(obj.maxPaylater)
      ..writeByte(6)
      ..write(obj.website)
      ..writeByte(7)
      ..write(obj.forHis);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
