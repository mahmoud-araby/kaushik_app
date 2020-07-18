import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaushik_app/child_screens/daily_router.dart';
import 'package:kaushik_app/constants/route_names.dart';
import 'package:kaushik_app/models/daily_results.dart';
import 'package:kaushik_app/models/transition_argument.dart';
import 'package:kaushik_app/services/navigation_service.dart';

import '../../locator.dart';

class NapQuestion extends StatefulWidget {
  final DailyResults result;
  final bool canSkip;
  const NapQuestion({Key key, this.result, this.canSkip = false})
      : super(key: key);

  @override
  _NapQuestionState createState() => _NapQuestionState();
}

class _NapQuestionState extends State<NapQuestion> {
  NavigationService _navigationService = locator<NavigationService>();
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
                // Navigator.pop(context);
                _navigationService.close(context);
              },
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Text("Did you take a nap yesterday?"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text(
                        "Yes",
                        style: TextStyle(
                          fontWeight: widget.result.nap == true
                              ? FontWeight.bold
                              : null,
                        ),
                      ),
                      onPressed: () {
                        widget.result.nap = true;
                        _navigationService
                            .submitAndNavigateTo(
                          napStartQuestionRoute,
                          arguments:
                              TransitionArguments("forward", widget.result),
                        )
                            .then((value) {
                          setState(() {});
                        });
                      },
                    ),
                    CupertinoButton(
                      child: Text(
                        "No",
                        style: TextStyle(
                          fontWeight: widget.result.nap == false
                              ? FontWeight.bold
                              : null,
                        ),
                      ),
                      onPressed: () {
                        widget.result.nap = false;
                        _navigationService
                            .submitAndNavigateTo(
                          exerciseQuestionRoute,
                          arguments:
                              TransitionArguments("forward", widget.result),
                        )
                            .then((value) {
                          setState(() {});
                        });
                      },
                    ),
                  ],
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
}
