import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String id;

  String get displayName => 'User: ${id.substring(0, 2)}';

  UserModel({required this.id});

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(id: user.uid);
  }
}
