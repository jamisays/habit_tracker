import 'package:hive/hive.dart';

part 'event.g.dart';

@HiveType(typeId: 4)
class Event {
  @HiveField(0)
  final String title;
  @HiveField(1)
  bool isDone;
  @HiveField(2)
  int timesDay;
  @HiveField(3)
  int doneTimes;

  Event(this.title, this.timesDay, {this.isDone = false, this.doneTimes = 0});

  @override
  String toString() => title;
}
