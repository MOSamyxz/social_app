import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/data/model/messege_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/home/widget/post_widgets/video_view_home.dart';
import 'package:flutter/material.dart';

class FullScreenVideoChat extends StatelessWidget {
  const FullScreenVideoChat({
    super.key,
    required this.messege,
    required this.user,
    required this.myUser,
  });
  final MessegeModel messege;
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
          messege.senderId == myUser.uId
              ? 'from: ${myUser.userName}'
              : 'from: ${user.userName}',
        ),
      ),
      body: VideoViewHome(
        video: Uri.parse(messege.messegeFileUrl!),
        isSearchView: false,
      ),
    );
  }
}
