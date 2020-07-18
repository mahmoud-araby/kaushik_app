import 'package:kaushik_app/constants/route_names.dart';

class DailyResults {
  double hoursWorked;
  bool nap;
  int napStartHour;
  int napStartMinute;
  int napEndHour;
  int napEndMinute;
  bool exercise;
  String currentRoute;

  bool breakfast;
  bool launch;
  bool dinner;

  bool isCompleted = false;

  DailyResults() {
    currentRoute = workQuestionRoute;
    isCompleted = false;
  }
}
