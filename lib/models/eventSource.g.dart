// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eventSource.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventSourceAdapter extends TypeAdapter<EventSource> {
  @override
  final int typeId = 5;

  @override
  EventSource read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EventSource(
      (fields[0] as Map?)?.map((dynamic k, dynamic v) =>
              MapEntry(k as DateTime, (v as List).cast<Event>()))
          as LinkedHashMap<DateTime, List<Event>>?,
    );
  }

  @override
  void write(BinaryWriter writer, EventSource obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.eventSource);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventSourceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
