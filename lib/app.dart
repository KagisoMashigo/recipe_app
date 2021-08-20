// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:recipe_app/pages/Home/Home.dart';

// 🌎 Project imports:
import 'package:recipe_app/router.dart';
import 'package:recipe_app/singletons/app.dart';
import 'package:recipe_app/singletons/env.dart';

class RecipeApp extends StatefulWidget {
  RecipeApp({
    this.navKey,
    Key key,
    App appSingleton,
    // Auth authSingleton,
    Env envSingleton,
  })  : appSingleton = appSingleton ?? App(),
        // authSingleton = authSingleton ?? Auth(),
        envSingleton = envSingleton ?? Env(),
        super(key: key);

  /// The navigator state key. if none is given, it will use a default on state
  final GlobalKey<NavigatorState> navKey;
  final App appSingleton;
  // final Auth authSingleton;
  final Env envSingleton;

  @override
  _RecipeAppState createState() => _RecipeAppState();
}

class _RecipeAppState extends State<RecipeApp> with WidgetsBindingObserver {
  GlobalKey<NavigatorState> _navKey;

  @override
  void initState() {
    super.initState();
    _navKey = widget.navKey ?? GlobalKey<NavigatorState>();
    widget.appSingleton.navKey = _navKey;
  }

  @override
  didChangeDependencies() async {
    super.didChangeDependencies();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navKey,
      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: false,
      // Here will be the primary theme
      theme: ThemeData(
          // primarySwatch: Colors.blue,
          ),
      // Dark theme tb added
      darkTheme: null,
      home: HomePage(
        title: 'Super cool app!',
      ),
      routes: routes,
      locale: Locale('en', 'US'),
      navigatorObservers: [routeObserver],
    );
  }
}
