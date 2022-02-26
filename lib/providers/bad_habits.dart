import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

import 'package:habit_tracker/models/bad_habits/badHabit.dart';
import 'package:habit_tracker/widgets/bad_habits/my_new_bad_habit.dart';

class BadHabits extends ChangeNotifier {
  List<BadHabit> _badHabits = [
    // BadHabit(
    //   id: DateTime.utc(2020, 1, 1, 0, 0, 1).toString(),
    //   title: 'Test 1',
    //   createDate: DateTime.utc(2021, 11, 5, 0, 0, 1),
    //   isActive: true,
    //   timesType: 'Daily',
    //   timesDay: 1,
    //   relapsedDaysList: [
    //     DateTime.utc(2021, 11, 10, 0, 0, 1),
    //     DateTime.utc(2021, 11, 15, 0, 0, 1),
    //     DateTime.utc(2021, 11, 17, 0, 0, 1),
    //     DateTime.utc(2021, 11, 17, 0, 0, 1),
    //     DateTime.utc(2021, 11, 17, 0, 0, 1),
    //     DateTime.utc(2021, 11, 25, 0, 0, 1),
    //     DateTime.utc(2021, 11, 27, 0, 0, 1),
    //     DateTime.utc(2021, 12, 4, 0, 0, 1),
    //     DateTime.utc(2021, 12, 14, 0, 0, 1),
    //     DateTime.utc(2021, 12, 25, 0, 0, 1),
    //   ],
    //   relapsedReasons: {},
    //   lastDate: DateTime.utc(2021, 12, 25, 0, 0, 1),
    // )
  ];

  Future<void> fetchAndSetBadHabits() async {
    final box = await Hive.openBox<BadHabit>('bad_habits');

    // box.values.map((e) => goodHabits.add(e));

    if (_badHabits.isEmpty) {
      for (var item in box.values) {
        _badHabits.add(item);
      }
    }

    print(box.values.length);
    print(_badHabits.length);
    box.close();
  }

  void _addNewBadHabit(
    String htTitle,
    List<String> htReason,
    String doneFrequency,
    int timesDay,
    int costPerTime,
    String difficultyLevel,
    DateTime createDate,
  ) {
    List<DateTime> tempRelapsedDate = [];
    Map<DateTime, String> tempRelaspedReasons = {};
    // tempRelapsedDate.add(createDate);
    // tempRelaspedReasons[createDate] = ' ';
    final newHt = BadHabit(
      id: DateTime.now().toString(),
      title: htTitle,
      reasons: htReason,
      timesType: doneFrequency,
      timesDay: timesDay,
      costPerTime: costPerTime,
      difficultyLevel: difficultyLevel,
      createDate: createDate,
      // duration: calculatedDuration,
      isActive: true,
      relapsedDaysList: tempRelapsedDate,
      relapsedReasons: tempRelaspedReasons,
      lastDate: createDate,
      // difficultyLevel: selectedDifficultyLevel,
    );

    // setState(() {

    Hive.openBox<BadHabit>('bad_habits').then((value) {
      value.put(newHt.id, newHt);
      value.close();
    });

    // Hive.box('bad_habits').put(newHt.id, newHt);
    _badHabits.add(newHt);
    notifyListeners();

    // });
  }

  void startAddNewBadHabit(BuildContext ctx, bool isCustom, String myTitle) {
    // showModalBottomSheet(
    //     context: ctx,
    //     builder: (bCtx) {
    //       return MyNewBadHabit(_addNewBadHabit, isCustom, myTitle);
    //     });
    Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (ctx) => MyNewBadHabit(_addNewBadHabit, isCustom, myTitle),
        ));
    notifyListeners();
  }

  void updateBadHabit(String id, BadHabit badHabit) {
    final habitIndex = badItems.indexWhere((element) => element.id == id);
    if (habitIndex >= 0) {
      _badHabits[habitIndex] = badHabit;
    }

    Hive.openBox('bad_habits').then((value) {
      value.put(id, badHabit);
      value.close();
    });

    notifyListeners();
  }

  void badRelapsed(String id, DateTime time, String? reason) {
    var item = _badHabits.firstWhere((element) => element.id == id);
    item.relapsedDaysList.add(time);
    if (reason == null) {
      item.relapsedReasons[time] = ' ';
    } else {
      item.relapsedReasons[time] = reason;
    }
    item.lastDate = time;

    var index = _badHabits.indexWhere((element) => element.id == id);
    _badHabits[index] = item;
    Hive.openBox<BadHabit>('bad_habits').then(
      (value) {
        value.put(id, item);
        value.close();
      },
    );
    notifyListeners();
  }

  void deleteBadHabit(String id) {
    // setState(() {
    _badHabits.removeWhere((ht) => ht.id == id);
    Hive.openBox('bad_habits').then((value) {
      value.delete(id);
      value.close();
    });
    // Hive.box('bad_habits').delete(id);
    notifyListeners();
    // });
  }

  List<BadHabit> get badItems {
    return [..._badHabits];
  }

  void addBadHabit() {
    notifyListeners();
  }
}
