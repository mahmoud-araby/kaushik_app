import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaushik_app/child_screens/daily_router.dart';
import 'package:kaushik_app/constants/route_names.dart';
import 'package:kaushik_app/models/daily_results.dart';
import 'package:kaushik_app/models/transition_argument.dart';
import 'package:kaushik_app/services/navigation_service.dart';

import '../../locator.dart';

class WorkQuestion extends StatefulWidget {
  final DailyResults result;
  final bool canSkip;
  const WorkQuestion({Key key, this.result, this.canSkip = false})
      : super(key: key);

  @override
  _WorkQuestionState createState() => _WorkQuestionState();
}

class _WorkQuestionState extends State<WorkQuestion> {
  NavigationService _navigationService = locator<NavigationService>();

  double hours = 0;
  @override
  void initState() {
    super.initState();
    if (widget.result.hoursWorked != null) {
      setState(() {
        hours = widget.result.hoursWorked;
      });
    }
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
                Text("How much did you work yesterday?"),
                Text("$hours Hours"),
                CupertinoSlider(
                  min: 0,
                  max: 8,
                  value: hours,
                  divisions: 80,
                  onChanged: (val) {
                    setState(() {
                      hours = val;
                    });
                  },
                ),
                CupertinoButton(
                  child: Text("Submit"),
                  onPressed: () {
                    widget.result.hoursWorked = hours;
                    _navigationService
                        .submitAndNavigateTo(
                      napQuestionRoute,
                      arguments: TransitionArguments("forward", widget.result),
                    )
                        .then((value) {
                      setState(() {});
                    });
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
