import 'package:kaushik_app/models/daily_results.dart';

class TransitionArguments {
  final String transitionEffect;
  final DailyResults result;
  bool canSkip;
  TransitionArguments(this.transitionEffect, this.result,
      {this.canSkip = false});
}
