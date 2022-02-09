// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badHabit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BadHabitAdapter extends TypeAdapter<BadHabit> {
  @override
  final int typeId = 1;

  @override
  BadHabit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BadHabit(
      id: fields[0] as String,
      category: fields[1] as String?,
      title: fields[2] as String,
      createDate: fields[3] as DateTime,
      reasons: (fields[4] as List?)?.cast<String>(),
      duration: fields[5] as int?,
      difficultyLevel: fields[6] as String?,
      isActive: fields[7] as bool,
      isCustom: fields[8] as bool?,
      timesType: fields[9] as String,
      timesDay: fields[10] as int?,
      costPerTime: fields[11] as int?,
      relapsedDaysList: (fields[12] as List).cast<DateTime>(),
      relapsedReasons: (fields[13] as Map).cast<DateTime, String>(),
      lastDate: fields[14] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, BadHabit obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.createDate)
      ..writeByte(4)
      ..write(obj.reasons)
      ..writeByte(5)
      ..write(obj.duration)
      ..writeByte(6)
      ..write(obj.difficultyLevel)
      ..writeByte(7)
      ..write(obj.isActive)
      ..writeByte(8)
      ..write(obj.isCustom)
      ..writeByte(9)
      ..write(obj.timesType)
      ..writeByte(10)
      ..write(obj.timesDay)
      ..writeByte(11)
      ..write(obj.costPerTime)
      ..writeByte(12)
      ..write(obj.relapsedDaysList)
      ..writeByte(13)
      ..write(obj.relapsedReasons)
      ..writeByte(14)
      ..write(obj.lastDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BadHabitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DifficultyAdapter extends TypeAdapter<Difficulty> {
  @override
  final int typeId = 3;

  @override
  Difficulty read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Difficulty.Easy;
      case 1:
        return Difficulty.Medium;
      case 2:
        return Difficulty.Hard;
      default:
        return Difficulty.Easy;
    }
  }

  @override
  void write(BinaryWriter writer, Difficulty obj) {
    switch (obj) {
      case Difficulty.Easy:
        writer.writeByte(0);
        break;
      case Difficulty.Medium:
        writer.writeByte(1);
        break;
      case Difficulty.Hard:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DifficultyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
