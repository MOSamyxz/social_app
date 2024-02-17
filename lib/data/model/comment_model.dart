import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String commentId;
  final String authorId;
  final String authorName;
  final String authorProfileUrl;
  final String postId;
  final String text;
  final DateTime? createdAt;
  final List<String>? likes;

  const CommentModel({
    required this.commentId,
    required this.authorId,
    required this.authorName,
    required this.authorProfileUrl,
    required this.postId,
    required this.text,
    required this.createdAt,
    required this.likes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'commentId': commentId,
      'authorId': authorId,
      'authorName': authorName,
      'authorProfileUrl': authorProfileUrl,
      'postId': postId,
      'text': text,
      'createdAt': createdAt!.millisecondsSinceEpoch,
      'likes': likes,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      commentId: map['commentId'] ?? '',
      authorId: map['authorId'] ?? '',
      authorName: map['authorName'] ?? '',
      authorProfileUrl: map['authorProfileUrl'] ?? '',
      postId: map['postId'] ?? '',
      text: map['text'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        map['createdAt'] ?? 0,
      ),
      likes: List<String>.from(
        (map['likes'] ?? []),
      ),
    );
  }
  factory CommentModel.fromSnap(DocumentSnapshot<Object?> map) {
    return CommentModel(
      commentId: map['commentId'] ?? '',
      authorId: map['authorId'] ?? '',
      authorName: map['authorName'] ?? '',
      authorProfileUrl: map['authorProfileUrl'] ?? '',
      postId: map['postId'] ?? '',
      text: map['text'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        map['createdAt'] ?? 0,
      ),
      likes: List<String>.from(
        (map['likes'] ?? []),
      ),
    );
  }
}
