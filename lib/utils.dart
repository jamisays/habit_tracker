import 'dart:collection';

import 'package:habit_tracker/models/goodHabit.dart';

import 'package:hive/hive.dart';

import 'package:table_calendar/table_calendar.dart';

import 'models/event.dart';
import 'models/eventSource.dart';

/// Example event class.

// void fetchAndSetEvents() {
//   Hive.openBox<EventSource>('event_source').then((value) {
//     if (value.values.isNotEmpty) {
//       kEvents = value.values.first.eventSource;
//     }
//   });
//   print('fetch method!');
// }

void openEventBox() async {
  Hive.openBox<EventSource>('event_source').then((value) {
    if (value.values.isNotEmpty) {
      kEvents = value.values.first.eventSource!;
    }
  }).catchError((error, _) => null);
}

void saveEventToHive() {
  var box = Hive.box<EventSource>('event_source');
  var x = EventSource(kEvents);
  box.putAt(0, x);
}

void clearDB() {
  var box = Hive.box<EventSource>('event_source');
  var kEvents = LinkedHashMap<DateTime, List<Event>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  var x = EventSource(kEvents);
  box.putAt(0, x);
}

void addGoodToEvent(GoodHabit newHt) {
  print(newHt.selectedScheduleType);
  if (newHt.selectedScheduleType == 'fix') {
    for (var item in newHt.habitDays!) {
      addFixedDayToEvents(item, 12, newHt);
    }
  } else if (newHt.selectedScheduleType == 'rep') {
    addRepDaysToEvents(newHt);
  } else {
    addFlexDaysToEvents(newHt);
  }
  Hive.openBox<EventSource>('event_source').then((value) {
    var x = EventSource(kEvents);
    value.put(0, x);
  });
}

