import 'package:cloud_firestore/cloud_firestore.dart';

class StoryModel {
  final String storyId;
  final String storyAutherId;
  final String storyAutherName;
  final String storyAutherProfileUrl;
  String? content;
  final String storyType;
  String? fileUrl;
  final DateTime createdAt;
  final Timestamp expiryTime;
  final List<String> views;
  final List<String> likes;

  StoryModel({
    required this.storyId,
    required this.storyAutherId,
    required this.storyAutherName,
    required this.storyAutherProfileUrl,
    this.content,
    required this.storyType,
    this.fileUrl,
    required this.createdAt,
    required this.expiryTime,
    required this.views,
    required this.likes,
  });

  Map<String, dynamic> toMap() {
    return {
      'storyId': storyId,
      'storyAutherId': storyAutherId,
      'storyAutherName': storyAutherName,
      'storyAutherProfileUrl': storyAutherProfileUrl,
      'content': content,
      'storyType': storyType,
      'fileUrl': fileUrl,
      'createdAt': createdAt,
      'expiryTime': expiryTime,
      'views': views,
      'likes': likes,
    };
  }

  factory StoryModel.fromMap(Map<String, dynamic> map) {
    return StoryModel(
      storyId: map['storyId'] ?? '',
      storyAutherId: map['storyAutherId'] ?? '',
      storyAutherName: map['storyAutherName'] ?? '',
      storyAutherProfileUrl: map['storyAutherProfileUrl'] ?? '',
      content: map['content'],
      storyType: map['storyType'] ?? '',
      fileUrl: map['fileUrl'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      expiryTime: (map['expiryTime'] as Timestamp),
      views: List<String>.from(map['views'] ?? []),
      likes: List<String>.from(map['likes'] ?? []),
    );
  }

  factory StoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return StoryModel(
      storyId: snapshot.id,
      storyAutherId: data['storyAutherId'] ?? '',
      storyAutherName: data['storyAutherName'] ?? '',
      storyAutherProfileUrl: data['storyAutherProfileUrl'] ?? '',
      content: data['content'],
      storyType: data['storyType'] ?? '',
      fileUrl: data['fileUrl'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      expiryTime: (data['expiryTime'] as Timestamp),
      views: List<String>.from(data['views'] ?? []),
      likes: List<String>.from(data['likes'] ?? []),
    );
  }
}
