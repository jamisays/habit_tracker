import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/goodHabit.dart';

class HabitItem extends StatefulWidget {
  const HabitItem({
    Key? key,
    required this.habit,
    required this.deleteHt,
  }) : super(key: key);

  final GoodHabit habit;
  final Function deleteHt;

  @override
  _HabitItemState createState() => _HabitItemState();
}

class _HabitItemState extends State<HabitItem> {
  Color? _bgColor;

  @override
  void initState() {
    const habitColors = [
      Colors.black,
      Colors.red,
      Colors.blue,
      Colors.deepPurpleAccent,
    ];

    _bgColor = habitColors[Random().nextInt(3)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Text(
            '${widget.habit.duration}d',
          ),
        ),
        title: Text(
          widget.habit.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.habit.startDate!),
          // habits[index].difficultyLevel,
          // ),
        ),
        trailing: MediaQuery.of(context).size.width > 520
            ? TextButton.icon(
                onPressed: () => widget.deleteHt(widget.habit.id),
                label: const Text('Delete'),
                icon: const Icon(Icons.delete),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => widget.deleteHt(widget.habit.id),
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
