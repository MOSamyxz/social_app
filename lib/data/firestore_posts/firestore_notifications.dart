import 'package:chatapp/data/model/notifications_model.dart';
import 'package:chatapp/data/model/post_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreNotifications {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<String?> sendReactNotification({
    required Post post,
    required UsersModel user,
    required String likeType,
  }) async {
    final userId = _auth.currentUser!.uid;
    final now = DateTime.now();

    NotificationsModel notificationsModel = NotificationsModel(
      posterId: post.posterId,
      posterName: post.posterName,
      posterImageUrl: post.posterProfileUrl,
      postId: post.postId,
      reactID: userId,
      reactName: [user.userName],
      reactImageUrl: [user.imageUrl],
      likeType: likeType,
      createdAt: now,
    );
    final documentRef = _firestore
        .collection('users')
        .doc(post.posterId)
        .collection('notifications')
        .doc(post.postId);

    documentRef.get().then((docSnapshot) {
      if (docSnapshot.exists) {
        // Document exists, update it
        documentRef.update({
          'createdAt': now.millisecondsSinceEpoch,
          'reactName': FieldValue.arrayUnion([user.userName]),
          'reactImageUrl': FieldValue.arrayUnion([user.imageUrl]),
        });
      } else {
        // Document doesn't exist, set it
        documentRef.set(notificationsModel.toMap());
      }
    });
    return null;
  }

  Future<String?> sendRemoveReactNotification({
    required Post post,
    required UsersModel user,
    required String likeType,
  }) async {
    final documentRef = _firestore
        .collection('users')
        .doc(post.posterId)
        .collection('notifications')
        .doc(post.postId);

    documentRef.update({
      'reactName': FieldValue.arrayRemove([user.userName]),
      'reactImageUrl': FieldValue.arrayRemove([user.imageUrl]),
    });

    return null;
  }

  Future<String?> removeNotification({
    required Post post,
  }) async {
    final documentRef = _firestore
        .collection('users')
        .doc(post.posterId)
        .collection('notifications')
        .doc(post.postId);

    documentRef.delete();

    return null;
  }
}
