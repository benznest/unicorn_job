// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 2;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      jobId: fields[7] as int?,
      number: fields[6] as int?,
      launched: fields[5] as bool?,
    )
      ..id = fields[0] as int
      ..title = fields[1] as String
      ..dateTime = fields[2] as DateTime
      ..workingDirectory = fields[3] as String
      ..commands = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.dateTime)
      ..writeByte(3)
      ..write(obj.workingDirectory)
      ..writeByte(4)
      ..write(obj.commands)
      ..writeByte(5)
      ..write(obj.launched)
      ..writeByte(6)
      ..write(obj.number)
      ..writeByte(7)
      ..write(obj.jobId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}