// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:

class App {
  static App _instance;

  /// The app cluster target
  String _cluster;

  /// The app version with his build number
  String _version;

  /// Key to access the navigator. Could be null before call on AerialApp
  GlobalKey<NavigatorState> navKey;

  /// Key that is unique across the entire app used to identify elements.
  /// Calls before the the first load may cause this to be null
  GlobalKey<ScaffoldState> globalKey;

  App._internal() {
    _instance = this;
  }

  factory App() => _instance ?? App._internal();

  /// Share global key to elements.
  GlobalKey<ScaffoldState> get key => globalKey;

  /// get app cluster target
  String get cluster => _cluster;

  /// get app version
  String get version => _version;

  /// Handle close action on app navigation menu
  void closeDrawer() => globalKey.currentState.openEndDrawer();

  /// Handle open action on app navigation menu
  void openDrawer() => globalKey.currentState.openDrawer();

  /// set app cluster target
  void setCluster(String cluster) => _cluster = cluster;

  /// set app version
  void setVersion(String version) => _version = version;
}
