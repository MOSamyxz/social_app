class MessageModel {
  final String messageId;
  final String? messageContent;
  final DateTime messageCreatedAt;
  final String? messageFileUrl;
  final String messageType;
  final String senderId;
  final String receiverId;

  MessageModel({
    required this.messageId,
    this.messageContent,
    required this.messageCreatedAt,
    this.messageFileUrl,
    required this.messageType,
    required this.senderId,
    required this.receiverId,
  });

  Map<String, dynamic> toMap() {
    return {
      'messageId': messageId,
      'messageContent': messageContent,
      'messageCreatedAt': messageCreatedAt.millisecondsSinceEpoch,
      'messageFileUrl': messageFileUrl,
      'messageType': messageType,
      'senderId': senderId,
      'receiverId': receiverId,
    };
  }

  static MessageModel fromMap(Map<String, dynamic> map) {
    return MessageModel(
      messageId: map['messageId'],
      messageContent: map['messageContent'],
      messageCreatedAt: DateTime.fromMillisecondsSinceEpoch(
        map['messageCreatedAt'] ?? 0,
      ),
      messageFileUrl: map['messageFileUrl'],
      messageType: map['messageType'],
      senderId: map['senderId'],
      receiverId: map['receiverId'],
    );
  }
}
