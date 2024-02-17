class UsersModel {
  final String uId;
  final String userName;
  final String email;
  final String imageUrl;
  final String? coverUrl;
  final String bio;
  final String birthDay;
  final String gender;
  final List followers;
  final List following;
  final List<String> receivedRequest;
  final List<String> sentRequest;

  const UsersModel({
    required this.uId,
    required this.userName,
    required this.email,
    required this.imageUrl,
    required this.coverUrl,
    required this.bio,
    required this.birthDay,
    required this.gender,
    required this.followers,
    required this.following,
    required this.receivedRequest,
    required this.sentRequest,
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
        followers: map['followers'],
        following: map['following'],
        receivedRequest: List<String>.from((map['receivedRequest'] ?? [])),
        sentRequest: List<String>.from((map['sentRequest'] ?? [])));
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
      'followers': followers,
      'following': following,
      'receivedRequest': receivedRequest,
      'sentRequest': sentRequest,
    };
  }
}
