import "package:flutter/material.dart";
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:habit_tracker/models/bad_habits/badHabit.dart';
import 'package:habit_tracker/providers/habits.dart';
// ignore: unused_import
import 'package:intl/intl.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

class EditBadHabitScreen extends StatefulWidget {
  static const routeName = '/edit_bad_habit';

  @override
  _EditBadHabitScreenState createState() => _EditBadHabitScreenState();
}

class _EditBadHabitScreenState extends State<EditBadHabitScreen> {
  final _formKeyEditBad = GlobalKey<FormBuilderState>();
  // BadHabit? _editedHabit;
  late BadHabit previousHabit;

  // var _initValues = {
  //   'title': '',
  //   'reasons': '',
  //   'startDate': '',
  // };

  var _isInit = true;
  var selectedScheduleType;
  var difficultyLevel;

  void didChangeDependencies() {
    if (_isInit) {
      final habitId = ModalRoute.of(context)!.settings.arguments as String;
      var _editedHabitPrev = Provider.of<Habits>(context, listen: false)
          .badItems
          .firstWhere((habit) => habit.id == habitId);

      previousHabit = _editedHabitPrev;

      selectedScheduleType = previousHabit.timesType;
      difficultyLevel = previousHabit.difficultyLevel;

      // selectedScheduleType = _editedHabitPrev.selectedScheduleType;

      // _editedHabit = _editedHabitPrev;
      _isInit = false;
      super.didChangeDependencies();
    }
  }

  List<String>? habitDays;
  String value = 'fle';

  // difficulty items
  static const difficultyMenuItems = <String>[
    'Easy',
    'Medium',
    'Hard',
  ];

  final List<DropdownMenuItem<String>> _difficultyDropdownMenuItems =
      difficultyMenuItems
          .map(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          )
          .toList();
  // difficulty items -- end

  // frequency Type Items
  static const frequencyTypeItems = <String>[
    'Daily',
    'Weekly',
    'Monthly',
  ];

  final List<DropdownMenuItem<String>> _frequencyTypeDropdownMenuItems =
      frequencyTypeItems
          .map(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          )
          .toList();
  // frequency Type Items -- end

  List<Map<String, String>> days = [
    {'value': 'mon', 'title': 'Monday'},
    {'value': 'tue', 'title': 'Tuesday'},
    {'value': 'wed', 'title': 'Wednesday'},
    {'value': 'thu', 'title': 'Thursday'},
    {'value': 'fri', 'title': 'Friday'},
    {'value': 'sat', 'title': 'Saturday'},
    {'value': 'sun', 'title': 'Sunday'},
  ];

  void _submitData() {
    if (!_formKeyEditBad.currentState!.validate()) return;
    _formKeyEditBad.currentState!.save();

    final enteredTitle =
        _formKeyEditBad.currentState!.value['habit_title'].toString();
    final enteredDoneFrequency =
        _formKeyEditBad.currentState!.fields['done_frequency']!.value;
    final enteredTimesDay =
        int.parse(_formKeyEditBad.currentState!.value['times_day'].toString());
    final enteredCostPerTime = int.parse(
        _formKeyEditBad.currentState!.value['cost_per_time'].toString());
    final enteredDifficultyLevel =
        _formKeyEditBad.currentState!.fields['difficulty_level']!.value;
    final enteredStartDate =
        _formKeyEditBad.currentState!.fields['start_date']!.value as DateTime;

    // if startdate is changed
    if (enteredStartDate != previousHabit.createDate) {
      previousHabit.relapsedDaysList = [];
      previousHabit.relapsedReasons = {};
      // previousHabit.relapsedDaysList.last = enteredStartDate;
      // var temp = previousHabit.relapsedReasons[previousHabit.createDate];
      // previousHabit.relapsedReasons.remove(previousHabit.createDate);
      // previousHabit.relapsedReasons[enteredStartDate] = temp!;
    }

    // final enteredReason = _reasonController.text;
    List<String> enteredReasonList = [];

    // int calculatedDuration = DateTime.now().difference(_selectedDate!).inDays;

    final updatedHabit = BadHabit(
      id: previousHabit.id,
      title: enteredTitle,
      // karmaPoint: htDuration,
      reasons: enteredReasonList,
      timesType: enteredDoneFrequency,
      timesDay: enteredTimesDay,
      costPerTime: enteredCostPerTime,
      difficultyLevel: enteredDifficultyLevel,
      createDate: enteredStartDate,
      isActive: true,
      relapsedDaysList: previousHabit.relapsedDaysList,
      relapsedReasons: previousHabit.relapsedReasons,
      lastDate: enteredStartDate,
    );

    Provider.of<Habits>(context, listen: false)
        .updateBadHabit(updatedHabit.id, updatedHabit);

    // widget.addHt(
    //   enteredTitle,
    //   enteredReasonList,
    //   enteredDoneFrequency,
    //   enteredTimesDay,
    //   enteredCostPerTime,
    //   // _selectedDate,
    //   enteredDifficultyLevel,
    //   enteredStartDate,
    // );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Habit'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: FormBuilder(
            key: _formKeyEditBad,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'habit_title',
                  initialValue: previousHabit.title,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Habit Title",
                    alignLabelWithHint: false,
                    icon: Icon(Icons.near_me),
                  ),
                ),
                FormBuilderDropdown(
                  name: 'done_frequency',
                  items: _frequencyTypeDropdownMenuItems,
                  dropdownColor: Colors.lightBlue[100],
                  initialValue: selectedScheduleType,
                  onChanged: (value) {
                    setState(() {
                      selectedScheduleType = value;
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Choose Frequency",
                    alignLabelWithHint: false,
                    icon: Icon(Icons.alarm_add_rounded),
                  ),
                ),
                FormBuilderTextField(
                  name: 'times_day',
                  initialValue: previousHabit.timesDay.toString(),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "How many times?",
                    alignLabelWithHint: false,
                    icon: Icon(Icons.timer_sharp),
                  ),
                ),
                FormBuilderTextField(
                  name: 'cost_per_time',
                  initialValue: previousHabit.costPerTime.toString(),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Cost per time",
                    alignLabelWithHint: false,
                    icon: Icon(Icons.money),
                  ),
                ),
                FormBuilderDropdown(
                  name: 'difficulty_level',
                  items: _difficultyDropdownMenuItems,
                  initialValue: previousHabit.difficultyLevel,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Choose Difficulty",
                    alignLabelWithHint: false,
                    icon: Icon(Icons.hail_rounded),
                  ),
                ),
                FormBuilderDateTimePicker(
                  name: 'start_date',
                  keyboardType: TextInputType.datetime,
                  initialValue: previousHabit.createDate,
                  firstDate: DateTime.utc(2020),
                  lastDate: DateTime.now(),
                  style: TextStyle(),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Select Start Date",
                    alignLabelWithHint: false,
                    icon: Icon(Icons.date_range),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Submit button
                Container(
                  width: 140,
                  child: ElevatedButton(
                    onPressed: _submitData,
                    style: ButtonStyle(
                      alignment: Alignment.bottomRight,
                      padding: MaterialStateProperty.all(
                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check),
                        Text('Submit'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
