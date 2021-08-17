// 🎯 Dart imports:

// 📦 Package imports:
import 'package:package_info/package_info.dart';
import 'package:sentry/sentry.dart';

// 🌎 Project imports:

final SentryClient _sentry = SentryClient(SentryOptions(
  dsn:
      'https://c917a8d51bec40f4ab538beeed2d46a1@o961240.ingest.sentry.io/5909605',
));

/// Report to sentry crash on the app top level
Future<void> reportAppError(dynamic exception, StackTrace stack) async {
  final release = await PackageInfo.fromPlatform();

  final _event = SentryEvent(
    message: Message('App Exception'),
    culprit: 'App on failed with: $exception',
    release: '${release.version}-${release.buildNumber}',
    level: SentryLevel.error,
  );

  _sentry.captureEvent(_event, stackTrace: stack);
}
