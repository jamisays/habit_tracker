import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  // final _formKeyGood = GlobalKey<FormBuilderState>();

  final _titleController = TextEditingController();
  final _durationController = TextEditingController();
  final _flexDaysController = TextEditingController();
  final _repDaysController = TextEditingController();
  final _timesDayController = TextEditingController();
  DateTime? _selectedDate;

  var _isLoading = false;

  static const difficultyMenuItems = <String>[
    'Easy',
    'Medium',
    'Hard',
  ];

  String _difficultyMenuDefaultValue = 'Easy';

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
      _isLoading = true;
    });
    var enteredTitle = _titleController.text;
    var enteredFlexDays;
    var enteredRepDays;
    _flexDaysController.text == ''
        ? enteredFlexDays = 0
        : enteredFlexDays = int.parse(_flexDaysController.text);

    _repDaysController.text == ''
        ? enteredRepDays = 0
        : enteredRepDays = int.parse(_repDaysController.text);

    final enteredDuration = int.parse(_durationController.text);
    final enteredTimesDay = int.parse(_timesDayController.text);

    if (widget.isCustom == false) enteredTitle = widget.title;
    if (enteredTitle.isEmpty ||
        enteredDuration < 0 ||
        _selectedDate == null ||
        // ignore: unnecessary_null_comparison
        enteredTimesDay == null) {
      return;
    }

    int calculatedDuration = DateTime.now()
        .difference(_selectedDate!)
        .inDays; // for calculating days from inputted date
    try {
      await widget.addHt(
        enteredTitle,
        enteredDuration,
        selectedScheduleType,
        habitDays,
        enteredFlexDays,
        _timesPerOptionsDefaultValue,
        enteredRepDays,
        enteredTimesDay,
        _selectedDate,
        calculatedDuration,
        _difficultyMenuDefaultValue,
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
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }

    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text('Habit Added!'),
    //   duration: Duration(seconds: 3),
    // ));
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  Widget buildScheduleContent() {
    return Row(
      children: [
        Text(
          'I will do this  ',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        Container(
          width: 30,
          child: TextField(
            controller: _timesDayController,
            keyboardType: TextInputType.number,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
        Text('  times per day'),
      ],
    );
  }

  String value = 'fix';

  String selectedScheduleType = 'fix';

  List<S2Choice<String>> scheduleItems = [
    S2Choice<String>(value: 'fix', title: 'Fixed'),
    S2Choice<String>(value: 'fle', title: 'Flexible'),
    S2Choice<String>(value: 'rep', title: 'Repeating'),
  ];

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
    switch (selectedScheduleType) {
      case 'fix':
        return SmartSelect<String>.multiple(
          title: 'Select Days',
          // modalActionsBuilder: (context, value) {
          //   return [selectAllDays()];
          // },
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
        return Row(
          children: [
            Text(
              'I will do this  ',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Container(
              width: 30,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _flexDaysController,
                // onSubmitted: (_) => _submitData(),
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Text('  days per'),
            Container(
              width: 120,
              child: ListTile(
                trailing: DropdownButton(
                  hint: const Text('Choose'),
                  value: _timesPerOptionsDefaultValue,
                  elevation: 7,
                  onChanged: (String? dValue) {
                    setState(() {
                      _timesPerOptionsDefaultValue = dValue!;
                    });
                  },
                  items: _timesPerOptionsDropdownMenuItems,
                ),
              ),
            ),
          ],
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
              child: TextField(
                controller: _repDaysController,
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.only(
                      top: 10,
                      left: 10,
                      right: 10,
                      bottom: MediaQuery.of(context).viewInsets.bottom + 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      widget.isCustom
                          ? TextField(
                              decoration: const InputDecoration(
                                  labelText: 'Habit Name'),
                              // onChanged: (value) {
                              //   titleInput = value;
                              // },
                              controller: _titleController,

                              onSubmitted: (_) => _submitData(),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Customize existing habit: ' + widget.title,
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                      SmartSelect<String>.single(
                        title: 'Schedule Type',
                        selectedValue: value,
                        // value: value,
                        choiceItems: scheduleItems,
                        modalType: S2ModalType.popupDialog,
                        onChange: (state) => setState(() {
                          value = state.value!;
                          selectedScheduleType = state.value!;
                        }),
                      ),

                      buildCustomContent,

                      buildScheduleContent(),

                      TextField(
                        decoration:
                            const InputDecoration(labelText: 'Karma Point'),
                        // onChanged: (value) {
                        //   durationInput = value;
                        // },
                        controller: _durationController,
                        keyboardType: TextInputType.number,
                        onSubmitted: (_) => _submitData(),
                      ),

                      ListTile(
                        title: const Text('Choose Difficulty:'),
                        trailing: DropdownButton(
                          hint: const Text('Choose'),
                          value: _difficultyMenuDefaultValue,
                          elevation: 7,
                          onChanged: (String? dValue) {
                            setState(() {
                              _difficultyMenuDefaultValue = dValue!;
                            });
                          },
                          items: _difficultyDropdownMenuItems,
                        ),
                      ),
                      // Schedule Option

                      Container(
                        height: 70,
                        child: Row(children: <Widget>[
                          Expanded(
                            child: Text(
                              _selectedDate == null
                                  ? 'No Date Selected!'
                                  : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
                            ),
                          ),
                          TextButton(
                            // textColor: Theme.of(context).primaryColor, // if FlatButton used
                            onPressed: _showDatePicker,
                            child: const Text(
                              'Choose Date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: _submitData,
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
