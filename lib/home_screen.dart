import 'package:flutter/cupertino.dart';
import './child_screens/a_tab.dart';
import './child_screens/b_tab.dart';
import './main.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBuilder: (context, index) => buildWidget(context, index),
      tabBar: CupertinoTabBar(
        currentIndex: currentPageIndex,
        onTap: (val) => _onTabChangePage(val, context),
        items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.book), title: Text("A")),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.book), title: Text("B")),
        ],
      ),
    );
  }

  buildWidget(BuildContext context, int index) {
    return CupertinoTabView(
      builder: (context) {
        return CupertinoPageScaffold(
          child: currentPageIndex == 0 ? ATab() : BTab(),
        );
      },
    );
  }

  _onTabChangePage(int val, BuildContext context) {
    print("Page changed");
    setState(() {
      currentPageIndex = val;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
    print("didChangeDependencies");
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
    print("dispose");
  }

  @override
  void didPush() {
    // Route was pushed onto navigator and is now topmost route.
    routeObserver.subscribe(this, ModalRoute.of(context));
    print("didPush");
  }

  @override
  void didPopNext() {
    // Covering route was popped off the navigator.
    routeObserver.subscribe(this, ModalRoute.of(context));
    print("didPopNext");
  }
}