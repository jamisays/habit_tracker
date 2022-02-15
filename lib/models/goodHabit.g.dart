// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goodHabit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoodHabitAdapter extends TypeAdapter<GoodHabit> {
  @override
  final int typeId = 0;

  @override
  GoodHabit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GoodHabit(
      id: fields[0] as String,
      category: fields[1] as String?,
      title: fields[2] as String,
      startDate: fields[3] as DateTime,
      cues: (fields[4] as List?)?.cast<String>(),
      duration: fields[5] as int?,
      difficultyLevel: fields[6] as String?,
      selectedScheduleType: fields[7] as String,
      habitDays: (fields[8] as List?)?.cast<String>(),
      flexDays: fields[9] as int?,
      flexPerTime: fields[10] as String?,
      repDays: fields[11] as int?,
      timesDay: fields[12] as int?,
      isActive: fields[13] as bool,
      tempSpirit: fields[14] as int?,
      isCustom: fields[15] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, GoodHabit obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.startDate)
      ..writeByte(4)
      ..write(obj.cues)
      ..writeByte(5)
      ..write(obj.duration)
      ..writeByte(6)
      ..write(obj.difficultyLevel)
      ..writeByte(7)
      ..write(obj.selectedScheduleType)
      ..writeByte(8)
      ..write(obj.habitDays)
      ..writeByte(9)
      ..write(obj.flexDays)
      ..writeByte(10)
      ..write(obj.flexPerTime)
      ..writeByte(11)
      ..write(obj.repDays)
      ..writeByte(12)
      ..write(obj.timesDay)
      ..writeByte(13)
      ..write(obj.isActive)
      ..writeByte(14)
      ..write(obj.tempSpirit)
      ..writeByte(15)
      ..write(obj.isCustom);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoodHabitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DifficultyAdapter extends TypeAdapter<Difficulty> {
  @override
  final int typeId = 2;

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
