// 🎯 Dart imports:
import 'dart:async';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:recipe_app/app.dart';

// 🌎 Project imports:
import 'package:recipe_app/plugins/responsive.dart';
import 'package:recipe_app/plugins/sentry.dart';

void main() {
  // runApp(RecipeApp());

  // Allow device information capturing
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(
    () {
      runApp(
        // Wrap this widget with provider when need be
        LayoutBuilder(
          builder: (context, constraints) {
            return OrientationBuilder(
              builder: (context, orientation) {
                Responsive().init(constraints, orientation);
                return RecipeApp();
              },
            );
          },
        ),
      );
    },
    reportAppError,
  );
}
