import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:smart_select/smart_select.dart';
import 'package:awesome_select/awesome_select.dart';

class MyNewGoodHabit extends StatefulWidget {
  static const routeName = '/my_new_good_habit';
  final Function addHt;
  final bool isCustom;
  final String title;

  MyNewGoodHabit(this.addHt, this.isCustom, this.title);

  @override
  _MyNewGoodHabitState createState() => _MyNewGoodHabitState();
}

class _MyNewGoodHabitState extends State<MyNewGoodHabit> {
  final _formKeyGood = GlobalKey<FormBuilderState>();

  // final _titleController = TextEditingController();
  // final _durationController = TextEditingController();
  // final _flexDaysController = TextEditingController();
  // final _repDaysController = TextEditingController();
  // final _timesDayController = TextEditingController();
  // DateTime? _selectedDate;

  var isLoading = false;

  static const difficultyMenuItems = <String>[
    'Easy',
    'Medium',
    'Hard',
  ];

  // String _difficultyMenuDefaultValue = 'Easy';

  static const timesPerOptions = <String>[
    'Week',
    'Month',
    'Year',
  ];

  String _timesPerOptionsDefaultValue = 'Week';

  final List<DropdownMenuItem<String>> _timesPerOptionsDropdownMenuItems =
      timesPerOptions
          .map(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          )
          .toList();

  // static const scheduleItems = <String>[
  //   'Regular',
  //   'Flexible',
  //   'Repeating',
  // ];

  final List<DropdownMenuItem<String>> _difficultyDropdownMenuItems =
      difficultyMenuItems
          .map(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          )
          .toList();

  Future<void> _submitData() async {
    setState(() {
      isLoading = true;
    });
    int? enteredFlexDays;
    int? enteredRepDays;
    // if (!_formKeyGood.currentState!.validate()) return;
    // _formKeyGood.currentState!.save();

    var enteredTitle =
        _formKeyGood.currentState!.fields['habit_title']!.value.toString();
    enteredFlexDays =
        int.parse(_formKeyGood.currentState!.fields['flex_days']?.value ?? '0');

    enteredRepDays =
        int.parse(_formKeyGood.currentState!.fields['rep_days']?.value ?? '0');

    final enteredTimesDay =
        int.parse(_formKeyGood.currentState!.fields['times_day']!.value);

    // final enteredKarmaPoint =
    //     _formKeyGood.currentState!.fields['karma_point']!.value;

    final enteredDifficulty =
        _formKeyGood.currentState!.fields['difficulty_level']!.value;

    final startDate =
        _formKeyGood.currentState!.fields['start_date']!.value as DateTime;

    int calculatedDuration = DateTime.now().difference(startDate).inDays;

    if (widget.isCustom == false) enteredTitle = widget.title;
    // if (enteredTitle.isEmpty ||
    //     calculatedDuration < 0 ||
    //     _selectedDate == null ||
    //     // ignore: unnecessary_null_comparison
    //     enteredTimesDay == null) {
    //   return;
    // }

    // for calculating days from inputted date
    try {
      await widget.addHt(
        enteredTitle,
        // enteredDuration,
        selectedScheduleType,
        habitDays,
        enteredFlexDays,
        _timesPerOptionsDefaultValue,
        enteredRepDays,
        enteredTimesDay,
        startDate,
        calculatedDuration,
        enteredDifficulty,
      );
    } catch (error) {
      print(error);
      await showDialog<Null>(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text(
                  'Warning!',
                ),
                content: Text(
                  error.toString(),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok'),
                  ),
                ],
              ));
    } finally {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    }

    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text('Habit Added!'),
    //   duration: Duration(seconds: 3),
    // ));
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
              // controller: _timesDayController,
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

  String value = 'fix';

  String selectedScheduleType = 'fix';

  List<S2Choice<String>> scheduleItems = [
    S2Choice<String>(value: 'fix', title: 'Fixed'),
    S2Choice<String>(value: 'fle', title: 'Flexible'),
    S2Choice<String>(value: 'rep', title: 'Repeating'),
  ];

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

  List<String>? habitDays = [];

  List<String> tempHabitDays = [];

  bool _selectAllDaysCheckboxValue = false;

  Widget selectAllDays() {
    return Checkbox(
        value: _selectAllDaysCheckboxValue,
        onChanged: (value) {
          if (value == true) {
            setState(() {
              tempHabitDays = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];
              habitDays = tempHabitDays;
              _selectAllDaysCheckboxValue = true;
            });
            print(tempHabitDays);
          } else {
            setState(() {
              tempHabitDays = [];
              habitDays = tempHabitDays;
              _selectAllDaysCheckboxValue = false;
            });
          }
        });
  }

  List<Map<String, String>> daysx = [
    {'value': 'mon', 'title': 'Monday'},
    {'value': 'tue', 'title': 'Tuesday'},
    {'value': 'wed', 'title': 'Wednesday'},
    {'value': 'thu', 'title': 'Thursday'},
    {'value': 'fri', 'title': 'Friday'},
    {'value': 'sat', 'title': 'Saturday'},
    {'value': 'sun', 'title': 'Sunday'},
  ];

  List<FormBuilderFieldOption<String>> days = [
    FormBuilderFieldOption(
      value: 'Monday',
    ),
    FormBuilderFieldOption(
      value: 'Tuesday',
    ),
    FormBuilderFieldOption(
      value: 'Wednesday',
    ),
    FormBuilderFieldOption(
      value: 'Thursday',
    ),
    FormBuilderFieldOption(
      value: 'Friday',
    ),
    FormBuilderFieldOption(
      value: 'Saturday',
    ),
    FormBuilderFieldOption(
      value: 'Sunday',
    ),
  ];

  Widget get buildCustomContent {
    switch (selectedScheduleType) {
      case 'fix':
        // return FormBuilderCheckboxGroup(
        //   name: 'fixed_days',
        //   options: days,
        // );
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
            source: daysx,
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
        return Text('default');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isCustom ? Text('Add Custom Habit') : Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: FormBuilder(
            key: _formKeyGood,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'habit_title',
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
                  initialValue: scheduleItems2[0],
                  onChanged: (value) {
                    setState(() {
                      selectedScheduleType =
                          value.toString().toLowerCase().substring(0, 3);
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
                  dropdownColor: Colors.lightBlue[100],
                  initialValue: difficultyMenuItems[0],
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
