import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/data/model/message_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/home/widget/post_widgets/video_view_home.dart';
import 'package:flutter/material.dart';

class FullScreenVideoChat extends StatelessWidget {
  const FullScreenVideoChat({
    super.key,
    required this.message,
    required this.user,
    required this.myUser,
  });
  final MessageModel message;
  final UsersModel user;
  final UsersModel myUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        foregroundColor: AppColors.realWhiteColor,
        backgroundColor: AppColors.blackColor,
        title: Text(
          message.senderId == myUser.uId
              ? 'from: ${myUser.userName}'
              : 'from: ${user.userName}',
        ),
      ),
      body: VideoViewHome(
        video: Uri.parse(message.messageFileUrl!),
        isSearchView: false,
      ),
    );
  }
}
