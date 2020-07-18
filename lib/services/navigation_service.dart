import 'package:flutter/cupertino.dart';
import 'package:kaushik_app/child_screens/daily_router.dart';
import 'package:kaushik_app/constants/route_names.dart';
import 'package:kaushik_app/models/transition_argument.dart';

class NavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  pop() {
    historyId--;
    _navigationKey.currentState.pop();
    
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    historyId++;
    history.add(routeName);

    return _navigationKey.currentState
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> skip(dynamic arguments) {
    // skip
    if (historyId < history.length) {
      historyId++;
      return _navigationKey.currentState
          .pushNamed(history[historyId], arguments: arguments);
    } else {
      return null;
    }
  }

  Future<dynamic> submitAndNavigateTo(String routeName, {dynamic arguments}) {
    try {
      history.removeRange(historyId + 1, history.length);
    } catch (e) {}
    historyId = history.length;
    history.add(routeName);

    return _navigationKey.currentState
        .pushNamed(routeName, arguments: arguments);
  }

  void close(BuildContext context) {
    isClose = true;
    _navigationKey.currentState.popUntil(ModalRoute.withName(homeRoute));

  }

  void restoreHistory(TransitionArguments transitionArguments) {
    for (int i = 0; i <= historyId; i++) {
      if(i == historyId){
        transitionArguments.canSkip = false;
      }
      _navigationKey.currentState
          .pushNamed(history[i], arguments: transitionArguments);
    }
  }

}
