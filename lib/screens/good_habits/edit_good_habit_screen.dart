import "package:flutter/material.dart";
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:habit_tracker/models/good_habits/goodHabit.dart';
import 'package:habit_tracker/providers/good_habits.dart';
// ignore: unused_import
import 'package:intl/intl.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:smart_select/smart_select.dart';
import 'package:awesome_select/awesome_select.dart';

class EditGoodHabitScreen extends StatefulWidget {
  static const routeName = '/edit_good_habit';

  @override
  _EditGoodHabitScreenState createState() => _EditGoodHabitScreenState();
}

class _EditGoodHabitScreenState extends State<EditGoodHabitScreen> {
  final _formKeyEditGood = GlobalKey<FormBuilderState>();
  // GoodHabit? _editedHabit;
  late GoodHabit previousHabit;

  // var _initValues = {
  //   'title': '',
  //   'selectedScheduleType': '',
  //   'flexDays': '',
  //   'repDays': '',
  //   'timesDay': '',
  //   'startDate': ''
  // };

  var isLoading = false;
  var _isInit = true;
  var selectedScheduleType;

  List<String>? habitDays;

  void didChangeDependencies() {
    if (_isInit) {
      final habitId = ModalRoute.of(context)!.settings.arguments as String;
      var _editedHabitPrev = Provider.of<GoodHabits>(context, listen: false)
          .goodItems
          .firstWhere((habit) => habit.id == habitId);

      previousHabit = _editedHabitPrev;
      // _editedHabit = previousHabit;
      // print(previousHabit.difficultyLevel);
      // print(previousHabit.selectedScheduleType);

      habitDays = previousHabit.habitDays;

      // };
      selectedScheduleType = _editedHabitPrev.selectedScheduleType;

      // _editedHabit = _editedHabitPrev;
      _isInit = false;
      super.didChangeDependencies();
    }
  }

  // --------------------------------------------
  // -----form builder assets ----- START--------
  // --------------------------------------------

  // String _timesPerOptionsDefaultValue = 'Week';

  static const scheduleItems2 = <String>[
    'Fixed',
    'Flexible',
    'Repeating',
  ];

  final List<DropdownMenuItem<String>> scheduleDropdownItems2 = scheduleItems2
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();

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

  // ===============================
  // form builder assets ----- END
  // ===============================

  String value = 'fle';

  DropdownMenuItem<String> getDifficultyItem(String? name) {
    // print(name);
    if (name == 'Easy') {
      return DropdownMenuItem<String>(
        value: name,
        child: Text(name!),
      );
    } else if (name == 'Medium') {
      return DropdownMenuItem<String>(
        value: name,
        child: Text(name!),
      );
    } else {
      return DropdownMenuItem<String>(
        value: name,
        child: Text(name!),
      );
    }
  }

  String getScheduleTypeDropdownFullForm(String name) {
    if (name == 'fix')
      return 'Fixed';
    else if (name == 'fle')
      return 'Flexible';
    else
      return 'Repeating';
  }

  static const timesPerOptions = <String>[
    'Week',
    'Month',
    'Year',
  ];
  final List<DropdownMenuItem<String>> _timesPerOptionsDropdownMenuItems =
      timesPerOptions
          .map(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          )
          .toList();
  List<Map<String, String>> days = [
    {'value': 'mon', 'title': 'Monday'},
    {'value': 'tue', 'title': 'Tuesday'},
    {'value': 'wed', 'title': 'Wednesday'},
    {'value': 'thu', 'title': 'Thursday'},
    {'value': 'fri', 'title': 'Friday'},
    {'value': 'sat', 'title': 'Saturday'},
    {'value': 'sun', 'title': 'Sunday'},
  ];

