import 'package:flutter/cupertino.dart';

class ATab extends StatefulWidget {
  @override
  _ATabState createState() => _ATabState();
}

class _ATabState extends State<ATab> {
  
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      itemExtent: 30,
      children: <Widget>[
        buildContainer(context, "A1"),
        buildContainer(context, "A2"),
      ],
    );
  }

  Container buildContainer(BuildContext context, String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: CupertinoTheme.of(context)
                .textTheme
                .actionTextStyle
                .copyWith(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          CupertinoButton(
            child: Icon(CupertinoIcons.info),
            onPressed: () {
              showGeneralDialog(
                barrierDismissible: true,
                barrierLabel: 'Settings',
                barrierColor: CupertinoColors.black,
                context: context,
                transitionDuration: const Duration(seconds: 1),
                pageBuilder: (context, animation, secondaryAnimation) {
                  return CupertinoFullscreenDialogTransition(
                    primaryRouteAnimation: animation,
                    secondaryRouteAnimation: secondaryAnimation,
                    child: Center(
                      child: Text(
                        "Info for $title",
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    ),
                    linearTransition: true,
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
