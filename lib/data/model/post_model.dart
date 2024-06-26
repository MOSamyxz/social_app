import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String postId;
  final String posterToken;
  final String posterId;
  final String posterName;
  final String posterProfileUrl;
  final String? saverId;
  final String content;
  final String postType;
  String? fileUrl;
  final DateTime createdAt;
  final DateTime? savedAt;
  late final List<String> likesData;
  final List<String> likes;
  final List<String> saves;

  Post({
    required this.postId,
    required this.posterToken,
    required this.posterId,
    required this.posterName,
    required this.posterProfileUrl,
    required this.content,
    required this.postType,
    this.fileUrl,
    this.saverId,
    this.savedAt,
    required this.createdAt,
    required this.likesData,
    required this.likes,
    required this.saves,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postId': postId,
      'posterToken': posterToken,
      'posterId': posterId,
      'posterName': posterName,
      'saverId': saverId,
      'posterProfileUrl': posterProfileUrl,
      'content': content,
      'fileUrl': fileUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'savedAt': savedAt?.millisecondsSinceEpoch,
      'likesData': likesData,
      'postType': postType,
      'likes': likes,
      'saves': saves,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
        postId: map['postId'] ?? '',
        posterToken: map['posterToken'] ?? '',
        posterId: map['posterId'] ?? '',
        posterName: map['posterName'] ?? '',
        saverId: map['saverId'] ?? '',
        posterProfileUrl: map['posterProfileUrl'] ?? '',
        content: map['content'] ?? '',
        postType: map['postType'] ?? '',
        fileUrl: map['fileUrl'] ?? '',
        createdAt: DateTime.fromMillisecondsSinceEpoch(
          map['createdAt'] ?? 0,
        ),
        savedAt: DateTime.fromMillisecondsSinceEpoch(
          map['savedAt'] ?? 0,
        ),
        likesData: List<String>.from(map['likesData'] ?? []),
        likes: List<String>.from((map['likes'] ?? [])),
        saves: List<String>.from((map['saves'] ?? [])));
  }

  factory Post.fromSnapshot(DocumentSnapshot<Object?> map) {
    return Post(
      postId: map['postId'] ?? '',
      posterToken: map['posterToken'] ?? '',
      posterId: map['posterId'] ?? '',
      posterName: map['posterName'] ?? '',
      posterProfileUrl: map['posterProfileUrl'] ?? '',
      saverId: map['saverId'] ?? '',
      content: map['content'] ?? '',
      postType: map['postType'] ?? '',
      fileUrl: map['fileUrl'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        map['createdAt'] ?? 0,
      ),
      savedAt: DateTime.fromMillisecondsSinceEpoch(
        map['savedAt'] ?? 0,
      ),
      likesData: List<String>.from(map['likesData'] ?? []),
      likes: List<String>.from((map['likes'] ?? [])),
      saves: List<String>.from((map['saves'] ?? [])),
    );
  }
}
