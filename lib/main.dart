// 🎯 Dart imports:
import 'dart:async';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:flutter_config/flutter_config.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/app.dart';

// 🌎 Project imports:
import 'package:recipe_app/plugins/responsive.dart';
import 'package:recipe_app/plugins/sentry.dart';
import 'package:recipe_app/providers/providers.dart';
// import 'package:recipe_app/plugins/sentry.dart';

void main() async {
  // Allow device information capturing
  WidgetsFlutterBinding.ensureInitialized();

  // Still need to read into this more
  FlutterError.onError = (FlutterErrorDetails details) async {
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };

  // Device orientations list is limited to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runZonedGuarded(
    () async {
      runApp(
        MultiProvider(
          providers: providers,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return OrientationBuilder(
                builder: (context, orientation) {
                  Responsive().init(constraints, orientation);
                  return RecipeApp();
                },
              );
            },
          ),
        ),
      );
    },
    reportAppError,
  );
}
