import 'dart:async';

import 'package:mrpostsboard/features/auth/repository/auth_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mrpostsboard/features/auth/user_model.dart';
import 'package:mrpostsboard/utils/api_handler.dart';

class AuthFirebaseRepository implements AuthInterface {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  StreamSubscription startAuthChanges(Function(UserModel? user) onAuthChanged) {
    return _auth.authStateChanges().listen((User? user) {
      onAuthChanged(user != null ? UserModel.fromFirebaseUser(user) : null);
    });
  }

  @override
  Future<void> signOut() async {
    return await ApiHandler.call(() => _auth.signOut());
  }

  @override
  Future<void> signInAnonymous() async {
    await ApiHandler.call(() => _auth.signInAnonymously());
  }
}
