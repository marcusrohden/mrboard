// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BoardStore on _BoardStoreBase, Store {
  Computed<ObservableList<MessageModel>>? _$sortedListComputed;

  @override
  ObservableList<MessageModel> get sortedList =>
      (_$sortedListComputed ??= Computed<ObservableList<MessageModel>>(
            () => super.sortedList,
            name: '_BoardStoreBase.sortedList',
          ))
          .value;

  late final _$errorMessageAtom = Atom(
    name: '_BoardStoreBase.errorMessage',
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

  late final _$_messagesAtom = Atom(
    name: '_BoardStoreBase._messages',
    context: context,
  );

  @override
  ObservableMap<String, MessageModel> get _messages {
    _$_messagesAtom.reportRead();
    return super._messages;
  }

  @override
  set _messages(ObservableMap<String, MessageModel> value) {
    _$_messagesAtom.reportWrite(value, super._messages, () {
      super._messages = value;
    });
  }

  late final _$saveMsgAsyncAction = AsyncAction(
    '_BoardStoreBase.saveMsg',
    context: context,
  );

  @override
  Future<void> saveMsg(String txt) {
    return _$saveMsgAsyncAction.run(() => super.saveMsg(txt));
  }

  late final _$_BoardStoreBaseActionController = ActionController(
    name: '_BoardStoreBase',
    context: context,
  );

  @override
  void _setErrorMessage(String? message) {
    final _$actionInfo = _$_BoardStoreBaseActionController.startAction(
      name: '_BoardStoreBase._setErrorMessage',
    );
    try {
      return super._setErrorMessage(message);
    } finally {
      _$_BoardStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _addMessage(MessageModel message) {
    final _$actionInfo = _$_BoardStoreBaseActionController.startAction(
      name: '_BoardStoreBase._addMessage',
    );
    try {
      return super._addMessage(message);
    } finally {
      _$_BoardStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _removeMessage(MessageModel message) {
    final _$actionInfo = _$_BoardStoreBaseActionController.startAction(
      name: '_BoardStoreBase._removeMessage',
    );
    try {
      return super._removeMessage(message);
    } finally {
      _$_BoardStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
sortedList: ${sortedList}
    ''';
  }
}
