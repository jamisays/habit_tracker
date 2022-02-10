import 'package:flutter/material.dart';
import 'package:habit_tracker/models/eventSource.dart';
import 'package:habit_tracker/utils.dart';
// import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

import 'package:habit_tracker/models/badHabit.dart';
import 'package:habit_tracker/widgets/my_new_good_habit.dart' as gh;
import 'package:habit_tracker/widgets/my_new_bad_habit.dart';
import '../models/goodHabit.dart';

class Habits with ChangeNotifier {
  List<GoodHabit> goodHabits = [
    // GoodHabit(
    //   id: 'dsf233',
    //   title: 'Prayer',
    //   startDate: DateTime.parse("2021-08-01 00:00:02Z"),
    //   duration: 34,
    //   selectedScheduleType: 'Fixed',
    //   habitDays: ['sat', 'sun', 'mon', 'tue', 'wed', 'thu', 'fri'],
    //   timesDay: 5,
    // ),
    // GoodHabit(
    //   id: 'dsf234',
    //   title: 'Mas 2',
    //   startDate: DateTime.parse("2021-08-01 00:00:02Z"),
    //   duration: 34,
    //   selectedScheduleType: 'Flexible',
    //   flexDays: 4,
    //   flexPerTime: 'Month',
    //   timesDay: 5,
    // ),
    // GoodHabit(
    //   id: 'dsf235',
    //   title: 'Mas 3',
    //   startDate: DateTime.parse("2021-08-01 00:00:02Z"),
    //   duration: 34,
    //   selectedScheduleType: 'Repeating',
    //   repDays: 3,
    //   timesDay: 5,
    // )
  ];
  List<BadHabit> _badHabits = [
    BadHabit(
      id: DateTime.utc(2020, 1, 1, 0, 0, 1).toString(),
      title: 'Test 1',
      createDate: DateTime.utc(2021, 11, 5, 0, 0, 1),
      isActive: true,
      timesType: 'Daily',
      timesDay: 1,
      relapsedDaysList: [
        DateTime.utc(2021, 11, 10, 0, 0, 1),
        DateTime.utc(2021, 11, 15, 0, 0, 1),
        DateTime.utc(2021, 11, 17, 0, 0, 1),
        DateTime.utc(2021, 11, 17, 0, 0, 1),
        DateTime.utc(2021, 11, 17, 0, 0, 1),
        DateTime.utc(2021, 11, 25, 0, 0, 1),
        DateTime.utc(2021, 11, 27, 0, 0, 1),
        DateTime.utc(2021, 12, 4, 0, 0, 1),
        DateTime.utc(2021, 12, 14, 0, 0, 1),
        DateTime.utc(2021, 12, 25, 0, 0, 1),
      ],
      relapsedReasons: {},
      lastDate: DateTime.utc(2021, 12, 25, 0, 0, 1),
    )
  ];

  // auth

  String? authToken;

  void updateTokenAndGoodHabit(
    String? authToken2,
    List<GoodHabit> updatedUserGoodHabit,
  ) {
    authToken = authToken2;
    goodHabits = updatedUserGoodHabit;
  }

  // GOOD HABITS

  Future<void> fetchAndSetGoodHabits() async {
    final box = await Hive.openBox<GoodHabit>('good_habits');

    // box.values.map((e) => goodHabits.add(e));

    if (goodHabits.isEmpty) {
      for (var item in box.values) {
        goodHabits.add(item);
      }
    }

    print(box.values.length);
    print(goodHabits.length);
    box.close();
    // notifyListeners();
  }

  // int findTimesPerDay(String habitName) {
  //   goodHabits.forEach((element) {
  //     if (element.title == habitName) return element.timesDay;
  //   });
  // }

