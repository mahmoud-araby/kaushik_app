import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Info_for_B2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 20),
          alignment: Alignment.bottomRight,
          child: CupertinoButton(
            child: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Expanded(
          child: Center(
            child: Text('This class shows info for B2.'),
          ),
        ),
      ],
    );
  }
}
