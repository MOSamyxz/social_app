import 'package:chatapp/data/model/like_data_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<dynamic> getUserDetails({
    required String collection,
    required String doc,
  }) async {
    final userData = await _firestore.collection(collection).doc(doc).get();

    UsersModel user = UsersModel.fromMap(userData.data()!);
    return user;
  }

  Future<List<UsersModel>> getUsersDetailsByIds({
    required String collection,
    required List<String> userIds,
  }) async {
    List<UsersModel> usersList = [];
    for (String userId in userIds) {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection(collection)
              .doc(userId)
              .get();
      if (documentSnapshot.exists) {
        usersList.add(UsersModel.fromMap(documentSnapshot.data()!));
      }
    }
    return usersList;
  }

  Future<dynamic> getPostLikes({
    required String doc,
  }) async {
    final userData = await _firestore
        .collection('posts')
        .doc(doc)
        .collection('likesData')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    LikesDataModel likesData = LikesDataModel.fromMap(userData.data()!);
    return likesData;
  }
}
