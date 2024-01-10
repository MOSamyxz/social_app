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

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      uId: json['uid'],
      userName: json['userName'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      bio: json['bio'],
      birthDay: json['birthDay'],
      gender: json['gender'],
      followers: json['followers'],
      following: json['following'],
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
