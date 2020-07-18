import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaushik_app/child_screens/question_screens/exercise_question.dart';
import 'package:kaushik_app/child_screens/question_screens/meal_question.dart';
import 'package:kaushik_app/child_screens/question_screens/nap_end_question.dart';
import 'package:kaushik_app/child_screens/question_screens/nap_question.dart';
import 'package:kaushik_app/child_screens/question_screens/nap_start_question.dart';
import 'package:kaushik_app/child_screens/question_screens/thankyou.dart';
import 'package:kaushik_app/child_screens/question_screens/work_question.dart';
import 'package:kaushik_app/constants/route_names.dart';
import 'package:kaushik_app/models/daily_results.dart';
import 'package:kaushik_app/models/transition_argument.dart';

import '../home_screen.dart';

bool isClose = false;
List<String> history = new List<String>();
int historyId = -1;

class DailyLogRouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final TransitionArguments args = settings.arguments;
    String transitionEffect = "";
    DailyResults result;
    bool canSkip;
    if (args != null) {
      transitionEffect = args.transitionEffect;
      result = args.result;
      result.currentRoute = settings.name;
      canSkip = args.canSkip;
    }

    switch (settings.name) {
      case workQuestionRoute:
        return _getPageRoute(
            routeName: settings.name,
            viewToShow: WorkQuestion(
              result: result,
              canSkip: canSkip,
            ),
            strEffect: transitionEffect);
        break;
      case napQuestionRoute:
        return _getPageRoute(
            routeName: settings.name,
            viewToShow: NapQuestion(
              result: result,
              canSkip: canSkip,
            ),
            strEffect: transitionEffect);
        break;
      case napStartQuestionRoute:
        return _getPageRoute(
            routeName: settings.name,
            viewToShow: NapStartQuestion(
              result: result,
              canSkip: canSkip,
            ),
            strEffect: transitionEffect);
        break;
      case napEndQeustionRoute:
        return _getPageRoute(
            routeName: settings.name,
            viewToShow: NapEndQuestion(
              result: result,
              canSkip: canSkip,
            ),
            strEffect: transitionEffect);
        break;
      case mealQuestionRoute:
        return _getPageRoute(
            routeName: settings.name,
            viewToShow: MealQuestion(
              result: result,
              canSkip: canSkip,
            ),
            strEffect: transitionEffect);
        break;
      case exerciseQuestionRoute:
        return _getPageRoute(
            routeName: settings.name,
            viewToShow: ExerciseQuestion(
              result: result,
              canSkip: canSkip,
            ),
            strEffect: transitionEffect);
        break;
      case thankyouRoute:
        return _getPageRoute(
            routeName: settings.name,
            viewToShow: ThankYou(
              result: result,
              canSkip: canSkip,
            ),
            strEffect: transitionEffect);
        break;
      case homeRoute:
        return _getPageRoute(
            routeName: settings.name,
            viewToShow: HomeScreen(),
            strEffect: transitionEffect);
        break;
      default:
        return CupertinoPageRoute(
          builder: (_) =>
              Center(child: Text('No route defined for ${settings.name}')),
        );
    }
  }

  static PageRoute _getPageRoute(
      {String routeName, Widget viewToShow, String strEffect}) {
    return MyCustomRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow,
      strEffect: strEffect,
    );
  }
}

class MyCustomRoute<T> extends CupertinoPageRoute<T> {
  final String strEffect;
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings, this.strEffect})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    var begin = Offset(0.0, 1.0);

    switch (strEffect) {
      case "below-up":
        begin = Offset(0.0, 1.0);
        break;
      case "forward":
        begin = Offset(1.0, 0.0);
        break;
      case "backward":
        begin = Offset(-1.0, 0.0);
        break;
      case "close":
        begin = Offset(0.0, 1.0);
        break;
    }

    var end = Offset.zero;
    var curve = Curves.ease;

    if (isClose == true) {
      begin = Offset(0.0, 1.0);
      end = Offset.zero;
    } else if (animation.status == AnimationStatus.reverse) {
      begin = Offset(1.0, 0.0);
    }

    var tween = Tween(begin: begin, end: end);
    var curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: curve,
    );

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      ),
    );
  }
}
