import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String senderID;
  final String receiverID;
  final String lastMessage;
  final String lastMessageType;
  final String lastMessageSenderId;
  final DateTime lastMessageCreatedAt;

  ChatModel({
    required this.senderID,
    required this.receiverID,
    required this.lastMessage,
    required this.lastMessageType,
    required this.lastMessageSenderId,
    required this.lastMessageCreatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderID': senderID,
      'receiverID': receiverID,
      'lastMessage': lastMessage,
      'lastMessageType': lastMessageType,
      'lastMessageSenderId': lastMessageSenderId,
      'lastMessageCreatedAt': lastMessageCreatedAt,
    };
  }

  static ChatModel fromMap(Map<String, dynamic> map) {
    return ChatModel(
      senderID: map['senderID'],
      receiverID: map['receiverID'],
      lastMessage: map['lastMessage'],
      lastMessageType: map['lastMessageType'],
      lastMessageSenderId: map['lastMessageSenderId'],
      lastMessageCreatedAt: (map['lastMessageCreatedAt'] as Timestamp).toDate(),
    );
  }
}
