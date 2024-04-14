import 'dart:io';

import 'package:chatapp/data/model/story_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class FireStoreStories {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  final myUid = FirebaseAuth.instance.currentUser!.uid;

  Future<String?> makeStory({
    required String storyAuther,
    required String storyAutherProfileUrl,
    String? content,
    File? file,
    required String storyType,
  }) async {
    try {
      final storyId = const Uuid().v1();
      final storyAutherId = _auth.currentUser!.uid;
      final nowTimestamp = Timestamp.now();
      final now = nowTimestamp.toDate();

      final expiryTime = now.add(const Duration(hours: 24));
      final expiryTimestamp = Timestamp.fromDate(expiryTime);

      String? downloadUrl;

      if (file != null) {
        // Post file to storage
        final fileUid = const Uuid().v1();
        final path = _storage.ref(storyType).child(fileUid);
        final taskSnapshot = await path.putFile(file);
        final fileUrl = await taskSnapshot.ref.getDownloadURL();
        downloadUrl = fileUrl;
      }

      // Create our post
      StoryModel story = StoryModel(
          storyId: storyId,
          storyAutherId: storyAutherId,
          storyAutherName: storyAuther,
          storyAutherProfileUrl: storyAutherProfileUrl,
          content: content,
          fileUrl: downloadUrl,
          storyType: storyType,
          createdAt: now,
          views: [],
          likes: [],
          expiryTime: expiryTimestamp);

      // Post to firestore
      _firestore
          .collection('users')
          .doc(storyAutherId)
          .collection('stories')
          .doc(storyId)
          .set(story.toMap());
      _firestore
          .collection('users')
          .doc(storyAutherId)
          .update({'lastPublishedStory': expiryTimestamp});
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> deleteStory() async {
    try {
      final myId = _auth.currentUser!.uid;

      final CollectionReference storiesCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(myId)
          .collection('stories');

      storiesCollection
          .where('expiryTime', isLessThan: Timestamp.now())
          .get()
          .then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          doc.reference.delete();
        }
      });
      _firestore.collection('users').doc(myUid).update({
        'lastStory': Timestamp.fromDate(
            DateTime.now().subtract(const Duration(hours: 1)))
      });
    } catch (err) {
      return err.toString();
    }
    return null;
  }

  Future<String?> viewStory(
      {required String userId, required String storyId}) async {
    try {
      final myId = _auth.currentUser!.uid;
      _firestore
          .collection('users')
          .doc(userId)
          .collection('stories')
          .doc(storyId)
          .update({
        'views': FieldValue.arrayUnion([myId])
      });

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> likeDislikeStory({
    required String storyId,
    required String storyAutherId,
    required List<String> likes,
  }) async {
    try {
      final myId = _auth.currentUser!.uid;

      if (!likes.contains(myId)) {
        // we didn't like the story

        _firestore
            .collection('users')
            .doc(storyAutherId)
            .collection('stories')
            .doc(storyId)
            .update({
          'likes': FieldValue.arrayUnion([myId])
        });
      } else {
        // we need to like the post

        _firestore
            .collection('users')
            .doc(storyAutherId)
            .collection('stories')
            .doc(storyId)
            .update({
          'likes': FieldValue.arrayRemove([myId])
        });
      }

      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
