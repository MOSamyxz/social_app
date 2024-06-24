import 'dart:io';

import 'package:chatapp/data/model/chat_model.dart';
import 'package:chatapp/data/model/message_model.dart';
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
    String? messageContent,
    required String messageType,
    File? file,
  }) async {
    try {
      final now = DateTime.now();
      final messageId = const Uuid().v1();
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
      MessageModel messageModel = MessageModel(
          messageId: messageId,
          messageContent: messageContent,
          messageCreatedAt: now,
          messageFileUrl: downloadUrl,
          messageType: messageType,
          senderId: myUid,
          receiverId: receiverId);

      ChatModel chatModel = ChatModel(
          senderID: receiverId,
          receiverID: myUid,
          lastMessage: messageContent!,
          lastMessageSenderId: myUid,
          lastMessageCreatedAt: now,
          lastMessageType: messageType);

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
          .collection('messages')
          .doc(messageId)
          .set(messageModel.toMap());
      _firestore
          .collection('users')
          .doc(receiverId)
          .collection('chats')
          .doc(myUid)
          .collection('messages')
          .doc(messageId)
          .set(messageModel.toMap());

      _firestore
          .collection('users')
          .doc(myUid)
          .collection('chats')
          .doc(receiverId)
          .update({
        'lastMessage': messageContent,
        'lastMessageType': messageType,
        'lastMessageSenderId': myUid,
        'lastMessageCreatedAt': now
      });
      _firestore
          .collection('users')
          .doc(receiverId)
          .collection('chats')
          .doc(myUid)
          .update({
        'lastMessage': messageContent,
        'lastMessageType': messageType,
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
