import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreFollow {
  final _firestore = FirebaseFirestore.instance;
  final myUid = FirebaseAuth.instance.currentUser!.uid;

  Future<String?> sendFollowRequest({required String userId}) async {
    try {
      _firestore.collection('users').doc(userId).update({
        'receivedRequest': FieldValue.arrayUnion([myUid])
      });

      _firestore.collection('users').doc(myUid).update({
        'sentRequest': FieldValue.arrayUnion([userId])
      });
      return null;
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future<String?> acceptFollowRequest({required String userId}) async {
    try {
      _firestore.collection('users').doc(userId).update({
        'following': FieldValue.arrayUnion([myUid]),
        'sentRequest': FieldValue.arrayRemove([myUid]),
      });

      _firestore.collection('users').doc(myUid).update({
        'followers': FieldValue.arrayUnion([userId]),
        'receivedRequest': FieldValue.arrayRemove([userId]),
      });
      return null;
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future<String?> removeFollowRequest({required String userId}) async {
    try {
      _firestore.collection('users').doc(myUid).update({
        'sentRequest': FieldValue.arrayRemove([userId]),
      });

      _firestore.collection('users').doc(userId).update({
        'receivedRequest': FieldValue.arrayRemove([myUid]),
      });
      return null;
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future<String?> removeFollower({required String userId}) async {
    try {
      _firestore.collection('users').doc(myUid).update({
        'following': FieldValue.arrayRemove([userId])
      });
      _firestore.collection('users').doc(userId).update({
        'followers': FieldValue.arrayRemove([myUid])
      });
      return null;
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future<String?> unFollow({required String userId}) async {
    try {
      _firestore.collection('users').doc(myUid).update({
        'following': FieldValue.arrayRemove([userId])
      });

      _firestore.collection('users').doc(userId).update({
        'followers': FieldValue.arrayRemove([myUid])
      });
      return null;
    } on Exception catch (e) {
      return e.toString();
    }
  }
}