  Widget get buildCustomContent {
    switch (previousHabit.selectedScheduleType) {
      case 'fix':
        return SmartSelect<String>.multiple(
          title: 'Select Days',
          // modalActionsBuilder: (context, value) {
          //   return [selectAllDays()];
          // },
          modalConfirm: true,
          choiceConfig: S2ChoiceConfig(
            type: S2ChoiceType.chips,
          ),

          selectedValue: habitDays,
          onChange: (state) {
            habitDays = state!.value;
            print(state);
          },
          modalType: S2ModalType.popupDialog,
          choiceItems: S2Choice.listFrom<String, Map<String, String>>(
            source: days,
            value: (index, item) => item['value']!,
            title: (index, item) => item['title']!,
          ),
        );
      // break;

      case 'fle':
        return Padding(
          padding: EdgeInsets.only(
            left: 7.5,
            right: 7.5,
          ),
          child: Row(
            children: [
              Text(
                'I will do this  ',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              Container(
                width: 30,
                child: FormBuilderTextField(
                  name: 'flex_days',
                  initialValue: previousHabit.flexDays.toString(),
                  keyboardType: TextInputType.number,
                  // controller: _flexDaysController,
                  // onSubmitted: (_) => _submitData(),
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Text('  days per'),
              Container(
                width: 100,
                child: FormBuilderDropdown(
                  name: 'flex_per_time',
                  items: _timesPerOptionsDropdownMenuItems,
                  elevation: 10,
                  initialValue: timesPerOptions[0],
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Choose Difficulty",
                    alignLabelWithHint: false,
                    // icon: Icon(Icons.personal_injury),
                  ),
                ),
                // child: ListTile(
                //   trailing: DropdownButton(
                //     hint: const Text('Choose'),
                //     value: _timesPerOptionsDefaultValue,
                //     elevation: 7,
                //     onChanged: (String? dValue) {
                //       setState(() {
                //         _timesPerOptionsDefaultValue = dValue!;
                //       });
                //     },
                //     items: _timesPerOptionsDropdownMenuItems,
                //   ),
                // ),
              ),
            ],
          ),
        );

      case 'rep':
        return Row(
          children: [
            Text(
              'I will do this after every  ',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Container(
              width: 30,
              child: FormBuilderTextField(
                name: 'rep_days',
                initialValue: previousHabit.repDays.toString(),
                // controller: _repDaysController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Text('  days.'),
          ],
        );

      default:
        return Text('Default');
    }
  }

  Widget buildScheduleContent() {
    return Padding(
      padding: EdgeInsets.only(
        left: 7.5,
        right: 7.5,
      ),
      child: Row(
        children: [
          Text(
            'I will do this  ',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Container(
            width: 30,
            child: FormBuilderTextField(
              name: 'times_day',
              initialValue: previousHabit.timesDay.toString(),
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          Text('  times per day'),
        ],
      ),
    );
  }

  // void _showDatePicker() {
  //   showDatePicker(
  //     context: context,
  //     initialDate: _editedHabit!.startDate,
  //     firstDate: DateTime(2020),
  //     lastDate: DateTime.now(),
  //   ).then((pickedDate) {
  //     if (pickedDate == null) {
  //       return;
  //     }
  //     setState(() {
  //       _editedHabit!.startDate = pickedDate;
  //     });
  //   });
  // }

  void _saveForm() {
    _formKeyEditGood.currentState!.save();

    int? enteredFlexDays;
    int? enteredRepDays;
    // if (!_formKeyGood.currentState!.validate()) return;
    // _formKeyGood.currentState!.save();

    var enteredTitle =
        _formKeyEditGood.currentState!.fields['habit_title']!.value.toString();
    // final habitDays =
    //     _editGoodForm.currentState!.fields['habitDays'] as List<String>;
    enteredFlexDays = int.parse(
        _formKeyEditGood.currentState!.fields['flex_days']?.value ?? '0');

    final enteredFlexPerTime = _formKeyEditGood
            .currentState!.fields['flex_per_time']?.value
            .toString() ??
        '';

    enteredRepDays = int.parse(
        _formKeyEditGood.currentState!.fields['rep_days']?.value ?? '0');

    final enteredTimesDay =
        int.parse(_formKeyEditGood.currentState!.fields['times_day']!.value);

    // final enteredKarmaPoint =
    //     _formKeyEditGood.currentState!.fields['karma_point']!.value;

    final enteredDifficulty =
        _formKeyEditGood.currentState!.fields['difficulty_level']!.value;

    final startDate =
        _formKeyEditGood.currentState!.fields['start_date']!.value as DateTime;

    int calculatedDuration = DateTime.now().difference(startDate).inDays;

    final updatedHabit = GoodHabit(
      title: enteredTitle,
      // karmaPoint: htDuration,
      selectedScheduleType: selectedScheduleType,
      habitDays: habitDays,
      flexDays: enteredFlexDays,
      flexPerTime: enteredFlexPerTime,
      repDays: enteredRepDays,
      timesDay: enteredTimesDay,
      difficultyLevel: enteredDifficulty,
      startDate: startDate,
      isActive: true,
      // id: DateTime.now().toString(),
      id: previousHabit.id,
      duration: calculatedDuration,
    );

    Provider.of<GoodHabits>(context, listen: false)
        .updateGoodHabit(updatedHabit.id, updatedHabit);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
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
          padding: EdgeInsets.all(30),
          child: FormBuilder(
            key: _formKeyEditGood,
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
                  // validator: titleValidator,
                ),
                FormBuilderDropdown(
                  name: 'scheduleType',
                  items: scheduleDropdownItems2,
                  // initialValue: scheduleItems2[1],
                  initialValue: getScheduleTypeDropdownFullForm(
                      previousHabit.selectedScheduleType),
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
                buildCustomContent,
                buildScheduleContent(),
                FormBuilderTextField(
                  name: 'karma_point',
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Karma Point",
                    alignLabelWithHint: false,
                    icon: Icon(Icons.score),
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
                  initialValue: previousHabit.startDate,
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
                    onPressed: _saveForm,
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
                        Text('Add Habit'),
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
