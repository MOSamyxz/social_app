import 'dart:io';

import 'package:chatapp/data/model/chat_model.dart';
import 'package:chatapp/data/model/messege_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class FirestoreMesseges {
  final _firestore = FirebaseFirestore.instance;
  final myUid = FirebaseAuth.instance.currentUser!.uid;
  final _storage = FirebaseStorage.instance;

  Future<String?> createCahtRoom({required String userId}) async {
    try {
      final now = DateTime.now();

      ChatModel chatModel = ChatModel(
          senderID: myUid,
          receiverID: userId,
          lastMessage: '',
          lastMessageSenderId: '',
          lastMessageCreatedAt: now,
          lastMessageType: '');

      _firestore
          .collection('users')
          .doc(myUid)
          .collection('chats')
          .doc(userId)
          .set(chatModel.toMap());
      return null;
    } on Exception catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future<String?> sendMessage({
    required String receiverId,
    String? messegeContent,
    required String messegeType,
    File? file,
  }) async {
    try {
      final now = DateTime.now();
      final messegeId = const Uuid().v1();
      String? downloadUrl;
      if (file != null) {
        // Post file to storage
        final fileUid = const Uuid().v1();
        final path = _storage
            .ref('messeges')
            .child(myUid)
            .child(receiverId)
            .child(fileUid);
        final taskSnapshot = await path.putFile(file);
        final imageUrl = await taskSnapshot.ref.getDownloadURL();
        downloadUrl = imageUrl;
      }
      MessegeModel messegeModel = MessegeModel(
          messegeId: messegeId,
          messegeContent: messegeContent,
          messegeCreatedAt: now,
          messegeFileUrl: downloadUrl,
          messegeType: messegeType,
          senderId: myUid,
          receiverId: receiverId);

      ChatModel chatModel = ChatModel(
          senderID: receiverId,
          receiverID: myUid,
          lastMessage: messegeContent!,
          lastMessageSenderId: myUid,
          lastMessageCreatedAt: now,
          lastMessageType: messegeType);

      _firestore
          .collection('users')
          .doc(receiverId)
          .collection('chats')
          .doc(myUid)
          .set(chatModel.toMap());
      _firestore
          .collection('users')
          .doc(myUid)
          .collection('chats')
          .doc(receiverId)
          .collection('messeges')
          .doc(messegeId)
          .set(messegeModel.toMap());
      _firestore
          .collection('users')
          .doc(receiverId)
          .collection('chats')
          .doc(myUid)
          .collection('messeges')
          .doc(messegeId)
          .set(messegeModel.toMap());

      _firestore
          .collection('users')
          .doc(myUid)
          .collection('chats')
          .doc(receiverId)
          .update({
        'lastMessage': messegeContent,
        'lastMessageType': messegeType,
        'lastMessageSenderId': myUid,
        'lastMessageCreatedAt': now
      });
      _firestore
          .collection('users')
          .doc(receiverId)
          .collection('chats')
          .doc(myUid)
          .update({
        'lastMessage': messegeContent,
        'lastMessageType': messegeType,
        'lastMessageSenderId': myUid,
        'lastMessageCreatedAt': now
      });
      return null;
    } on Exception catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
