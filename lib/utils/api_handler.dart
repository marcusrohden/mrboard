import 'package:firebase_auth/firebase_auth.dart';
import 'package:mrpostsboard/utils/mr_exception.dart';

class ApiHandler {
  static Future<T> call<T>(Future<T> Function() api) async {
    try {
      return await api();
    } on FirebaseAuthException catch (e) {
      throw MrException(
        e.message ?? 'An error occurred during authentication, ${e.code}',
      );
    } on FirebaseException catch (e) {
      throw MrException(
        e.message ?? 'An error occurred with Firebase, ${e.code}',
      );
    } catch (e) {
      throw MrException(e.toString());
    }
  }
}
