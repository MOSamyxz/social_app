class NotificationsModel {
  final String posterId;
  final String posterName;
  final String posterImageUrl;
  final String postId;
  final List<String>? reactName;
  final List<String>? reactImageUrl;
  final List<String>? commenterName;
  final List<String>? commenterImageUrl;
  final String? likeType;
  final bool isComment;
  final DateTime createdAt;

  NotificationsModel({
    required this.posterId,
    required this.posterName,
    required this.posterImageUrl,
    this.commenterName,
    this.commenterImageUrl,
    required this.postId,
    this.reactName,
    this.reactImageUrl,
    this.likeType,
    required this.isComment,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'posterId': posterId,
      'posterName': posterName,
      'posterImageUrl': posterImageUrl,
      'postId': postId,
      'reactName': reactName,
      'commenterName': commenterName,
      'commenterImageUrl': commenterImageUrl,
      'reactImageUrl': reactImageUrl,
      'likeType': likeType,
      'isComment': isComment,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory NotificationsModel.fromMap(Map<String, dynamic> map) {
    return NotificationsModel(
        posterId: map['posterId'],
        posterName: map['posterName'],
        posterImageUrl: map['posterImageUrl'],
        postId: map['postId'],
        reactName: List<String>.from(map['reactName'] ?? []),
        reactImageUrl: List<String>.from(map['reactImageUrl'] ?? []),
        commenterName: List<String>.from(map['commenterName'] ?? []),
        commenterImageUrl: List<String>.from(map['commenterImageUrl'] ?? []),
        likeType: map['likeType'],
        isComment: map['isComment'],
        createdAt: DateTime.fromMillisecondsSinceEpoch(
          map['createdAt'] ?? 0,
        ));
  }
}
