import 'package:flutter/cupertino.dart';
import 'package:kaushik_app/new_code/models/question.dart';

class MultipleOptionQuestion extends StatefulWidget implements Question {
  final String question;
  final bool isMultiple = false;
  dynamic answer = {
    'option1': false,
    'option2': false,
    'option3': false,
    'option4': false,
    'option5': false,
  };
  bool optionOne = false;
  final String optionOneString;

  bool optionTwo = false;
  final String optionTwoString;

  bool optionThree = false;
  final String optionThreeString;

  bool optionFour = false;
  final String optionFourString;

  bool optionFive = false;
  final String optionFiveString;

  @override
  _MultipleOptionQuestionState createState() => _MultipleOptionQuestionState();

  MultipleOptionQuestion(
      {@required this.question,
      @required this.optionOneString,
      this.optionTwoString,
      this.optionThreeString,
      this.optionFourString,
      this.optionFiveString});
}

class _MultipleOptionQuestionState extends State<MultipleOptionQuestion> {
  questionHeader() {
    return Text(widget.question);
  }

  questionAnswer() {
    return Column(
      children: <Widget>[
        widget.optionOneString != null
            ? CupertinoButton(
                child: Text(
                  widget.optionOneString,
                  style: TextStyle(
                      fontWeight:
                          widget.optionOne == true ? FontWeight.bold : null),
                ),
                onPressed: () {
                  setState(
                    () {
                      widget.optionOne =
                          widget.optionOne == !widget.optionTwo ?? true;
                      widget.answer['option1'] = widget.optionOne;
                    },
                  );
                },
              )
            : Container(),
        widget.optionTwoString != null
            ? CupertinoButton(
                child: Text(
                  widget.optionTwoString,
                  style: TextStyle(
                      fontWeight:
                          widget.optionTwo == true ? FontWeight.bold : null),
                ),
                onPressed: () {
                  setState(() {
                    widget.optionTwo = !widget.optionTwo ?? true;
                    widget.answer['option2'] = widget.optionTwo;
                  });
                },
              )
            : Container(),
        widget.optionThreeString != null
            ? CupertinoButton(
                child: Text(
                  widget.optionThreeString,
                  style: TextStyle(
                      fontWeight:
                          widget.optionThree == true ? FontWeight.bold : null),
                ),
                onPressed: () {
                  setState(() {
                    widget.optionThree = !widget.optionThree ?? true;
                    widget.answer['option3'] = widget.optionThree;
                  });
                },
              )
            : Container(),
        widget.optionFourString != null
            ? CupertinoButton(
                child: Text(
                  widget.optionFourString,
                  style: TextStyle(
                      fontWeight:
                          widget.optionFour == true ? FontWeight.bold : null),
                ),
                onPressed: () {
                  setState(() {
                    widget.optionFour = !widget.optionFour ?? true;
                    widget.answer['option4'] = widget.optionFour;
                  });
                },
              )
            : Container(),
        widget.optionFiveString != null
            ? CupertinoButton(
                child: Text(
                  widget.optionFiveString,
                  style: TextStyle(
                      fontWeight:
                          widget.optionFive == true ? FontWeight.bold : null),
                ),
                onPressed: () {
                  setState(() {
                    widget.optionFive = !widget.optionFive ?? true;
                    widget.answer['option5'] = widget.optionFive;
                  });
                },
              )
            : Container(),
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