void addFixedDayToEvents(String day, int weeks, GoodHabit newHt) {
  int y = 0;
  bool firstTime = true;
  for (int i = 0; i < weeks; i++) {
    // print(day);
    switch (day) {
      case 'sat':
        {
          if (firstTime) {
            var x = newHt.startDate;
            for (var j = x;
                j.month != x.month + 1;
                j = j.add(Duration(days: 1))) {
              if (j.weekday == DateTime.saturday &&
                  j.day >= newHt.startDate.day) {
                y = j.day;
                firstTime = false;
                break;
              }
            }
          }
          var key = DateTime.utc(
              newHt.startDate.year, newHt.startDate.month, y + (i * 7));
          kEvents.containsKey(key)
              ? kEvents[key]!.add(Event(newHt.title, newHt.timesDay!))
              : kEvents[key] = [Event(newHt.title, newHt.timesDay!)];
        }
        // print(kEvents[newHt.startDate]);
        break;
      case 'sun':
        {
          bool firstTime = true;

          if (firstTime) {
            var x = newHt.startDate;
            for (var j = x;
                j.month != x.month + 1;
                j = j.add(Duration(days: 1))) {
              if (j.weekday == DateTime.sunday &&
                  j.day >= newHt.startDate.day) {
                y = j.day;
                firstTime = false;
                break;
              }
            }
          }
          var key = DateTime.utc(
              newHt.startDate.year, newHt.startDate.month, y + (i * 7));
          kEvents.containsKey(key)
              ? kEvents[key]!.add(Event(newHt.title, newHt.timesDay!))
              : kEvents[key] = [Event(newHt.title, newHt.timesDay!)];
        }
        break;
      case 'mon':
        {
          bool firstTime = true;

          if (firstTime) {
            var x = newHt.startDate;
            for (var j = x;
                j.month != x.month + 1;
                j = j.add(Duration(days: 1))) {
              if (j.weekday == DateTime.monday &&
                  j.day >= newHt.startDate.day) {
                y = j.day;
                firstTime = false;
                break;
              }
            }
          }
          var key = DateTime.utc(
              newHt.startDate.year, newHt.startDate.month, y + (i * 7));
          kEvents.containsKey(key)
              ? kEvents[key]!.add(Event(newHt.title, newHt.timesDay!))
              : kEvents[key] = [Event(newHt.title, newHt.timesDay!)];
        }
        break;
      case 'tue':
        {
          bool firstTime = true;

          if (firstTime) {
            var x = newHt.startDate;
            for (var j = x;
                j.month != x.month + 1;
                j = j.add(Duration(days: 1))) {
              if (j.weekday == DateTime.tuesday &&
                  j.day >= newHt.startDate.day) {
                y = j.day;
                firstTime = false;
                break;
              }
            }
          }
          var key = DateTime.utc(
              newHt.startDate.year, newHt.startDate.month, y + (i * 7));
          kEvents.containsKey(key)
              ? kEvents[key]!.add(Event(newHt.title, newHt.timesDay!))
              : kEvents[key] = [Event(newHt.title, newHt.timesDay!)];
        }
        break;
      case 'wed':
        {
          bool firstTime = true;

          if (firstTime) {
            var x = newHt.startDate;
            for (var j = x;
                j.month != x.month + 1;
                j = j.add(Duration(days: 1))) {
              if (j.weekday == DateTime.wednesday &&
                  j.day >= newHt.startDate.day) {
                y = j.day;
                firstTime = false;
                break;
              }
            }
          }
          var key = DateTime.utc(
              newHt.startDate.year, newHt.startDate.month, y + (i * 7));
          kEvents.containsKey(key)
              ? kEvents[key]!.add(Event(newHt.title, newHt.timesDay!))
              : kEvents[key] = [Event(newHt.title, newHt.timesDay!)];
        }
        break;
      case 'thu':
        {
          bool firstTime = true;

          if (firstTime) {
            var x = newHt.startDate;
            for (var j = x;
                j.month != x.month + 1;
                j = j.add(Duration(days: 1))) {
              if (j.weekday == DateTime.thursday &&
                  j.day >= newHt.startDate.day) {
                y = j.day;
                firstTime = false;
                break;
              }
            }
          }
          var key = DateTime.utc(
              newHt.startDate.year, newHt.startDate.month, y + (i * 7));
          kEvents.containsKey(key)
              ? kEvents[key]!.add(Event(newHt.title, newHt.timesDay!))
              : kEvents[key] = [Event(newHt.title, newHt.timesDay!)];
        }
        break;
      case 'fri':
        {
          bool firstTime = true;

          if (firstTime) {
            var x = newHt.startDate;
            for (var j = x;
                j.month != x.month + 1;
                j = j.add(Duration(days: 1))) {
              if (j.weekday == DateTime.friday &&
                  j.day >= newHt.startDate.day) {
                y = j.day;
                firstTime = false;
                break;
              }
            }
          }
          var key = DateTime.utc(
              newHt.startDate.year, newHt.startDate.month, y + (i * 7));
          kEvents.containsKey(key)
              ? kEvents[key]!.add(Event(newHt.title, newHt.timesDay!))
              : kEvents[key] = [Event(newHt.title, newHt.timesDay!)];
        }
        break;
    }
  }
}

void addRepDaysToEvents(GoodHabit newHt) {
  var repDays = newHt.repDays;
  for (var y = newHt.startDate.day;
      y != newHt.startDate.day + 180;
      y += repDays! + 1) {
    var key = DateTime.utc(newHt.startDate.year, newHt.startDate.month, y);
    kEvents.containsKey(key)
        ? kEvents[key]!.add(Event(newHt.title, newHt.timesDay!))
        : kEvents[key] = [Event(newHt.title, newHt.timesDay!)];
  }
}

void addFlexDaysToEvents(GoodHabit newHt) {}

