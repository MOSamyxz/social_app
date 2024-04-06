import 'package:chatapp/core/constants/assets.dart';
import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/constants/styles.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/data/model/like_data_model.dart';
import 'package:chatapp/data/model/post_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/home/widget/post_widgets/post_like_comment_save_buttons.dart';
import 'package:chatapp/pages/post/comments_screen.dart';
import 'package:chatapp/pages/post/likes_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostStats extends StatelessWidget {
  const PostStats({
    super.key,
    required this.post,
    required this.commentsLenght,
    required this.isLiked,
    required this.likesData,
    required this.user,
  });

  final Post post;
  final int commentsLenght;
  final bool isLiked;
  final LikesDataModel? likesData;
  final UsersModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s10),
      child: Column(
        children: [
          Row(
            //mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: TextDirection.ltr,

            children: [
              InkWell(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LikesScreen(
                                    postId: post.postId,
                                  )));
                    },
                    child: Row(
                      textDirection: TextDirection.ltr,
                      children: [
                        Image.asset(
                          AppAssets.like,
                          width: AppSize.r20,
                        ),
                        const HorizontalSpace(5),
                        Text(
                          '${post.likes.length}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.darkGreyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {},
              ),
              InkWell(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    '$commentsLenght comments',
                    style: TextStyle(
                      fontWeight: AppFontWeight.regular,
                      fontSize: 16.sp,
                      color: AppColors.darkGreyColor,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CommentScreen(
                                postId: post.postId,
                              )));
                },
              ),
            ],
          ),
          const Divider(),
          PostLikeCommentShareButtons(
            isLiked: isLiked,
            post: post,
            likesData: likesData,
            user: user,
          )
        ],
      ),
    );
  }
}
