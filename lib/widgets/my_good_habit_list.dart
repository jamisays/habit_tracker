import "package:flutter/material.dart";
// import 'package:habit_tracker/models/goodHabit.dart';
import 'package:habit_tracker/providers/habits.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

import 'my_good_habit_item.dart';

class MyGoodHabitList extends StatelessWidget {
  // final List<GoodHabit> goodHabits;
  final Function deleteHt;

  MyGoodHabitList(this.deleteHt);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future:
            Provider.of<Habits>(context, listen: false).fetchAndSetGoodHabits(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<Habits>(
                child: Center(
                  child: const Text('No habits yet added'),
                ),
                builder: (ctx, goodHabits, ch) =>
                    goodHabits.goodHabits.length <= 0
                        ? ch!
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return MyGoodHabitItem(
                                  key:
                                      ValueKey(goodHabits.goodHabits[index].id),
                                  goodHabit: goodHabits.goodHabits[index],
                                  deleteHt: deleteHt,
                                  index: index);
                            },
                            itemCount: goodHabits.goodHabits.length,
                          ),
              ),
      ),
    );
  }
}
