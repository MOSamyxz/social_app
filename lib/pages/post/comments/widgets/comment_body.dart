import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/utils/utils.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/model/comment_model.dart';
import 'package:chatapp/data/model/post_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/home/cubit/home_cubit.dart';
import 'package:chatapp/pages/post/comments/cubit/comments_cubit.dart';
import 'package:chatapp/pages/post/comments/widgets/comment_content.dart';
import 'package:chatapp/pages/post/comments/widgets/comment_react_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentBody extends StatelessWidget {
  const CommentBody({
    super.key,
    required this.comments,
    required this.index,
    required this.post,
    required this.user,
    required this.isLiked,
  });

  final List<CommentModel> comments;
  final int index;
  final Post post;
  final UsersModel user;
  final bool isLiked;

  @override
  Widget build(BuildContext context) {
    return Column(
      textDirection: isArabicText('${comments[index].createdAt!}')
          ? TextDirection.rtl
          : TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onLongPress: () {
            BlocProvider.of<CommentsCubit>(context).deleteComment(
                postId: post.postId, commentId: comments[index].commentId);
            BlocProvider.of<HomeCubit>(context).removeCommentNotification(
                post: post, user: user, length: comments.length);
          },
          child: Container(
            padding: EdgeInsets.all(5.h),
            decoration: BoxDecoration(
                color: BlocProvider.of<AppCubit>(context).isDark
                    ? Theme.of(context).cardTheme.color
                    : AppColors.lightScaffoldColor,
                borderRadius: BorderRadius.circular(AppSize.r15)),
            child: CommentContent(
              comments: comments,
              index: index,
            ),
          ),
        ),
        CommentReactButton(
            comments: comments,
            index: index,
            post: post,
            user: user,
            isLiked: isLiked)
      ],
    );
  }
}
