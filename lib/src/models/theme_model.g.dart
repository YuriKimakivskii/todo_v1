// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ThemeModelAdapter extends TypeAdapter<ThemeModel> {
  @override
  final int typeId = 2;

  @override
  ThemeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ThemeModel()
      ..selectedPrimaryColor = fields[1] as int?
      ..selectedForegroundColor = fields[2] as int?;
  }

  @override
  void write(BinaryWriter writer, ThemeModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.selectedPrimaryColor)
      ..writeByte(2)
      ..write(obj.selectedForegroundColor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
