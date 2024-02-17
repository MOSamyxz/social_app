import 'dart:io';

import 'package:chatapp/data/model/comment_model.dart';
import 'package:chatapp/data/model/like_data_model.dart';
import 'package:chatapp/data/model/post_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class FireStorePosts {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  Future<String?> makePost({
    required String posterName,
    required String posterProfileUrl,
    required String content,
    File? file,
    required String postType,
  }) async {
    try {
      final postId = const Uuid().v1();
      final posterId = _auth.currentUser!.uid;
      final now = DateTime.now();
      String? downloadUrl;

      if (file != null) {
        // Post file to storage
        final fileUid = const Uuid().v1();
        final path = _storage.ref(postType).child(fileUid);
        final taskSnapshot = await path.putFile(file);
        final imageUrl = await taskSnapshot.ref.getDownloadURL();
        downloadUrl = imageUrl;
      }

      // Create our post
      Post post = Post(
        postId: postId,
        posterId: posterId,
        content: content,
        postType: postType,
        fileUrl: downloadUrl,
        createdAt: now,
        likes: const [],
        posterName: posterName,
        posterProfileUrl: posterProfileUrl,
        likesData: [],
      );

      // Post to firestore
      _firestore.collection('posts').doc(postId).set(post.toMap());

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // Update Post

  Future<String?> updatePost({
    required String postId,
    required String postContent,
  }) async {
    try {
      _firestore
          .collection('posts')
          .doc(postId)
          .update({'content': postContent});

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // Delete Post
  Future<String?> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (err) {
      return err.toString();
    }
    return null;
  }

  Future<String?> likeDislikePost(
      {required String postId,
      required String likeType,
      required List<String> likesData,
      required List<String> likes,
      required UsersModel user}) async {
    try {
      final userId = _auth.currentUser!.uid;

      if (!likes.contains(userId)) {
        // we already liked the post
        LikesDataModel likesDataModel = LikesDataModel(
            userId: userId,
            userName: user.userName,
            imageUrl: user.imageUrl,
            likeType: likeType,
            postId: postId);

        _firestore
            .collection('posts')
            .doc(postId)
            .collection('likesData')
            .doc(userId)
            .set(likesDataModel.toMap());

        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([userId])
        });
      } else {
        // we need to like the post
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('likesData')
            .doc(userId)
            .delete();
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([userId])
        });
      }

      return null;
    } catch (e) {
      return e.toString();
    }
  }

//update like

  Future<String?> updateLike(
      {required String postId,
      required String likeType,
      required List<String> likes,
      required UsersModel user}) async {
    try {
      final userId = _auth.currentUser!.uid;

      if (likes.contains(userId)) {
        // we already liked the post
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('likesData')
            .doc(userId)
            .update({'likeType': likeType});

        /*   _firestore.collection('posts').doc(postId).update({
          'likesData': FieldValue.arrayRemove(['$userId $likeType']),
        });*/
        /*     _firestore.collection('posts').doc(postId).update({
          'likesData': FieldValue.arrayUnion(['$userId $likeType']),
        });*/
        /* _firestore.collection('posts').doc(postId).update({
          'likesData.$userId': likeType,
        });*/
      }

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // Post comment
  Future<String?> postComment(
      {required String postId,
      required String text,
      required UsersModel user}) async {
    try {
      final userId = _auth.currentUser!.uid;
      final String commentId = const Uuid().v1();
      final now = DateTime.now();

      if (text.isNotEmpty) {
        CommentModel comment = CommentModel(
          commentId: commentId,
          authorId: userId,
          authorName: user.userName,
          authorProfileUrl: user.imageUrl,
          postId: postId,
          text: text,
          createdAt: now,
          likes: [],
        );

        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set(comment.toMap());
        return null;
      }
    } catch (e) {
      return e.toString();
    }
    return null;
  }

  //like comment

  Future<String?> likeDislikeComment(
      {required String postId,
      required String commentId,
      required List<String> likes,
      required UsersModel user}) async {
    try {
      final userId = _auth.currentUser!.uid;

      if (!likes.contains(userId)) {
        // we already liked the post

        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .update({
          'likes': FieldValue.arrayUnion([userId])
        });
      } else {
        // we need to like the post
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('likesData')
            .doc(userId)
            .delete();
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .update({
          'likes': FieldValue.arrayRemove([userId])
        });
      }

      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