  Future<void> _addNewGoodHabit(
      String htTitle,
      // int htDuration,
      String selectedScheduleType,
      List? habitDays,
      int flexDays,
      String flexPerTime,
      int repDays,
      int timesDay,
      DateTime chosenDate,
      int calculatedDuration,
      String selectedDifficultyLevel) async {
    // final url =
    //     'https://habit-tracker-1-default-rtdb.firebaseio.com/habits.json?auth=$authToken';

    try {
      // This block also should run when no error

      final newHt = GoodHabit(
        title: htTitle,
        // karmaPoint: htDuration,
        selectedScheduleType: selectedScheduleType,
        habitDays: habitDays as List<String>,
        flexDays: flexDays,
        flexPerTime: flexPerTime,
        repDays: repDays,
        timesDay: timesDay,
        difficultyLevel: selectedDifficultyLevel,
        startDate: chosenDate,
        isActive: true,
        // id: DateTime.now().toString(),
        id: DateTime.now().toString(),
        duration: calculatedDuration,
        // difficultyLevel: selectedDifficultyLevel,
      );
      // setState(() {

      // Hive

      Hive.openBox('good_habits').then((value) {
        value.put(newHt.id, newHt);
        value.close();
      });
      goodHabits.add(newHt);

      addGoodToEvent(newHt);

      // addTimesDayToData(newHt)

      notifyListeners();

      // Hive -- end

    } catch (error) {
      throw error;
    }
  }

  void startAddNewGoodHabit(BuildContext ctx, bool isCustom, String myTitle) {
    Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (ctx) =>
              gh.MyNewGoodHabit(_addNewGoodHabit, isCustom, myTitle),
        ));
    notifyListeners();
  }

  void updateGoodHabit(String id, GoodHabit goodHabit) async {
    print('inside update');
    final habitIndex = goodItems.indexWhere((element) => element.id == id);
    if (habitIndex >= 0) {
      goodHabits[habitIndex] = goodHabit;
    }
    // goodItems[habitIndex] = goodHabit;
    Hive.openBox('good_habits').then((value) {
      // remove events - start
      var old = value.get(id);

      if (old.selectedScheduleType == 'fix') {
        for (var item in old.habitDays) {
          removeFixedDayFromEvents(item, 12, old);
        }
      } else if (old.selectedScheduleType == 'rep') {
        removeRepDaysFromEvents(old);
      } else {
        // removeFlexDaysFromEvents(old);
      }
      addGoodToEvent(goodHabit);
      value.put(id, goodHabit);
      value.close();
    });

    Hive.openBox<EventSource>('event_source').then((value) {
      var x = EventSource(kEvents);
      value.putAt(0, x);
    });
    // remove events - end

    notifyListeners();
  }

  void deleteGoodHabit(String id, int index) {
    // setState(() {
    goodHabits.removeWhere((ht) => ht.id == id);
    Hive.openBox('good_habits').then((value) => value.get(id)).then((value) {
      if (value.selectedScheduleType == 'fix') {
        for (var item in value.habitDays) {
          removeFixedDayFromEvents(item, 12, value);
        }
      } else if (value.selectedScheduleType == 'rep') {
        removeRepDaysFromEvents(value);
      } else {
        // removeFlexDaysFromEvents(old);
      }
    });

    // var olda =
    //     Hive.box<GoodHabit>('good_habits').values.elementAt(int.parse(id));

    Hive.openBox('event_source').then((value) => value.put(0, kEvents));

    Hive.openBox('good_habits').then((value) => value.delete(id));

    notifyListeners();
    // });
  }

  List<GoodHabit> get goodItems {
    return [...goodHabits];
  }

  void addHabit() {
    notifyListeners();
  }

  // ------ BAD HABITS ------

  // Future<void> fetchAndSetBadHabits() async {
  //   final box = await Hive.openBox<BadHabit>('bad_habits').then((value) {
  //     if (_badHabits.isEmpty) {
  //       for (var item in value.values) {
  //         _badHabits.add(item);
  //         print(item.toString());
  //       }
  //     }
  //   }).catchError((error, _) => null);

  //   print(box.values.length);
  //   print(_badHabits.length);

  //   box.close();

  //   notifyListeners();
  // }

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
