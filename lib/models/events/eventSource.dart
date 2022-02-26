import 'dart:collection';

import 'package:hive/hive.dart';

import 'event.dart';

part 'eventSource.g.dart';

@HiveType(typeId: 5)
class EventSource {
  @HiveField(0)
  LinkedHashMap<DateTime, List<Event>>? eventSource;

  EventSource(this.eventSource);

  // LinkedHashMap<DateTime, List<Event>> get getES {
  //   return this.eventSource;
  // }
}
