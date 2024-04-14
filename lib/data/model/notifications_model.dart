class NotificationsModel {
  final String posterId;
  final String posterName;
  final String posterImageUrl;
  final String postId;
  final String? reactID;
  final List<String>? reactName;
  final List<String>? reactImageUrl;
  final String? lastReactID;
  final String? lastReactName;
  final String? lastReactImageUrl;
  final String? likeType;
  final String? commenterID;
  final String? commenterName;
  final String? commenterImageUrl;
  final DateTime createdAt;

  NotificationsModel({
    required this.posterId,
    required this.posterName,
    required this.posterImageUrl,
    required this.postId,
    this.reactID,
    this.reactName,
    this.reactImageUrl,
    this.lastReactID,
    this.lastReactName,
    this.lastReactImageUrl,
    this.likeType,
    this.commenterID,
    this.commenterName,
    this.commenterImageUrl,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'posterId': posterId,
      'posterName': posterName,
      'posterImageUrl': posterImageUrl,
      'postId': postId,
      'reactID': reactID,
      'reactName': reactName,
      'reactImageUrl': reactImageUrl,
      'lastReactID': lastReactID,
      'lastReactName': lastReactName,
      'lastReactImageUrl': lastReactImageUrl,
      'likeType': likeType,
      'commenterID': commenterID,
      'commenterName': commenterName,
      'commenterImageUrl': commenterImageUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory NotificationsModel.fromMap(Map<String, dynamic> map) {
    return NotificationsModel(
        posterId: map['posterId'],
        posterName: map['posterName'],
        posterImageUrl: map['posterImageUrl'],
        postId: map['postId'],
        reactID: map['reactID'],
        reactName: List<String>.from(map['reactName'] ?? []),
        reactImageUrl: List<String>.from(map['reactImageUrl'] ?? []),
        lastReactID: map['lastReactID'],
        lastReactName: map['lastReactName'],
        lastReactImageUrl: map['lastReactImageUrl'],
        likeType: map['likeType'],
        commenterID: map['commenterID'],
        commenterName: map['commenterName'],
        commenterImageUrl: map['commenterImageUrl'],
        createdAt: DateTime.fromMillisecondsSinceEpoch(
          map['createdAt'] ?? 0,
        ));
  }
}
