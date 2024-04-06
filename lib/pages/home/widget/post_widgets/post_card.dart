import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/data/model/like_data_model.dart';
import 'package:chatapp/data/model/post_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/home/full_screen_image.dart';
import 'package:chatapp/pages/home/widget/post_widgets/post_header.dart';
import 'package:chatapp/pages/home/widget/post_widgets/stream_post_satats.dart';
import 'package:chatapp/pages/home/widget/post_widgets/video_view_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.user,
    required this.post,
    required this.index,
    this.likesData,
    this.commentsLength,
  });

  final UsersModel user;
  final Post post;
  final LikesDataModel? likesData;
  final int index;
  final int? commentsLength;

  @override
  Widget build(BuildContext context) {
    // UsersModel user = BlocProvider.of<AppCubit>(context).getUser;
    final isLiked = post.likes.contains(user.uId);

    return Container(
      margin: EdgeInsets.only(bottom: 5.h),
      decoration: BoxDecoration(color: Theme.of(context).cardTheme.color),
      child: SingleChildScrollView(
        child: Column(
          children: [
            PostHeader(post: post, user: user),
            post.content != '' ? const VerticalSpace(5) : const SizedBox(),
            post.postType == 'post'
                ? const SizedBox()
                : post.postType == 'postMediaImage'
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullImageScreen(
                                imageUrl: post.fileUrl!,
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          width: ScreenUtil().screenWidth,
                          child: Image(
                            image: NetworkImage(
                              post.fileUrl!,
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    : VideoViewHome(
                        video: Uri.parse(post.fileUrl!),
                        isSearchView: false,
                      ),
            StreamPostStats(
              post: post,
              isLiked: isLiked,
              likesData: likesData,
              user: user,
              commentsLenght: commentsLength,
            ),
          ],
        ),
      ),
    );
  }
}
