import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaushik_app/child_screens/daily_router.dart';
import 'package:kaushik_app/locator.dart';
import 'package:kaushik_app/models/daily_results.dart';
import 'package:kaushik_app/models/transition_argument.dart';
import 'package:kaushik_app/new_code/page/test_daily_log.dart';
import 'package:kaushik_app/services/navigation_service.dart';

import './info_for_b1.dart';
import './info_for_b2.dart';

class BTab extends StatefulWidget {
  @override
  _BTabState createState() => _BTabState();
}

DailyResults result;
List<dynamic> testResult;

class _BTabState extends State<BTab> {
  NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      // itemExtent: 50,
      children: <Widget>[
        buildContainer(context, "B1", Info_for_B1()),
        buildContainer(context, "B2", Info_for_B2()),
        Divider(),
        CupertinoButton(
          child: Text(result == null
              ? "Daily Log"
              : result.isCompleted
                  ? "Daily Log Complete"
                  : result.hoursWorked != null
                      ? "Daily Log In Progress"
                      : "Daily Log"),
          onPressed: result != null && result.isCompleted
              ? null
              : () {
                  isClose = false;

                  // new
                  if (result == null) {
                    result = new DailyResults();

                    _navigationService
                        .navigateTo(
                      result.currentRoute,
                      arguments: new TransitionArguments("", result),
                    )
                        .then((value) {
                      setState(() {});
                    });
                  } else {
                    // in progress
                    _navigationService.restoreHistory(
                        new TransitionArguments("", result, canSkip: true));
                  }
                },
        ),
        CupertinoButton(
          child: Text(testResult == null
              ? "Test Daily Log"
              : "Test Daily Log Complete"),
          onPressed: testResult == null
              ? () {
                  Navigator.push<List<dynamic>>(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TestDailyLog())).then((value) {
                    setState(() {
                      testResult = value;
                    });
                  });
                }
              : null,
        )
      ],
    );
  }

  Container buildContainer(
      BuildContext context, String title, Widget infoWidget) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: CupertinoTheme.of(context)
                .textTheme
                .actionTextStyle
                .copyWith(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          CupertinoButton(
            child: Icon(CupertinoIcons.info),
            onPressed: () {
              showGeneralDialog(
                barrierDismissible: false,
                barrierLabel: 'Settings',
                barrierColor: CupertinoColors.white,
                context: context,
                transitionDuration: const Duration(seconds: 1),
                pageBuilder: (context, animation, secondaryAnimation) {
                  return CupertinoFullscreenDialogTransition(
                    primaryRouteAnimation: animation,
                    secondaryRouteAnimation: secondaryAnimation,
                    child: Center(
                      child: infoWidget,
                    ),
                    linearTransition: true,
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
