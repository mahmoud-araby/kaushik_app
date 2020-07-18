import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaushik_app/child_screens/daily_router.dart';
import 'package:kaushik_app/constants/route_names.dart';
import 'package:kaushik_app/models/daily_results.dart';
import 'package:kaushik_app/models/transition_argument.dart';
import 'package:kaushik_app/services/navigation_service.dart';

import '../../locator.dart';

class NapEndQuestion extends StatefulWidget {
  final DailyResults result;
  final bool canSkip;
  const NapEndQuestion({Key key, this.result, this.canSkip = false})
      : super(key: key);
  @override
  _NapEndQuestionState createState() => _NapEndQuestionState();
}

class _NapEndQuestionState extends State<NapEndQuestion> {
  NavigationService _navigationService = locator<NavigationService>();
  DateTime selectedTime;
  @override
  void initState() {
    if (widget.result.napEndHour != null &&
        widget.result.napEndMinute != null) {
      DateTime tmp = new DateTime.now();
      selectedTime = new DateTime(
        tmp.year,
        tmp.month,
        tmp.day,
        widget.result.napEndHour,
        widget.result.napEndMinute,
      );
    } else {
      selectedTime = new DateTime.now();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20),
            alignment: Alignment.bottomRight,
            child: CupertinoButton(
              child: Icon(Icons.close),
              onPressed: () {
                _navigationService.close(context);
              },
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Text("When did you wake up from your nap?"),
                Container(
                  height: 300,
                  child: CupertinoDatePicker(
                    initialDateTime: selectedTime,
                    mode: CupertinoDatePickerMode.time,
                    use24hFormat: false,
                    onDateTimeChanged: (value) {
                      selectedTime = value;
                    },
                  ),
                ),
                CupertinoButton(
                  child: Text("Submit"),
                  onPressed: () {
                    if (validate()) {
                      widget.result.napEndHour = selectedTime.hour;
                      widget.result.napEndMinute = selectedTime.minute;
                      _navigationService
                          .submitAndNavigateTo(
                        mealQuestionRoute,
                        arguments:
                            TransitionArguments("forward", widget.result),
                      )
                          .then((value) {
                        setState(() {});
                      });
                    } else {
                      displayDialog();
                    }
                  },
                ),
                if (historyId < history.length - 1 || widget.canSkip == true)
                  CupertinoButton(
                    child: Text("Go to next question"),
                    onPressed: () {
                      _navigationService
                          .skip(TransitionArguments("forward", widget.result))
                          .then((value) {
                        setState(() {});
                      });
                    },
                  ),
                CupertinoButton(
                  child: Text("Back to previous question"),
                  onPressed: () {
                    _navigationService.pop();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  bool validate() {
    int napStartHour = widget.result.napStartHour;
    int napStartMinute = widget.result.napStartMinute;
    if (napStartHour > selectedTime.hour) {
      return false;
    } else if (napStartMinute > selectedTime.minute) {
      return false;
    }
    return true;
  }

  void displayDialog() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text("Error"),
        content:
            new Text("Wake-up time must be later than the start of your nap."),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: new Text("Okay"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
