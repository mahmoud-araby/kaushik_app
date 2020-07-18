import 'package:flutter/cupertino.dart';
import 'package:kaushik_app/new_code/models/question.dart';

// ignore: must_be_immutable
class TimeQuestion extends StatefulWidget implements Question {
  final String question;
  final bool isMultiple = false;
  dynamic answer = DateTime.now();
  DateTime selectedTime = DateTime.now();
  @override
  _TimeQuestionState createState() => _TimeQuestionState();

  TimeQuestion({@required this.question, this.selectedTime});
}

class _TimeQuestionState extends State<TimeQuestion> {
  questionHeader() {
    return Text(widget.question);
  }

  questionAnswer() {
    return Column(
      children: <Widget>[
        Container(
          height: 300,
          child: CupertinoDatePicker(
            initialDateTime: widget.selectedTime,
            mode: CupertinoDatePickerMode.time,
            use24hFormat: false,
            onDateTimeChanged: (value) {
              widget.selectedTime = value;
              widget.answer = value;
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        questionHeader(),
        questionAnswer(),
      ],
    );
  }
}
