import 'package:flutter/material.dart';
import 'package:habit_tracker/models/good_habits/goodHabit.dart';
import 'package:habit_tracker/screens/good_habits/myGoodHabitDetailScreen.dart';
import 'package:intl/intl.dart';

class MyGoodHabitItem extends StatefulWidget {
  const MyGoodHabitItem({
    Key? key,
    required this.goodHabit,
    required this.deleteHt,
    required this.index,
  }) : super(key: key);

  final GoodHabit goodHabit;
  final Function deleteHt;
  final int index;

  @override
  _MyGoodHabitItemState createState() => _MyGoodHabitItemState();
}

void selectGoodHabit(BuildContext context, String id, int index) {
  Navigator.of(context).pushNamed(
    MyGoodHabitDetailScreen.routeName,
    arguments: id,
  );
}

class _MyGoodHabitItemState extends State<MyGoodHabitItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectGoodHabit(context, widget.goodHabit.id, widget.index),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.indigo.shade500,
            radius: 30,
            child: Text(
              '${widget.goodHabit.duration}d',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: Theme.of(context).textTheme.headline6!.fontFamily,
                color: Colors.white,
              ),
            ),
          ),
          title: Text(
            widget.goodHabit.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            DateFormat.yMMMd().format(widget.goodHabit.startDate),
            // habits[index].difficultyLevel,
            // ),
          ),
          trailing: MediaQuery.of(context).size.width > 520
              ? TextButton.icon(
                  onPressed:
                      null, // () => //widget.deleteHt(widget.goodHabit.id),
                  label: const Text('Delete'),
                  icon: const Icon(Icons.delete),
                )
              : IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title: Text('Warning!'),
                            content: Text(
                              'Are you sure you want to delete this Habit?',
                            ),
                            actions: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                ),
                                onPressed: () {
                                  widget.deleteHt(
                                      widget.goodHabit.id, widget.index);
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Deleted!'),
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Delete',
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                ),
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Text('Cancel'),
                              ),
                            ],
                          );
                        });
                  },
                  color: Theme.of(context).errorColor,
                ),
        ),
      ),
    );
  }
}
