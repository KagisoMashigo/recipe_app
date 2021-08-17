// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:package_info/package_info.dart';
import 'package:recipe_app/pages/Landing.dart';

// 🌎 Project imports:
import 'package:recipe_app/router.dart';
import 'package:recipe_app/singletons/app.dart';
import 'package:recipe_app/singletons/env.dart';
import 'package:recipe_app/theme.dart';

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
  Future<void> _initCall;
  Locale _locale;
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

  Future<void> getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final _packageVersion = packageInfo.version;

    /// This represents the unique build number index.
    /// Display to the user to validate the app build number
    /// [FIREBASE] Provided in the CLI for firebase deployment only.
    /// [STORE] Provided in the CLI throw the store app setting
    const _build = String.fromEnvironment('build');
    final _builderNumber = _build.isNotEmpty ? _build : packageInfo.buildNumber;
    String _version = '$_packageVersion-$_builderNumber';
    widget.appSingleton.setVersion(_version);

    /// This represents the cluster the app consume.
    /// Display only for internal usage
    /// [FIREBASE] Provided in the CLI for firebase deployment only.
    /// [STORE] Not provided.
    const _cluster = String.fromEnvironment('cluster');
    if (_cluster.isNotEmpty) {
      widget.appSingleton.setCluster(_cluster);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navKey,
      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingPage(),
      routes: routes,
      locale: Locale('en', 'US'),
      navigatorObservers: [routeObserver],
    );
  }
}
