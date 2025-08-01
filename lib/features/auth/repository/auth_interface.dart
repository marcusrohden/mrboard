import 'dart:async';

import 'package:mrpostsboard/features/auth/user_model.dart';

abstract class AuthInterface {
  Future<void> signInAnonymous();
  Future<void> signOut();
  StreamSubscription startAuthChanges(Function(UserModel? user) onAuthChanged);
}
