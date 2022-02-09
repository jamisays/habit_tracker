import 'package:flutter/material.dart';
import 'package:habit_tracker/models/badHabit.dart';
import 'package:habit_tracker/providers/habits.dart';
import 'package:habit_tracker/providers/streams.dart';
import 'package:habit_tracker/widgets/bad_habits/bad_details_record_card.dart';
import 'package:habit_tracker/widgets/heatmap_calendar/heatmap_calendar.dart';
import 'package:habit_tracker/widgets/heatmap_calendar/time_utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class MyBadHabitDetailScreen extends StatefulWidget {
  static const routeName = '/my-bad-habit-details';

  @override
  State<MyBadHabitDetailScreen> createState() => _MyBadHabitDetailScreenState();
}

class _MyBadHabitDetailScreenState extends State<MyBadHabitDetailScreen> {
  late StopWatchTimer stopwatchStream;
  final relapseReasonController = TextEditingController();

  final _isHours = true;

  String? minute;
  String? second;
  int? hour;
  int? day;

  void setTime(String stream) {
    var list = stream.split(":");
    hour = int.parse(list[0]);
    day = (hour! / 24).floor();
    hour = hour! % 24;
    minute = list[1];
    second = list[2].substring(0, 2);
  }

  Map<DateTime, int> heatMap = {};

  void setHeatMap(BadHabit habit) {
    var length = DateTime.now().difference(habit.createDate).inDays;

    int j = 0;
    for (int i = 0; i <= length; i++) {
      var date = habit.createDate.add(Duration(days: i));

      date = TimeUtils.removeTime(date);
      if (habit.relapsedDaysList.isNotEmpty) {
        if (TimeUtils.removeTime(habit.relapsedDaysList[j]) == date) {
          heatMap[date] = 5;
          j++;
        }
      } else
        heatMap[date] = 30;
    }
  }

  Future<String?> _showBadHabitRelapseReasonDialog(BuildContext context) async {
    return await showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return AlertDialog(
          title: Text('What made you relapse?'),
          content: Card(
            child: TextField(
              controller: relapseReasonController,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Reset'),
              onPressed: () {
                Navigator.pop(ctx, relapseReasonController.value.text);
                relapseReasonController.clear();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    // await stopwatchStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final habitId = ModalRoute.of(context)!.settings.arguments as String;
    final habits = Provider.of<Habits>(context);
    final habitsData = Provider.of<Habits>(context).badItems;
    final selectedHabit = habitsData.firstWhere(
      (habit) => habit.id == habitId,
    );
    stopwatchStream =
        Provider.of<Streams>(context).stopwatchStreamList[habitId]!;
    setHeatMap(selectedHabit);

    // stopwatchStream.secondTime.listen((value) {
    //   print('secondTime $value');
    // });
    // print(stopwatchStream.isRunning);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedHabit.title),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Edit'),
                value: '/edit_bad_habit',
                // onTap: () {
                //   Navigator.of(context).pushNamed(
                //     EditBadHabitScreen.routeName,
                //     arguments: habitId,
                //   );
                //   print('Edit menu');
                // },
              ),
              // PopupMenuItem(
              //   child: Text('Reset'),
              //   onTap: () {
              //     var badRelapseTime = DateTime.now();
              //     _showBadHabitRelapseReasonDialog(context).then((value) {
              //       print(value);
              //       habits.badRelapsed(habitId, badRelapseTime, value);
              //     });
              //   },
              // ),
              PopupMenuItem(
                child: Text('History'),
                value: '/bad_habit_relapse_history',
                // onTap: () {
                //   habits.badItems.forEach((element) {
                //     print(element.relapsedReasons.entries);
                //   });
                // },
              ),
            ],
            onSelected: (value) {
              Navigator.of(context).pushNamed(
                value.toString(),
                arguments: habitId,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<int>(
              stream: stopwatchStream.rawTime,
              initialData: stopwatchStream.rawTime.value,
              builder: (context, snap) {
                final value = snap.data!;
                final displayTime =
                    StopWatchTimer.getDisplayTime(value, hours: _isHours);
                setTime(displayTime);
                return Container(
                  width: size.width * .99,
                  child: Card(
                    elevation: 3,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Elapsed Time:',
                                style: TextStyle(
                                  fontSize: size.width * .05,
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: size.width * .005,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularPercentIndicator(
                            radius: size.height * .16,
                            percent: hour! / 60,
                            progressColor: Colors.green,
                            backgroundColor: Colors.blueGrey.shade100,
                            center: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  day.toString() + ' Days',
                                  style: const TextStyle(
                                    fontSize: 40,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  hour.toString() + ' Hours',
                                  style: const TextStyle(
                                    fontSize: 35,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  minute! + ' Minutes',
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  second.toString() + ' Seconds',
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Container(
              height: size.height * .4,
              width: size.width * .95,
              child: GridView(
                children: [
                  RecordCard(100, 'Best Streak', Icons.thumb_up_alt),
                  RecordCard(80, 'Current Streak', Icons.calendar_today),
                  RecordCard(80, 'Current Streak', Icons.add_chart_outlined),
                ],
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
              ),
            ),
            Container(
              height: size.height * .4,
              width: size.width * .95,
              child: HeatMapCalendar(input: heatMap, colorThresholds: {
                1: Colors.green[100]!,
                10: Colors.green[300]!,
                30: Colors.green[500]!,
              }),
            ),
            Container(
              child: ElevatedButton(
                child: Text('Reset'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.red.shade300),
                ),
                onPressed: () {
                  var badRelapseTime = DateTime.now();
                  _showBadHabitRelapseReasonDialog(context).then((value) {
                    print(value);
                    habits.badRelapsed(habitId, badRelapseTime, value);
                    // Navigator.pop(context);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}