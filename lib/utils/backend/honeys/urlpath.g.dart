// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'urlpath.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UrlPathAdapter extends TypeAdapter<UrlPath> {
  @override
  final int typeId = 0;

  @override
  UrlPath read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UrlPath(
      fields[1] as String,
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UrlPath obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.label)
      ..writeByte(1)
      ..write(obj.link);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UrlPathAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
