import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/profile/widget/follow_button.dart';
import 'package:chatapp/pages/profile/widget/profile_image_and_cover.dart';
import 'package:chatapp/pages/profile/widget/profile_name_bio.dart';
import 'package:chatapp/pages/profile/widget/profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key? key,
    required this.user,
    required this.postLen,
    required this.isFollowing,
    required this.isSentRequest,
    required this.myUser,
  }) : super(key: key);

  final UsersModel user;
  final UsersModel myUser;
  final int postLen;
  final bool isFollowing;
  final bool isSentRequest;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardTheme.color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileImageAndCover(user: user),
          ProfileNameBio(user: user),
          VerticalSpace(10.h),
          ProfileStates(postLen: postLen, user: user),
          StreamFollowButton(
            profileUser: user,
            myUser: myUser,
            isFollowing: isFollowing,
            isSentRequest: isSentRequest,
          ),
          VerticalSpace(10.h),
        ],
      ),
    );
  }
}
