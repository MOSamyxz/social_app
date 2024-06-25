import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/data/firestore_messeges.dart/firestore_messeges.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/chat/chat/chat_screen.dart';
import 'package:chatapp/pages/profile/widget/follow_button.dart';
import 'package:chatapp/pages/profile/widget/profile_button.dart';
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
    required this.myUser,
  }) : super(key: key);

  final UsersModel user;
  final UsersModel myUser;
  final int postLen;

  @override
  Widget build(BuildContext context) {
    final isFollowing = user.followers.contains(myUser.uId);
    final isSentRequest = user.receivedRequest.contains(myUser.uId);
    return Container(
      color: Theme.of(context).cardTheme.color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileImageAndCover(user: user),
          ProfileNameBio(user: user),
          VerticalSpace(10.h),
          ProfileStates(postLen: postLen, user: user),
          Padding(
            padding: AppPadding.screenPadding,
            child: Row(
              children: [
                user.uId != myUser.uId
                    ? Expanded(
                        child: ProfileButton(
                            onPressed: () {
                              FirestoreMesseges()
                                  .createCahtRoom(userId: user.uId);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                      user: user,
                                    ),
                                  ));
                            },
                            color: AppColors.blueColor,
                            textColor: AppColors.realWhiteColor,
                            text: 'Send messege'),
                      )
                    : const SizedBox(),
                Expanded(
                  child: StreamFollowButton(
                    profileUser: user,
                    myUser: myUser,
                    isFollowing: isFollowing,
                    isSentRequest: isSentRequest,
                  ),
                ),
              ],
            ),
          ),
          VerticalSpace(10.h),
        ],
      ),
    );
  }
}
