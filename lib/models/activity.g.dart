// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActivityAdapter extends TypeAdapter<Activity> {
  @override
  final int typeId = 0;

  @override
  Activity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Activity(
      id: fields[0] as String,
      name: fields[1] as String,
      duration: fields[2] as String,
      time: fields[3] as String,
      details: fields[4] as String,
      tag: fields[5] as String,
      added: fields[6] as String,
      updated: fields[7] as String,
      activityRecord: (fields[8] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Activity obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.details)
      ..writeByte(5)
      ..write(obj.tag)
      ..writeByte(6)
      ..write(obj.added)
      ..writeByte(7)
      ..write(obj.updated)
      ..writeByte(8)
      ..write(obj.activityRecord);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
