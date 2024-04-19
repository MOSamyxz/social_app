import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/data/model/comment_model.dart';
import 'package:chatapp/data/model/post_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/post/comments/widgets/comment_body.dart';
import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({
    super.key,
    required this.comments,
    required this.post,
    required this.user,
    required this.isLiked,
    required this.index,
  });

  final List<CommentModel> comments;
  final Post post;
  final UsersModel user;
  final bool isLiked;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.screenPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(comments[index].authorProfileUrl),
          ),
          const HorizontalSpace(10),
          CommentBody(
              comments: comments,
              index: index,
              post: post,
              user: user,
              isLiked: isLiked),
        ],
      ),
    );
  }
}
