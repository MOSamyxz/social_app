import 'package:chatapp/core/constants/assets.dart';
import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/utils/get_time.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/data/model/notifications_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/search/widget/post_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentNotificationItem extends StatelessWidget {
  const CommentNotificationItem({
    super.key,
    required this.notificationsModel,
    required this.user,
  });
  final NotificationsModel notificationsModel;
  final UsersModel user;
  @override
  Widget build(BuildContext context) {
    int lastNotification = notificationsModel.commenterName!.length;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PostView(
                      user: user,
                      posterName: notificationsModel.posterName,
                      postId: notificationsModel.postId,
                    )));
      },
      child: Padding(
        padding: AppPadding.screenPadding,
        child: Row(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: AppSize.r30,
                  backgroundImage: NetworkImage(notificationsModel
                      .commenterImageUrl![lastNotification - 1]),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: AppSize.r12,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                    ),
                    CircleAvatar(
                      radius: AppSize.r10,
                      backgroundColor: AppColors.darkBlueColor,
                      child: Image.asset(
                        AppAssets.comment,
                        color: AppColors.whiteColor,
                        width: 17.w,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const HorizontalSpace(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  lastNotification == 1
                      ? Text(
                          '${notificationsModel.commenterName![lastNotification - 1]} Commented on your post',
                          style: const TextStyle(fontSize: 16),
                        )
                      : Text(
                          '${notificationsModel.commenterName![lastNotification - 1]} and ${lastNotification - 1} others Commented on your post',
                          style: const TextStyle(fontSize: 16),
                          maxLines: 2,
                        ),
                  Text(
                      getTimeText(notificationsModel.createdAt, context, false))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
