import 'package:flutter/material.dart';

// import 'package:habit_tracker/models/eventSource.dart';
// import 'package:hive/hive.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
// import 'package:provider/provider.dart';

import '../../utils.dart';

class VolumeAlert extends StatefulWidget {
  final DateTime focusedDay;
  final String title;

  // VolumeAlert(this.focusedDay, this.title);
  VolumeAlert({Key? key, required this.focusedDay, required this.title})
      : super(key: key);

  @override
  _VolumeAlertState createState() => _VolumeAlertState();
}

class _VolumeAlertState extends State<VolumeAlert> {
  // final _howMuchController = TextEditingController();
  late bool allDoneCheck;

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            print('Undo');
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var element;
    element = kEvents[widget.focusedDay]!.firstWhere((element) {
      return element.title == widget.title;
    });

    allDoneCheck = element.isDone;

    var tempTimesDaySpinValue = 0;

    return Container(
        child: AlertDialog(
      title: Text('Volume'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('How many times?'),
            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  child: SpinBox(
                    interval: Duration(milliseconds: 600),
                    keyboardType: TextInputType.number,
                    value: 0,
                    min: 0,
                    max: double.parse((element.timesDay - element.doneTimes)
                                .toString()) >=
                            1
                        ? double.parse(
                            (element.timesDay - element.doneTimes).toString())
                        : 1,
                    onChanged: (value) {
                      tempTimesDaySpinValue = value.toInt();
                    },
                  ),
                ),
                Container(
                  width: 150,
                  child: CheckboxListTile(
                    title: Text('All Done'),
                    value: allDoneCheck,
                    checkColor: Colors.black,
                    tileColor: Colors.lightBlueAccent.shade100,
                    onChanged: (bool? value) {
                      setState(() {
                        allDoneCheck = value!;
                        print(value);
                        if (value == true) {
                          element.isDone = true;
                          element.doneTimes = element.timesDay;
                          // var box = Hive.box<EventSource>('event_source');
                          // var x = EventSource(kEvents);
                          // box.putAt(0, x);
                        } else {
                          element.isDone = false;
                          element.doneTimes = 0;
                        }
                      });
                    },
                    // secondary: Icon(Icons.hourglass_empty_rounded),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Ok'),
          onPressed: () {
            // Navigator.pop(
            //     context,
            //     int.parse(_howMuchController.text.isEmpty
            //         ? '0'
            //         : _howMuchController.text));
            Navigator.pop(context, tempTimesDaySpinValue);
            _showSnackBar('Done');
          },
        ),
      ],
    ));
  }
}
