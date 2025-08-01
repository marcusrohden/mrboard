import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mrpostsboard/features/board/repository/board_interface.dart';
import 'package:mrpostsboard/features/board/message_model.dart';
import 'package:mrpostsboard/utils/api_handler.dart';

class BoardFirebaseRepository implements BoardInterface {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String _msgsCollection = 'messages';

  @override
  StreamSubscription getMsgs(
    int daysAgo,
    int limit,

    Function(List<MessageModel> messages) newMessages,
  ) {
    final fiveDaysAgo = DateTime.now().subtract(Duration(days: daysAgo));
    final fiveDaysAgoTimestamp = Timestamp.fromDate(fiveDaysAgo);

    final Stream<QuerySnapshot<Map<String, dynamic>>> stream =
        _firestore
            .collection(_msgsCollection)
            .where('createdAt', isGreaterThanOrEqualTo: fiveDaysAgoTimestamp)
            .orderBy('createdAt', descending: true)
            .limitToLast(limit)
            .snapshots();

    return stream.listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      final List<MessageModel> messages =
          snapshot.docs.map((doc) {
            return MessageModel.fromSnapshot(doc);
          }).toList();

      newMessages(messages);
    });
  }

  @override
  Future<MessageModel> postMsg(MessageModel message) async {
    final f = _firestore
        .collection(_msgsCollection)
        .add(message.toFirebaseJson());

    final DocumentReference doc = await ApiHandler.call(() => f);
    final id = doc.id;

    return message.copyWith(id: id);
  }
}
