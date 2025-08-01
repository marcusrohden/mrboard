import 'dart:async';

import 'package:mrpostsboard/features/board/message_model.dart';

abstract class BoardInterface {
  StreamSubscription getMsgs(
    int daysAgo,
    int limit,

    Function(List<MessageModel> messages) newMessages,
  );
  Future<MessageModel> postMsg(MessageModel message);
}
