/* List with initialization of all providers */

// 📦 Package imports:
import 'package:provider/single_child_widget.dart';

// 🌎 Project imports:

/// all providers being used in the application
final providers = <SingleChildWidget>[
  ..._authProviders,
  ..._functionalityProviders,
];

/// All providers being used through user management, sign in and sign out
final _authProviders = <SingleChildWidget>[
  // ChangeNotifierProvider<SignInProvider>(
  //   create: (_) => SignInProvider(),
  // ),
  // ChangeNotifierProvider<ResetPasswordProvider>(
  //   create: (_) => ResetPasswordProvider(),
  // ),
  // ChangeNotifierProvider<AuthProvider>(
  //   create: (_) => AuthProvider(),
  // ),
  // ChangeNotifierProvider<ChangePasswordProvider>(
  //   create: (_) => ChangePasswordProvider(),
  // )
];

/// Providers that may or may not require an token, but provides functionality on the scope
/// of the app domains
final _functionalityProviders = <SingleChildWidget>[
  // ChangeNotifierProvider<PushNotificationProvider>(
  //   create: (_) => PushNotificationProvider(),
  // ),
  // ChangeNotifierProvider<HomeEventProvider>(
  //   create: (_) => HomeEventProvider(),
  // ),
];
