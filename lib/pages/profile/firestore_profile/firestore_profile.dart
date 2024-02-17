import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestorProfile {
  final _firestore = FirebaseFirestore.instance;
  final myUid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> updateCover(String newCover) async {
    try {
      _firestore.collection('users').doc(myUid).update({'coverUrl': newCover});
    } on Exception catch (e) {
      e.toString();
    }
  }

  Future<void> updateProfile(String newProfile) async {
    try {
      _firestore
          .collection('users')
          .doc(myUid)
          .update({'imageUrl': newProfile});
    } on Exception catch (e) {
      e.toString();
    }
  }

  Future<void> updateData({
    required String userName,
    required String bio,
    required String birthDay,
    required String gender,
  }) async {
    try {
      _firestore.collection('users').doc(myUid).update({
        'userName': userName,
        'bio': bio,
        'birthDay': birthDay,
        'gender': gender
      });
    } on Exception catch (e) {
      e.toString();
    }
  }
}
