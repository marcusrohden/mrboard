import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessageModel extends Equatable {
  final String id;
  final String content;
  final String authorId;
  final String authorName;
  final DateTime createdAt;

  const MessageModel({
    required this.id,
    required this.content,
    required this.authorId,
    required this.authorName,
    required this.createdAt,
  });

  @override
  List<Object> get props => [id, content, authorId, authorName, createdAt];

  factory MessageModel.fromSnapshot(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final json = doc.data();
    final createdAt = json['createdAt'] as Timestamp;
    final utcDateTime = createdAt.toDate();

    return MessageModel(
      id: doc.id,
      content: json['content'] as String,
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String,
      createdAt: utcDateTime.toLocal(),
    );
  }

  Map<String, dynamic> toFirebaseJson() {
    return {
      'content': content,
      'authorId': authorId,
      'authorName': authorName,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  MessageModel copyWith({
    String? id,
    String? content,
    String? authorId,
    String? authorName,
    DateTime? createdAt,
  }) {
    return MessageModel(
      id: id ?? this.id,
      content: content ?? this.content,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
