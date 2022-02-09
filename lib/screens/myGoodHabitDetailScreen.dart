import 'package:flutter/material.dart';
import 'package:habit_tracker/providers/habits.dart';
import 'package:habit_tracker/screens/edit_good_habit_screen.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyGoodHabitDetailScreen extends StatelessWidget {
  static const routeName = '/my-good-habit-details';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final habitId = ModalRoute.of(context)!.settings.arguments as String;
    final habitsData = Provider.of<Habits>(context).goodItems;
    final selectedHabit = habitsData.firstWhere(
      (habit) => habit.id == habitId,
    );
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
            height: 400,
            child: SfCartesianChart(
              title: ChartTitle(text: 'Success Rate'),
            ),
          ),
        ],
      ),
    );
  }
}
