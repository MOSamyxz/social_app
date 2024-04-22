import 'package:chatapp/data/model/like_data_model.dart';
import 'package:chatapp/data/model/post_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/home/widget/post_widgets/post_satates.dart';
import 'package:flutter/material.dart';

class StreamPostStats extends StatelessWidget {
  const StreamPostStats({
    super.key,
    required this.post,
    required this.isLiked,
    required this.likesData,
    required this.user,
    this.commentsLenght,
    required this.isSaved,
  });

  final Post post;
  final bool isLiked;
  final bool isSaved;
  final LikesDataModel? likesData;
  final UsersModel user;
  final int? commentsLenght;

  @override
  Widget build(BuildContext context) {
    return PostStats(
      post: post,
      commentsLenght: commentsLenght!,
      isLiked: isLiked,
      isSaved: isSaved,
      likesData: likesData,
      user: user,
    );
  }
}
