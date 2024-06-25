import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/data/model/post_model.dart';
import 'package:chatapp/pages/saved_posts/widgets/post_image_item.dart';
import 'package:chatapp/pages/saved_posts/widgets/post_video_item.dart';
import 'package:chatapp/pages/saved_posts/widgets/poster_profile_pic.dart';
import 'package:chatapp/pages/saved_posts/widgets/saved_post_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavedPostItem extends StatelessWidget {
  const SavedPostItem({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.r10),
            color: Theme.of(context).cardTheme.color),
        child: Row(
          children: [
            SizedBox(
              width: ScreenUtil().screenWidth * 0.25,
              height: ScreenUtil().screenWidth * 0.25,
              child: post.fileUrl == ''
                  ? PosterProfilePic(post: post)
                  : post.postType == 'postMediaImage'
                      ? PostImageItem(post: post)
                      : PostVideoItem(post: post),
            ),
            const HorizontalSpace(10),
            SavedPostDetails(post: post),
          ],
        ));
  }
}
