import 'package:flutter/material.dart';
import 'package:habit_tracker/models/good_habits/goodHabit.dart';

import 'habit_item.dart';

class HabitList extends StatelessWidget {
  final List<GoodHabit> habits;
  final Function deleteHt;

  HabitList(this.habits, this.deleteHt);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: habits.isEmpty
          ? LayoutBuilder(builder: (context, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No habits added yet!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: constraints.maxHeight * .6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (context, index) {
                return HabitItem(
                  key: ValueKey(habits[index].id),
                  habit: habits[index],
                  deleteHt: deleteHt,
                );
                // return Card(
                //   elevation: 5,
                //   shadowColor: Colors.black,
                //   child: Row(
                //     children: <Widget>[
                //       Container(
                //         alignment: Alignment.center,
                //         width: 75,
                //         height: 75,
                //         padding: EdgeInsets.all(20),
                //         margin: EdgeInsets.all(10),
                //         decoration: BoxDecoration(
                //             border: Border.all(
                //           color: Theme.of(context).primaryColor,
                //           width: 3,
                //         )),
                //         child: Text(
                //           '${habits[index].duration}d',
                //           style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 15,
                //             color: Theme.of(context).primaryColor,
                //           ),
                //         ),
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: <Widget>[
                //           Text(
                //             habits[index].title,
                //             style: Theme.of(context).textTheme.headline6,
                //           ),
                //           Text(
                //             DateFormat.yMMMd().format(habits[index].startDate),
                //             style: TextStyle(
                //               fontWeight: FontWeight.w400,
                //               fontSize: 14,
                //               color: Colors.grey,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // );
              },
              itemCount: habits.length,
            ),
    );
  }
}
