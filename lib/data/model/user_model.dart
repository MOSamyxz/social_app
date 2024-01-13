import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String uId;
  final String userName;
  final String email;
  final String imageUrl;
  final String bio;
  final String birthDay;
  final String gender;
  final List followers;
  final List following;
  const Users(
      {required this.uId,
      required this.userName,
      required this.email,
      required this.imageUrl,
      required this.bio,
      required this.birthDay,
      required this.gender,
      required this.followers,
      required this.following});

  static Users fromFirestore(DocumentSnapshot doc) {
    return Users(
      uId: doc['uid'],
      userName: doc['userName'],
      email: doc['email'],
      imageUrl: doc['imageUrl'],
      bio: doc['bio'],
      birthDay: doc['birthDay'],
      gender: doc['gender'],
      followers: doc['followers'],
      following: doc['following'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uId,
      'userName': userName,
      'email': email,
      'imageUrl': imageUrl,
      'bio': bio,
      'birthDay': birthDay,
      'gender': gender,
      'followers': followers,
      'following': following,
    };
  }
}
