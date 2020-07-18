import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaushik_app/constants/route_names.dart';
import 'package:kaushik_app/models/daily_results.dart';
import 'package:kaushik_app/models/transition_argument.dart';
import 'package:kaushik_app/services/navigation_service.dart';

import '../../locator.dart';
import '../daily_router.dart';

enum MealName { Breakfast, Launch, Dinner }

class MealQuestion extends StatefulWidget {
  final DailyResults result;
  final bool canSkip;

  const MealQuestion({Key key, this.result, this.canSkip}) : super(key: key);
  @override
  _MealQuestionState createState() => _MealQuestionState();
}

class _MealQuestionState extends State<MealQuestion> {
  NavigationService _navigationService = locator<NavigationService>();
  bool breakfast;
  bool launch;
  bool dinner;
  @override
  void initState() {
    breakfast =
        widget.result.breakfast == null ? false : widget.result.breakfast;
    launch = widget.result.launch == null ? false : widget.result.launch;
    dinner = widget.result.dinner == null ? false : widget.result.dinner;
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
                Text(
                  "Which meal(s) did you eat yesterday?\nSelect all that apply.",
                  textAlign: TextAlign.center,
                ),
                buildMealButton(MealName.Breakfast),
                buildMealButton(MealName.Launch),
                buildMealButton(MealName.Dinner),
                CupertinoButton(
                  child: Text("Submit"),
                  onPressed: () {
                    widget.result.breakfast = breakfast;
                    widget.result.launch = launch;
                    widget.result.dinner = dinner;
                    _navigationService
                        .submitAndNavigateTo(
                      exerciseQuestionRoute,
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

  buildMealButton(MealName name) {
    bool isSelected = false;
    String mealName = "";
    switch (name) {
      case MealName.Breakfast:
        isSelected = breakfast;
        mealName = "Breakfast";
        break;
      case MealName.Launch:
        isSelected = launch;
        mealName = "Launch";
        break;
      case MealName.Dinner:
        isSelected = dinner;
        mealName = "Dinner";
        break;
      default:
        isSelected = false;
        break;
    }
    return CupertinoButton(
      child: Text(
        mealName,
        style:
            TextStyle(fontWeight: isSelected == true ? FontWeight.bold : null),
      ),
      onPressed: () {
        setState(() {
          switch (name) {
            case MealName.Breakfast:
              breakfast = !breakfast;
              break;
            case MealName.Launch:
              launch = !launch;
              break;
            case MealName.Dinner:
              dinner = !dinner;
              break;
            default:
              isSelected = false;
              break;
          }
        });
      },
    );
  }
}
