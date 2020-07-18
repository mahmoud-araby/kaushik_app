import 'package:flutter/cupertino.dart';
import 'package:kaushik_app/new_code/models/question.dart';

// ignore: must_be_immutable
class YesOrNoQuestion extends StatefulWidget implements Question {
  final String question;
  dynamic answer;
  final bool isMultiple = false;
  bool value;

  @override
  _YesOrNoQuestionState createState() => _YesOrNoQuestionState();

  YesOrNoQuestion({@required this.question, this.value});
}

class _YesOrNoQuestionState extends State<YesOrNoQuestion> {
  questionHeader() {
    return Text(widget.question);
  }

  questionAnswer() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoButton(
              child: Text(
                "Yes",
                style: TextStyle(
                  fontWeight: widget.value == true ? FontWeight.bold : null,
                ),
              ),
              onPressed: () {
                setState(() {
                  widget.value = true;
                  widget.answer = true;
                });
              },
            ),
            CupertinoButton(
              child: Text(
                "No",
                style: TextStyle(
                  fontWeight: widget.value == false ? FontWeight.bold : null,
                ),
              ),
              onPressed: () {
                setState(() {
                  widget.value = false;
                  widget.answer = false;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    widget.answer = widget.value;
    return Column(
      children: <Widget>[
        questionHeader(),
        questionAnswer(),
      ],
    );
  }
}
