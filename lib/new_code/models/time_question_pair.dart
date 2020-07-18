import 'package:flutter/cupertino.dart';
import 'package:kaushik_app/new_code/models/question.dart';
import 'package:kaushik_app/new_code/models/time_question.dart';
import 'package:kaushik_app/new_code/models/yes_or_no_question.dart';

class TimeQuestionPair implements Question {
  YesOrNoQuestion startQuestion;
  TimeQuestion napStartQuestion;
  TimeQuestion napEndQuestion;
  final bool isMultiple = true;
  bool secondQuestionDefaultRestriction;
  final String question = null;
  String errorMessage;
  dynamic answer = {1: DateTime.now(), 2: DateTime.now()};
  int index = 0;
  bool didHappen = true;
  TimeQuestionPair(
      {@required this.startQuestion,
      @required this.napStartQuestion,
      @required this.napEndQuestion,
      @required this.errorMessage,
      this.secondQuestionDefaultRestriction = false});
}
