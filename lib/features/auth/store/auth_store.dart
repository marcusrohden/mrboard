import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:mrpostsboard/features/auth/repository/auth_interface.dart';
import 'package:mrpostsboard/features/auth/user_model.dart';
import 'package:mrpostsboard/utils/mr_exception.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  final AuthInterface _auth;

  late final StreamSubscription _streamSubscription;

  _AuthStoreBase(this._auth) {
    _init();
  }

  @observable
  UserModel? user;

  @observable
  String? errorMessage;

  @action
  void _setUser(UserModel? user) {
    this.user = user;
  }

  @action
  void _setErrorMessage(String? message) {
    errorMessage = message;
  }

  void dispose() {
    _streamSubscription.cancel();
  }

  void _init() {
    _streamSubscription = _auth.startAuthChanges((user) {
      try {
        _setUser(user);
        _setErrorMessage(null);
      } on MrException catch (e) {
        _setErrorMessage(e.message);
      } catch (e) {
        _setErrorMessage(e.toString());
      }
    });
  }

  Future<void> loginAnonymously() async {
    try {
      await _auth.signInAnonymous();
      _setErrorMessage(null);
    } on MrException catch (e) {
      _setErrorMessage(e.message);
    } catch (e) {
      _setErrorMessage(e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      _setUser(null);
      _setErrorMessage(null);
    } on MrException catch (e) {
      _setErrorMessage(e.message);
    } catch (e) {
      _setErrorMessage(e.toString());
    }
  }
}
