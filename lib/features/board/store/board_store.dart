import 'dart:async';
import 'dart:math';

import 'package:mobx/mobx.dart';
import 'package:mrpostsboard/constants.dart';
import 'package:mrpostsboard/features/auth/store/auth_store.dart';
import 'package:mrpostsboard/features/board/repository/board_interface.dart';
import 'package:mrpostsboard/features/board/message_model.dart';
import 'package:mrpostsboard/utils/mr_exception.dart';

part 'board_store.g.dart';

class BoardStore = _BoardStoreBase with _$BoardStore;

abstract class _BoardStoreBase with Store {
  final BoardInterface _board;
  final AuthStore _auth;

  late final StreamSubscription _streamSubscription;
  late final ReactionDisposer _reactionDisposer;

  _BoardStoreBase(this._board, this._auth) {
    // Add reaction to monitor auth user changes. it will only start the stream subscription
    // when the user is not null, which means the user is authenticated.
    _reactionDisposer = when((_) => _auth.user != null, () {
      _init();
    });
  }

  @observable
  String? errorMessage;

  @observable
  ObservableMap<String, MessageModel> _messages =
      ObservableMap<String, MessageModel>();

  @computed
  ObservableList<MessageModel> get sortedList {
    final sorted =
        _messages.values.toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return ObservableList.of(sorted);
  }

  @action
  void _setErrorMessage(String? message) {
    errorMessage = message;
  }

  @action
  void _addMessage(MessageModel message) {
    _messages[message.id] = message;
  }

  void dispose() {
    _streamSubscription.cancel();
    _reactionDisposer();
  }

  void _init() {
    try {
      _streamSubscription = _board.getMsgs(daysAgo, limitPagination, (
        messages,
      ) {
        for (var message in messages) {
          _addMessage(message);
        }
      });
    } on MrException catch (e) {
      _setErrorMessage(e.message);
    } catch (e) {
      _setErrorMessage(e.toString());
    }
  }

  @action
  void _removeMessage(MessageModel message) {
    _messages.remove(message.id);
  }

  @action
  Future<void> saveMsg(String txt) async {
    final String? userId = _auth.user?.id;

    if (userId == null) {
      _setErrorMessage('You must be signed in to post messages.');
      return;
    }

    final random = Random();
    // randomize number to be used as placeholder while waiting for firebase to assign ID
    final int number = random.nextInt(99999999);

    final MessageModel messagePlaceholder = MessageModel(
      id: '$number', // Will be set by the repository
      authorId: userId,
      content: txt,
      createdAt: DateTime.now(),
      authorName: _auth.user?.displayName ?? 'anonymous',
    );

    // Add the placeholder message to the list immediately
    // This allows the UI to update immediately while waiting for the firebase response
    _addMessage(messagePlaceholder);

    try {
      final result = await _board.postMsg(messagePlaceholder);
      _removeMessage(messagePlaceholder);
      _addMessage(result);
    } catch (e) {
      // Remove the placeholder message in case of error
      _removeMessage(messagePlaceholder);
      _setErrorMessage(e.toString());
    }
  }

  Future<void> logout() {
    return _auth.logout();
  }
}
