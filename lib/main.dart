import 'package:flutter/cupertino.dart';
import 'package:kaushik_app/child_screens/daily_router.dart';
import 'package:kaushik_app/locator.dart';
import 'package:kaushik_app/services/navigation_service.dart';

import 'home_screen.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      theme: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
            navLargeTitleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: CupertinoColors.activeBlue,
            ),
            primaryColor: CupertinoColors.activeBlue),
      ),
      // home: HomeScreen(),
      navigatorObservers: [routeObserver],
      navigatorKey: locator<NavigationService>().navigationKey,
      // initialRoute: homeRoute,
      home: HomeScreen(),
      onGenerateRoute: DailyLogRouteGenerator.generateRoute,
    );
  }
}

class RouteAwareWidget extends StatefulWidget {
  State<RouteAwareWidget> createState() => RouteAwareWidgetState();
}

class RouteAwareWidgetState extends State<RouteAwareWidget> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    // Route was pushed onto navigator and is now topmost route.
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void didPopNext() {
    // Covering route was popped off the navigator.
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  Widget build(BuildContext context) => Container();
}
