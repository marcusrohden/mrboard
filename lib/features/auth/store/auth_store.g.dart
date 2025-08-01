// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStoreBase, Store {
  late final _$userAtom = Atom(name: '_AuthStoreBase.user', context: context);

  @override
  UserModel? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_AuthStoreBase.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$_AuthStoreBaseActionController = ActionController(
    name: '_AuthStoreBase',
    context: context,
  );

  @override
  void _setUser(UserModel? user) {
    final _$actionInfo = _$_AuthStoreBaseActionController.startAction(
      name: '_AuthStoreBase._setUser',
    );
    try {
      return super._setUser(user);
    } finally {
      _$_AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setErrorMessage(String? message) {
    final _$actionInfo = _$_AuthStoreBaseActionController.startAction(
      name: '_AuthStoreBase._setErrorMessage',
    );
    try {
      return super._setErrorMessage(message);
    } finally {
      _$_AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
errorMessage: ${errorMessage}
    ''';
  }
}
