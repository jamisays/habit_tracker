import 'package:flutter/material.dart';
import 'package:habit_tracker/models/bad_habits/charts/done_times.dart';
import 'package:habit_tracker/providers/habits.dart';
import 'package:habit_tracker/screens/edit_good_habit_screen.dart';
import 'package:habit_tracker/widgets/good_habits/success_rate_chart.dart';
import 'package:intl/intl.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

class MyGoodHabitDetailScreen extends StatefulWidget {
  static const routeName = '/my-good-habit-details';

  @override
  State<MyGoodHabitDetailScreen> createState() =>
      _MyGoodHabitDetailScreenState();
}

class _MyGoodHabitDetailScreenState extends State<MyGoodHabitDetailScreen> {
  late List<DoneTimes>? _chartData;

  String getScheduleFullName(String name) {
    if (name == 'fix')
      return 'Fixed';
    else if (name == 'fle')
      return 'Flexible';
    else
      return 'Repeating';
  }

  @override
  void initState() {
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final habitId = ModalRoute.of(context)!.settings.arguments as String;
    final habitsData = Provider.of<Habits>(context).goodItems;
    final selectedHabit = habitsData.firstWhere(
      (habit) => habit.id == habitId,
    );
    _chartData = getChartData(selectedHabit);
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            tooltip: 'Edit Habit',
            onPressed: () {
              Navigator.of(context).pushNamed(
                EditGoodHabitScreen.routeName,
                arguments: habitId,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: size.height * .02),
          Center(
            child: Text(selectedHabit.title.toUpperCase()),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.all(size.height * .02),
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(size.height * .025),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Schedule Type'),
                          Text(
                            getScheduleFullName(
                                selectedHabit.selectedScheduleType),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(size.height * .025),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Start Date'),
                          Text(
                            DateFormat.yMd()
                                .add_jm()
                                .format(selectedHabit.startDate),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: size.height * .3,
            width: size.width * .9,
            child: SuccessRateChart(
              chartData: _chartData,
              maxTimesDay: selectedHabit.timesDay,
            ),
          ),
        ],
      ),
    );
  }
}
