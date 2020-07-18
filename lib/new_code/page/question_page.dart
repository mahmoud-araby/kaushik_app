import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaushik_app/new_code/models/question.dart';

class QuestionPage extends StatefulWidget {
  final Question question;
  @override
  _QuestionPageState createState() => _QuestionPageState();

  QuestionPage(this.question);
}

class _QuestionPageState extends State<QuestionPage> {
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
//TODO: go to mainpage
              },
            ),
          ),
          retChild()
        ],
      ),
    );
  }

  retChild() {
    return widget.question;
  }
}
