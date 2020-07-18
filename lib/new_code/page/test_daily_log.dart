import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaushik_app/new_code/models/question.dart';
import 'package:kaushik_app/new_code/models/time_question_pair.dart';

import 'TestQuestions.dart';

class TestDailyLog extends StatefulWidget {
  List<Question> questions = [
    TestWorkQuestion,
    TestNapQuestionPair,
    TestMealQuestion,
    TestExerciseQuestion,
  ];
  @override
  _TestDailyLogState createState() => _TestDailyLogState();
}

class _TestDailyLogState extends State<TestDailyLog> {
  List<dynamic> answers;
  int index = 0;
  int previousIndex = 0;
  bool backwardState = false;
  bool isDone = false;
  TimeQuestionPair multipleQuestion;
  @override
  void initState() {
    answers = List(widget.questions.length);
    super.initState();
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
                if (isDone) {
                  Navigator.pop(context, answers);
                } else if (isDone == false) {
                  Navigator.pop(context, null);
                }
              },
            ),
          ),
          isDone ? thankYouPage() : checkMultipleQuestion(),
        ],
      ),
    );
  }

  checkMultipleQuestion() {
    if (!widget.questions[index].isMultiple) {
      return Expanded(
        child: Column(
          children: <Widget>[
            getQuestion(),
            getSubmitButton(),
            getForwardButton(),
            getBackwardButton(),
          ],
        ),
      );
    } else {
      return getMultipleQuestion();
    }
  }

  getMultipleQuestion() {
    multipleQuestion = widget.questions[index];
    return multipleQuestionView();
  }

  getQuestion() {
    return widget.questions[index];
  }

  getBackwardButton() {
    return (index > 0)
        ? CupertinoButton(
            child: Text("Back to previous question"),
            onPressed: () {
              setState(() {
                index--;
                previousIndex++;
                backwardState = true;
              });
            },
          )
        : Container(
            height: 1,
          );
  }

  getForwardButton() {
    return backwardState == true
        ? CupertinoButton(
            child: Text("Go to next question"),
            onPressed: () {
              returnToNextQuestion();
            },
          )
        : Container(
            height: 1,
          );
  }

  getSubmitButton() {
    return CupertinoButton(
      child: Text("Submit"),
      onPressed: () {
        setState(() {
          answers[index] = widget.questions[index].answer;
          print(answers);
          if (index < widget.questions.length - 1) {
            if (backwardState) {
              returnToNextQuestion();
            } else {
              index = index + 1;
            }
          } else {
            setState(() {
              isDone = true;
            });
          }
        });
      },
    );
  }

  returnToNextQuestion() {
    setState(() {
      previousIndex--;
      if (previousIndex == 0) {
        backwardState = false;
      }
      index++;
    });
  }

  thankYouPage() {
    return Expanded(
      child: Center(
        child: CupertinoButton(
          child: Text("Thank you for completing your daily log"),
          onPressed: () {
            Navigator.pop(context, answers);
          },
        ),
      ),
    );
  }

  multipleQuestionView() {
    return Column(
      children: <Widget>[
        getMultipleTimeQuestionIndex(),
        CupertinoButton(
          child: Text("Submit"),
          onPressed: () {
            setState(
              () {
                if (multipleQuestion.index == 0) {
                  multipleQuestion.didHappen =
                      multipleQuestion.startQuestion.answer;
                  if (multipleQuestion.didHappen != true) {
                    setState(() {
                      answers[index] = widget.questions[index].answer;
                      print(answers);
                      if (index < widget.questions.length - 1) {
                        if (backwardState) {
                          returnToNextQuestion();
                        } else {
                          index = index + 1;
                        }
                      } else {
                        setState(() {
                          isDone = true;
                        });
                      }
                    });
                  }
                  multipleQuestion.index++;
                } else if (multipleQuestion.index == 1) {
                  multipleQuestion.answer[1] =
                      multipleQuestion.napStartQuestion.answer;
                  multipleQuestion.index++;
                } else if (multipleQuestion.index == 2) {
                  multipleQuestion.answer[2] =
                      multipleQuestion.napEndQuestion.answer;

                  if (multipleQuestion.secondQuestionDefaultRestriction) {
                    if (multipleQuestion.answer[2]
                        .isBefore(multipleQuestion.answer[1])) {
                      displayDialog();
                      return;
                    }
                  }
                  answers[index] = multipleQuestion.answer;
                  if (index < widget.questions.length - 1) {
                    if (backwardState) {
                      returnToNextQuestion();
                    } else {
                      index = index + 1;
                    }
                  } else {
                    setState(() {
                      isDone = true;
                    });
                  }
                }
              },
            );
          },
        ),
        (index > 0)
            ? CupertinoButton(
                child: Text("Back to previous question"),
                onPressed: () {
                  if (multipleQuestion.index == 0) {
                    setState(() {
                      index--;
                      previousIndex++;
                      backwardState = true;
                    });
                  } else {
                    setState(() {
                      multipleQuestion.index--;
                    });
                  }
                },
              )
            : Container(
                height: 1,
              ),
        backwardState == true
            ? CupertinoButton(
                child: Text("Go to next question"),
                onPressed: () {
                  if (multipleQuestion.index == 2) {
                    returnToNextQuestion();
                  } else {
                    setState(() {
                      multipleQuestion.index++;
                    });
                  }
                },
              )
            : Container(
                height: 1,
              ),
      ],
    );
  }

  getMultipleTimeQuestionIndex() {
    if (multipleQuestion.index == 0) {
      return multipleQuestion.startQuestion;
    } else if (multipleQuestion.index == 1) {
      return multipleQuestion.napStartQuestion;
    } else {
      return multipleQuestion.napEndQuestion;
    }
  }

  void displayDialog() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text(multipleQuestion.errorMessage),
        content: new Text(multipleQuestion.errorMessage),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: new Text("Okay"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
