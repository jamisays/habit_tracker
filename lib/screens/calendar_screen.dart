import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habit_tracker/models/eventSource.dart';
// import 'package:habit_tracker/models/goodHabit.dart';
import 'package:habit_tracker/widgets/calendar_header.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hive/hive.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../utils.dart';
import '../models/event.dart';
import '../widgets/volume_alert.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  PageController? _pageController;
  // final _howMuchController = TextEditingController();
  ValueNotifier<List<Event>>? _selectedEvents;
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  CalendarFormat _calendarFormat = CalendarFormat.week;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  bool fistTime = false;
  bool allDoneCheck = false;

  void eventIsDone(DateTime value, String title, int done) {
    kEvents[_focusedDay.value]!.firstWhere((element) {
      if (element.title == title) {
        if (element.doneTimes < element.timesDay &&
            element.timesDay - element.doneTimes >= done) {
          element.doneTimes += done;
          saveEventToHive();
        }
      }
      return element.title == title;
    });
  }

  void undoEvent(DateTime value, String title) {
    var x = kEvents[_focusedDay.value]!.firstWhere((element) {
      return element.title == title;
    });
    x.doneTimes = 0;
    x.isDone = false;

    saveEventToHive();
  }

  // kEvents[_focusedDay.value].firstWhere((element) {
  //     if(element.title == title) {
  //       if(done <= element.doneTimes) {
  //         element.doneTimes += done;
  //       }
  //     }
  //     return element.title == title;
  //   });

  bool checkEventDone(DateTime value, String title) {
    return kEvents[_focusedDay.value]!.firstWhere((element) {
      return element.title == title;
    }).isDone;
  }

  @override
  void initState() {
    print('inside calender init');
    openEventBox();

    setState(() {
      _selectedDays.add(_focusedDay.value);
      _selectedEvents = ValueNotifier(_getEventsForDay(_focusedDay.value));
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // Hive.close();
    _focusedDay.dispose();
    _selectedEvents!.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<int?> _showTimesDialog(BuildContext context, String title) async {
    return showDialog<int>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext ctx) {
        return VolumeAlert(focusedDay: _focusedDay.value, title: title);
      },
    );
  }

  Widget eventItem(
      Key key, String title, String subtitle, int timesDay, int doneTimes) {
    return Slidable(
      key: key,
      actionPane: SlidableDrawerActionPane(),
      // actions: [
      //   IconSlideAction(
      //     caption: 'Archive',
      //     color: Colors.blue,
      //     icon: Icons.archive,
      //     onTap: () => _showSnackBar('Archive'),
      //   ),
      //   IconSlideAction(
      //     caption: 'Share',
      //     color: Colors.indigo,
      //     icon: Icons.share,
      //     onTap: () => _showSnackBar('Share'),
      //     // Don't
      //     closeOnTap: false,
      //   ),
      // ], // swipe right
      secondaryActions: [
        // -------- Done button ---------
        Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: IconSlideAction(
            caption: 'Done',
            color: Colors.lightGreen,
            icon: Icons.done,
            onTap: () {
              if (_focusedDay.value.isAfter(DateTime.now())) {
                _showSnackBar('You will need a Time Machine!');
              } else {
                _showTimesDialog(context, title).then((value) {
                  if (value != null) {
                    // incremental done -- start
                    var tmep =
                        kEvents[_focusedDay.value]!.firstWhere((element) {
                      return element.title == title;
                    });
                    if (tmep.doneTimes + value == tmep.timesDay) {
                      kEvents[_focusedDay.value]!.firstWhere((element) {
                        return element.title == title;
                      }).isDone = true;
                    }
                    // incremental done -- end
                    var box = Hive.box<EventSource>('event_source');
                    setState(() {
                      eventIsDone(_focusedDay.value, title, value);
                    });
                    var x = EventSource(kEvents);
                    box.putAt(0, x);
                  }
                });
              }
            },
          ),
        ),
        // -------- Skip button --------
        Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11.0),
          ),
          child: IconSlideAction(
            caption: checkEventDone(_focusedDay.value, title) == true
                ? 'Undo'
                : 'Skip',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              _showSnackBar('Delete');
              // print(checkEventDone(_focusedDay.value, title));
              if (checkEventDone(_focusedDay.value, title)) {
                setState(() {
                  undoEvent(_focusedDay.value, title);
                });
              }
            },
          ),
        ),
      ], //swipe left
      child: ListTile(
        // leading: const Icon(Icons.swipe),
        leading: CircularPercentIndicator(
          animation: true,
          animationDuration: 900,
          addAutomaticKeepAlive: false,
          // fillColor: Colors.blueGrey,
          progressColor: Colors.green,
          lineWidth: 6.2,
          radius: 28,
          percent: doneTimes / timesDay,
        ),
        title: Text(title),
        subtitle:
            doneTimes == timesDay ? Text('Completed') : Text('Incomplete'),
      ),
    );
  }

  bool get canClearSelection =>
      _selectedDays.isNotEmpty || _rangeStart != null || _rangeEnd != null;

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForDays(Iterable<DateTime> days) {
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  // List<Event> _getEventsForRange(DateTime start, DateTime end) {
  //   final days = daysInRange(start, end);
  //   return _getEventsForDays(days);
  // }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      // if (_selectedDays.contains(selectedDay)) {
      //   _selectedDays.remove(selectedDay);
      // } else {
      //   _selectedDays.add(selectedDay);
      // }

      _selectedDays.clear();
      _selectedDays.add(selectedDay);

      _focusedDay.value = focusedDay;
      _rangeStart = null;
      _rangeEnd = null;
      _rangeSelectionMode = RangeSelectionMode.toggledOff;
    });

    _selectedEvents!.value = _getEventsForDays(_selectedDays);
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    // var progressData = Provider.of<Habits>(context);
    // var totalTimes
    return Scaffold(
      // ----- temp button for clearing event DB -----
      // floatingActionButton: FloatingActionButton(
      //   onPressed: clearDB,
      //   child: Icon(Icons.four_g_mobiledata),
      // ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_business_sharp),
        onPressed: () {
          // Navigator.of(context).pushNamed(CountDownScreen.routeName);
          // clearDB();
        },
      ),
      body: Column(
        children: [
          ValueListenableBuilder<DateTime>(
            valueListenable: _focusedDay,
            builder: (context, value, _) {
              return CalendarHeader(
                focusedDay: value,
                clearButtonVisible: canClearSelection,
                onTodayButtonTap: () {
                  setState(() => _focusedDay.value = DateTime.now());
                },
                onClearButtonTap: () {
                  setState(() {
                    _rangeStart = null;
                    _rangeEnd = null;
                    _selectedDays.clear();
                    _selectedEvents!.value = [];
                  });
                },
                onLeftArrowTap: () {
                  _pageController!.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
                onRightArrowTap: () {
                  _pageController!.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
              );
            },
          ),
          TableCalendar<Event>(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            focusedDay: _focusedDay.value,
            headerVisible: false,
            selectedDayPredicate: (day) => _selectedDays.contains(day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            calendarStyle: CalendarStyle(
              markerSize: 0,
            ),
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            onDaySelected: _onDaySelected,
            // onRangeSelected: _onRangeSelected,
            onCalendarCreated: (controller) => _pageController = controller,
            onPageChanged: (focusedDay) => _focusedDay.value = focusedDay,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() => _calendarFormat = format);
              }
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents!,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: eventItem(
                        UniqueKey(),
                        value[index].title,
                        value[index].isDone.toString(),
                        value[index].timesDay,
                        value[index].doneTimes,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