void removeFixedDayFromEvents(String day, int weeks, GoodHabit oldHt) {
  int y = 0;
  bool firstTime = true;
  for (int i = 0; i < weeks; i++) {
    // print(day);
    switch (day) {
      case 'sat':
        {
          // var x = DateTime.now();
          var x = oldHt.startDate;
          if (firstTime) {
            for (var j = x;
                j.month != x.month + 1;
                j = j.add(Duration(days: 1))) {
              if (j.weekday == DateTime.saturday && j.day >= x.day) {
                y = j.day;
                firstTime = false;
                break;
              }
            }
          }
          var key = DateTime.utc(x.year, x.month, y + (i * 7));
          if (kEvents.containsKey(key))
            kEvents[key]!
                .removeWhere((element) => element.title == oldHt.title);
        }
        // print(kEvents[newHt.startDate]);
        break;
      case 'sun':
        {
          bool firstTime = true;
          // var x = DateTime.now();
          var x = oldHt.startDate;
          if (firstTime) {
            for (var j = x;
                j.month != x.month + 1;
                j = j.add(Duration(days: 1))) {
              if (j.weekday == DateTime.sunday && j.day >= x.day) {
                y = j.day;
                firstTime = false;
                break;
              }
            }
          }
          var key = DateTime.utc(x.year, x.month, y + (i * 7));
          if (kEvents.containsKey(key))
            kEvents[key]!
                .removeWhere((element) => element.title == oldHt.title);
        }
        break;
      case 'mon':
        {
          bool firstTime = true;
          // var x = DateTime.now();
          var x = oldHt.startDate;
          if (firstTime) {
            for (var j = x;
                j.month != x.month + 1;
                j = j.add(Duration(days: 1))) {
              if (j.weekday == DateTime.monday && j.day >= x.day) {
                y = j.day;
                firstTime = false;
                break;
              }
            }
          }
          var key = DateTime.utc(x.year, x.month, y + (i * 7));
          if (kEvents.containsKey(key))
            kEvents[key]!
                .removeWhere((element) => element.title == oldHt.title);
        }
        break;
      case 'tue':
        {
          bool firstTime = true;
          // var x = DateTime.now();
          var x = oldHt.startDate;
          if (firstTime) {
            for (var j = x;
                j.month != x.month + 1;
                j = j.add(Duration(days: 1))) {
              if (j.weekday == DateTime.tuesday && j.day >= x.day) {
                y = j.day;
                firstTime = false;
                break;
              }
            }
          }
          var key = DateTime.utc(x.year, x.month, y + (i * 7));
          if (kEvents.containsKey(key))
            kEvents[key]!
                .removeWhere((element) => element.title == oldHt.title);
        }
        break;
      case 'wed':
        {
          bool firstTime = true;
          // var x = DateTime.now();
          var x = oldHt.startDate;
          if (firstTime) {
            for (var j = x;
                j.month != x.month + 1;
                j = j.add(Duration(days: 1))) {
              if (j.weekday == DateTime.wednesday && j.day >= x.day) {
                y = j.day;
                firstTime = false;
                break;
              }
            }
          }
          var key = DateTime.utc(x.year, x.month, y + (i * 7));
          if (kEvents.containsKey(key))
            kEvents[key]!
                .removeWhere((element) => element.title == oldHt.title);
        }
        break;
      case 'thu':
        {
          bool firstTime = true;
          // var x = DateTime.now();
          var x = oldHt.startDate;
          if (firstTime) {
            for (var j = x;
                j.month != x.month + 1;
                j = j.add(Duration(days: 1))) {
              if (j.weekday == DateTime.thursday && j.day >= x.day) {
                y = j.day;
                firstTime = false;
                break;
              }
            }
          }
          var key = DateTime.utc(x.year, x.month, y + (i * 7));
          if (kEvents.containsKey(key))
            kEvents[key]!
                .removeWhere((element) => element.title == oldHt.title);
        }
        break;
      case 'fri':
        {
          bool firstTime = true;
          // var x = DateTime.now();
          var x = oldHt.startDate;
          if (firstTime) {
            for (var j = x;
                j.month != x.month + 1;
                j = j.add(Duration(days: 1))) {
              if (j.weekday == DateTime.friday && j.day >= x.day) {
                y = j.day;
                firstTime = false;
                break;
              }
            }
          }
          var key = DateTime.utc(x.year, x.month, y + (i * 7));
          if (kEvents.containsKey(key)) {
            print('keys found!');
            kEvents[key]!
                .removeWhere((element) => element.title == oldHt.title);
          }
        }
        break;
    }
  }
}

void removeRepDaysFromEvents(GoodHabit old) {
  var repDays = old.repDays;
  for (var y = old.startDate.day;
      y != old.startDate.day + 180;
      y += repDays! + 1) {
    var key = DateTime.utc(old.startDate.year, old.startDate.month, y);
    if (kEvents.containsKey(key))
      kEvents[key]!.removeWhere((element) => element.title == old.title);
  }
}

void removeFlexDaysFromEvents() {}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.

var kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
);

var kEventSource = Map<DateTime, List<Event>>();

// var kEventSource = Map.fromIterable(List.generate(50, (index) => index),
//     key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
//     value: (item) => List.generate(
//         item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
//   ..addAll({
//     kToday: [
//       Event('Today\'s Event 1'),
//       Event('Today\'s Event 2'),
//     ],
//   });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
