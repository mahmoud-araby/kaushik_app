import 'package:flutter/cupertino.dart';
import 'package:kaushik_app/new_code/models/question.dart';

class SliderQuestion extends StatefulWidget implements Question {
  final String question;
  final bool isMultiple = false;
  double value;
  dynamic answer = 0.0;
  final String unit;
  final double min;
  final double max;
  final int divisions;
  @override
  _SliderQuestionState createState() => _SliderQuestionState();

  SliderQuestion(
      {@required this.question,
      this.value,
      @required this.unit,
      @required this.min,
      @required this.max,
      @required this.divisions});
}

class _SliderQuestionState extends State<SliderQuestion> {
  questionHeader() {
    return Text(widget.question);
  }

  questionAnswer() {
    return Column(
      children: <Widget>[
        Text("${widget.value} ${widget.unit}"),
        CupertinoSlider(
          min: widget.min,
          max: widget.max,
          value: widget.value,
          divisions: widget.divisions,
          onChanged: (val) {
            setState(() {
              widget.value = val;
              widget.answer = val;
            });
          },
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
