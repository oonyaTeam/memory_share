// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserRecordAdapter extends TypeAdapter<UserRecord> {
  @override
  final int typeId = 1;

  @override
  UserRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserRecord(
      fields[0] as bool,
      fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserRecord obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.reExperienceTutorialDone)
      ..writeByte(1)
      ..write(obj.postTutorialDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
