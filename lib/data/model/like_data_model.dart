import 'package:cloud_firestore/cloud_firestore.dart';

class LikesDataModel {
  final String userId;
  final String userName;
  final String imageUrl;
  final String likeType;
  final String postId;

  LikesDataModel({
    required this.userId,
    required this.userName,
    required this.imageUrl,
    required this.likeType,
    required this.postId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'userName': userName,
      'imageUrl': imageUrl,
      'likeType': likeType,
      'postId': postId,
    };
  }

  factory LikesDataModel.fromMap(Map<String, dynamic> map) {
    return LikesDataModel(
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      likeType: map['likeType'] ?? '',
      postId: map['postId'] ?? '',
    );
  }

  factory LikesDataModel.fromSnapshot(DocumentSnapshot<Object?> map) {
    return LikesDataModel(
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      likeType: map['likeType'] ?? '',
      postId: map['postId'] ?? '',
    );
  }
}
