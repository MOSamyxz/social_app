class MessegeModel {
  final String messegeId;
  final String? messegeContent;
  final DateTime messegeCreatedAt;
  final String? messegeFileUrl;
  final String messegeType;
  final String senderId;
  final String receiverId;

  MessegeModel({
    required this.messegeId,
    this.messegeContent,
    required this.messegeCreatedAt,
    this.messegeFileUrl,
    required this.messegeType,
    required this.senderId,
    required this.receiverId,
  });

  Map<String, dynamic> toMap() {
    return {
      'messegeId': messegeId,
      'messegeContent': messegeContent,
      'messegeCreatedAt': messegeCreatedAt.millisecondsSinceEpoch,
      'messegeFileUrl': messegeFileUrl,
      'messegeType': messegeType,
      'senderId': senderId,
      'receiverId': receiverId,
    };
  }

  static MessegeModel fromMap(Map<String, dynamic> map) {
    return MessegeModel(
      messegeId: map['messegeId'],
      messegeContent: map['messegeContent'],
      messegeCreatedAt: DateTime.fromMillisecondsSinceEpoch(
        map['messegeCreatedAt'] ?? 0,
      ),
      messegeFileUrl: map['messegeFileUrl'],
      messegeType: map['messegeType'],
      senderId: map['senderId'],
      receiverId: map['receiverId'],
    );
  }
}
