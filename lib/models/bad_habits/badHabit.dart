// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'badHabit.g.dart';

// generate adapter
// flutter packages pub run build_runner build

@HiveType(typeId: 3)
enum Difficulty {
  @HiveField(0)
  Easy,
  @HiveField(1)
  Medium,
  @HiveField(2)
  Hard,
}

@HiveType(typeId: 1)
class BadHabit {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String? category;
  @HiveField(2)
  String title;
  @HiveField(3)
  DateTime createDate;
  @HiveField(4)
  List<String>? reasons;
  @HiveField(5)
  int? duration;
  @HiveField(6)
  String? difficultyLevel;
  @HiveField(7)
  final bool isActive;
  @HiveField(8)
  final bool? isCustom;
  @HiveField(9)
  final String timesType; // done frequency
  @HiveField(10)
  final int? timesDay;
  @HiveField(11)
  final int? costPerTime;
  @HiveField(12)
  List<DateTime> relapsedDaysList;
  @HiveField(13)
  Map<DateTime, String> relapsedReasons;
  @HiveField(14)
  DateTime lastDate;

  BadHabit({
    required this.id,
    this.category,
    required this.title,
    required this.createDate,
    this.reasons,
    this.duration,
    this.difficultyLevel,
    required this.isActive,
    this.isCustom,
    required this.timesType,
    required this.timesDay,
    this.costPerTime,
    required this.relapsedDaysList,
    required this.relapsedReasons,
    required this.lastDate,
  });
}
