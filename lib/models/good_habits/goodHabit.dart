// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'goodHabit.g.dart';

@HiveType(typeId: 2)
enum Difficulty {
  @HiveField(0)
  Easy,
  @HiveField(1)
  Medium,
  @HiveField(2)
  Hard,
}

@HiveType(typeId: 0)
class GoodHabit {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String? category;
  @HiveField(2)
  String title;
  @HiveField(3)
  late DateTime startDate;
  @HiveField(4)
  final List<String>? cues;
  @HiveField(5)
  int? duration;
  @HiveField(6)
  String? difficultyLevel;
  @HiveField(7)
  String selectedScheduleType;
  @HiveField(8)
  List<String>? habitDays;
  @HiveField(9)
  int? flexDays;
  @HiveField(10)
  String? flexPerTime;
  @HiveField(11)
  int? repDays;
  @HiveField(12)
  int? timesDay;
  @HiveField(13)
  bool isActive;
  @HiveField(14)
  final int? tempSpirit;
  @HiveField(15)
  final bool? isCustom;

  GoodHabit({
    required this.id,
    this.category,
    required this.title,
    required this.startDate,
    this.cues,
    required this.duration,
    this.difficultyLevel,
    required this.selectedScheduleType,
    this.habitDays,
    this.flexDays,
    this.flexPerTime,
    this.repDays,
    this.timesDay,
    required this.isActive,
    this.tempSpirit,
    this.isCustom,
  });
}

// class Meal {
//   final String id;
//   final List<String> categories;
//   final String title;
//   final String imageUrl;
//   final List<String> ingredients;
//   final List<String> steps;
//   final int duration;
//   final Complexity complexity;
//   final Affordability affordability;
//   final bool isGlutenFree;
//   final bool isLactoseFree;
//   final bool isVegan;
//   final bool isVegetarian;

//   const Meal({
//     @required this.id,
//     @required this.categories,
//     @required this.title,
//     @required this.imageUrl,
//     @required this.ingredients,
//     @required this.steps,
//     @required this.duration,
//     @required this.complexity,
//     @required this.affordability,
//     @required this.isGlutenFree,
//     @required this.isLactoseFree,
//     @required this.isVegan,
//     @required this.isVegetarian,
//   });
// }