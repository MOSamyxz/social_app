import 'package:chatapp/data/model/notifications_model.dart';
import 'package:chatapp/data/model/post_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreNotifications {
  final _firestore = FirebaseFirestore.instance;

  Future<String?> sendReactNotification({
    required Post post,
    required UsersModel user,
    required String likeType,
  }) async {
    final now = DateTime.now();

    NotificationsModel notificationsModel = NotificationsModel(
      posterId: post.posterId,
      posterName: post.posterName,
      posterImageUrl: post.posterProfileUrl,
      postId: post.postId,
      reactName: [user.userName],
      reactImageUrl: [user.imageUrl],
      likeType: likeType,
      createdAt: now,
      isComment: false,
    );
    final documentRef = _firestore
        .collection('users')
        .doc(post.posterId)
        .collection('notifications')
        .doc('${post.postId}r');

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
        .doc('${post.postId}r');

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
        .doc('${post.postId}r');

    documentRef.delete();

    return null;
  }

  Future<String?> sendCommentNotification({
    required Post post,
    required UsersModel user,
    required String likeType,
  }) async {
    final now = DateTime.now();

    NotificationsModel notificationsModel = NotificationsModel(
      posterId: post.posterId,
      posterName: post.posterName,
      posterImageUrl: post.posterProfileUrl,
      postId: post.postId,
      commenterName: [user.userName],
      commenterImageUrl: [user.imageUrl],
      likeType: likeType,
      createdAt: now,
      isComment: true,
    );
    final documentRef = _firestore
        .collection('users')
        .doc(post.posterId)
        .collection('notifications')
        .doc('${post.postId}c');

    documentRef.get().then((docSnapshot) {
      if (docSnapshot.exists) {
        // Document exists, update it
        documentRef.update({
          'createdAt': now.millisecondsSinceEpoch,
          'commenterName': FieldValue.arrayUnion([user.userName]),
          'commenterImageUrl': FieldValue.arrayUnion([user.imageUrl]),
        });
      } else {
        // Document doesn't exist, set it
        documentRef.set(notificationsModel.toMap());
      }
    });
    return null;
  }

  Future<String?> sendRemoveCommentNotification({
    required Post post,
    required UsersModel user,
    required String likeType,
  }) async {
    final documentRef = _firestore
        .collection('users')
        .doc(post.posterId)
        .collection('notifications')
        .doc('${post.postId}c');

    documentRef.update({
      'commenterName': FieldValue.arrayRemove([user.userName]),
      'commenterImageUrl': FieldValue.arrayRemove([user.imageUrl]),
    });

    return null;
  }

  Future<String?> removeCommentNotification({
    required Post post,
  }) async {
    final documentRef = _firestore
        .collection('users')
        .doc(post.posterId)
        .collection('notifications')
        .doc('${post.postId}c');

    documentRef.delete();

    return null;
  }
}
