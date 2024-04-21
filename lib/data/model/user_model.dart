import 'package:cloud_firestore/cloud_firestore.dart';

class UsersModel {
  final String uId;
  final String userName;
  final String email;
  final String imageUrl;
  final String? coverUrl;
  final String bio;
  final String birthDay;
  final String gender;
  final String token;
  final List followers;
  final List following;
  final List<String> receivedRequest;
  final List<String> sentRequest;
  final bool isVerified;
  final Timestamp? lastPublishedStory;

  const UsersModel({
    required this.uId,
    required this.userName,
    required this.email,
    required this.imageUrl,
    required this.coverUrl,
    required this.bio,
    required this.birthDay,
    required this.gender,
    required this.token,
    required this.followers,
    required this.following,
    required this.receivedRequest,
    required this.sentRequest,
    this.isVerified = false,
    this.lastPublishedStory,
  });

  static UsersModel fromMap(Map<String, dynamic> map) {
    return UsersModel(
      uId: map['uid'],
      userName: map['userName'],
      email: map['email'],
      imageUrl: map['imageUrl'],
      coverUrl: map['coverUrl'],
      bio: map['bio'],
      birthDay: map['birthDay'],
      gender: map['gender'],
      token: map['token'],
      followers: map['followers'],
      following: map['following'],
      lastPublishedStory: (map['lastPublishedStory'] as Timestamp),
      receivedRequest: List<String>.from((map['receivedRequest'] ?? [])),
      sentRequest: List<String>.from((map['sentRequest'] ?? [])),
      isVerified: map['isVerified'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uId,
      'userName': userName,
      'email': email,
      'imageUrl': imageUrl,
      'coverUrl': coverUrl,
      'bio': bio,
      'birthDay': birthDay,
      'gender': gender,
      'token': token,
      'followers': followers,
      'following': following,
      'lastPublishedStory': lastPublishedStory,
      'receivedRequest': receivedRequest,
      'sentRequest': sentRequest,
      'isVerified': isVerified,
    };
  }
}
