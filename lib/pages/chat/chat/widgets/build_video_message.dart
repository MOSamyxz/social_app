import 'package:chatapp/data/model/message_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/chat/chat/full_screen_video_chat.dart';
import 'package:chatapp/pages/chat/chat/widgets/chat_buble.dart';
import 'package:chatapp/pages/home/widget/post_widgets/video_view_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildVideoMessage extends StatelessWidget {
  const BuildVideoMessage({
    super.key,
    required this.borderRadius,
    required this.messege,
    required this.user,
    required this.myUser,
  });

  final BorderRadius borderRadius;
  final MessageModel messege;
  final UsersModel user;
  final UsersModel myUser;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: ScreenUtil().screenWidth * 0.5,
            child: VideoViewHome(
              video: Uri.parse(messege.messageFileUrl!),
              isSearchView: true,
              child: FullScreenVideoChat(
                message: messege,
                user: user,
                myUser: myUser,
              ),
            ),
          ),
          messege.messageContent == ''
              ? const SizedBox()
              : Text(
                  messege.messageContent!,
                  style: TextStyle(fontSize: 16.sp),
                ),
          Text(
            formatDateTime(
              '${messege.messageCreatedAt}',
            ),
            style: TextStyle(fontSize: 11.sp),
          ),
        ],
      ),
    );
  }
}
