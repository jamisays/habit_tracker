import 'package:flutter/material.dart';
import 'package:habit_tracker/dummy_data.dart';
import 'package:habit_tracker/providers/bad_habits.dart';
import 'package:habit_tracker/providers/good_habits.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

class MenuHabitDetailsScreen extends StatelessWidget {
  static const routeName = '/habit-details';
  @override
  Widget build(BuildContext context) {
    // final habitsData = Provider.of<Habits>(context);
    // final addHabitFromMenuFunction = habitsData.startAddNewHabit;
    final habitId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedHabit =
        dummyHabits.firstWhere((habit) => habit.id == habitId);
    final goodHabitsData = Provider.of<GoodHabits>(context);
    final badHabitsData = Provider.of<BadHabits>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedHabit.title}'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 300,
            width: double.infinity,
            child: Text(selectedHabit.title),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_alert),
        onPressed: () {
          selectedHabit.category == 'b'
              ? badHabitsData.startAddNewBadHabit(
                  context, false, selectedHabit.title)
              : goodHabitsData.startAddNewGoodHabit(
                  context, false, selectedHabit.title);
        },
      ),
      // temporary delete button
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.delete),
      //   onPressed: () {
      //     Navigator.of(context).pop(habitId);
      //   },
      // ),
    );
  }
}
