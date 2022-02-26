import 'package:flutter/material.dart';

// import 'package:intl/intl.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class MyNewBadHabit extends StatefulWidget {
  static const routeName = '/my_new_bad_habit';
  final Function addHt;
  final bool isCustom;
  final String title;

  MyNewBadHabit(this.addHt, this.isCustom, this.title);

  @override
  _MyNewBadHabitState createState() => _MyNewBadHabitState();
}

class _MyNewBadHabitState extends State<MyNewBadHabit> {
  final _formKeyBad = GlobalKey<FormBuilderState>();

  // final _titleController = TextEditingController();
  // final _reasonController = TextEditingController();
  // final _durationController = TextEditingController();
  // DateTime? _selectedDate;

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

  final List<DropdownMenuItem<String>> _frequencyTypeItemsDropdownMenuItems =
      frequencyTypeItems
          .map(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          )
          .toList();
  // frequency Type Items -- end

  // validators

  String? titleValidator(value) {
    if (value == null)
      return 'This field is required';
    else if (value.toString().length > 50)
      return 'Title is too long!';
    else
      return null;
  }

  // validators end

  // String _dBtnSValue = 'Easy';

  void _submitData() {
    if (!_formKeyBad.currentState!.validate()) return;
    _formKeyBad.currentState!.save();

    final enteredTitle =
        _formKeyBad.currentState!.value['habit_title'].toString();
    final enteredDoneFrequency =
        _formKeyBad.currentState!.fields['done_frequency']!.value;
    final enteredTimesDay =
        int.parse(_formKeyBad.currentState!.value['times_day'].toString());
    final enteredCostPerTime =
        int.parse(_formKeyBad.currentState!.value['cost_per_time'].toString());
    final enteredDifficultyLevel =
        _formKeyBad.currentState!.fields['difficulty_level']!.value;
    final enteredStartDate =
        _formKeyBad.currentState!.fields['start_date']!.value as DateTime;

    // final enteredReason = _reasonController.text;
    List<String> enteredReasonList = [];

    // int calculatedDuration = DateTime.now().difference(_selectedDate!).inDays;

    widget.addHt(
      enteredTitle,
      enteredReasonList,
      enteredDoneFrequency,
      enteredTimesDay,
      enteredCostPerTime,
      // _selectedDate,
      enteredDifficultyLevel,
      enteredStartDate,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isCustom ? Text('New Custom Habit') : Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: FormBuilder(
            key: _formKeyBad,
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
                  validator: titleValidator,
                ),
                FormBuilderDropdown(
                  name: 'done_frequency',
                  items: _frequencyTypeItemsDropdownMenuItems,
                  dropdownColor: Colors.lightBlue[100],
                  initialValue: frequencyTypeItems[0],
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Choose Frequency",
                    alignLabelWithHint: false,
                    icon: Icon(Icons.alarm_add_rounded),
                  ),
                ),
                FormBuilderTextField(
                  name: 'times_day',
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
                  initialValue: difficultyMenuItems[0],
                  elevation: 10,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Choose Difficulty",
                    alignLabelWithHint: false,
                    icon: Icon(Icons.personal_injury),
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
