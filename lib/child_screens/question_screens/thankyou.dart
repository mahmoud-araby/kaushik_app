import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaushik_app/models/daily_results.dart';
import 'package:kaushik_app/services/navigation_service.dart';
import '../daily_router.dart';
import '../../locator.dart';

class ThankYou extends StatefulWidget {
  final DailyResults result;
  final bool canSkip;
  const ThankYou({Key key, this.result, this.canSkip = false})
      : super(key: key);

  @override
  _ThankYouState createState() => _ThankYouState();
}

class _ThankYouState extends State<ThankYou> {
  NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
    super.initState();
    widget.result.isCompleted = true;
    history.clear();
    historyId = -1;
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
            child: Center(
              child: Text("Thank you for completing your daily log"),
            ),
          )
        ],
      ),
    );
  }
}
