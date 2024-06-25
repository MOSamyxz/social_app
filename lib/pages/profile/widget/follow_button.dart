import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/data/firebase_auth/firebase_auth.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/edit_profile/edit_profile_screen.dart';
import 'package:chatapp/pages/profile/cubit/profile_cubit.dart';
import 'package:chatapp/pages/profile/widget/profile_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StreamFollowButton extends StatelessWidget {
  const StreamFollowButton({
    super.key,
    required this.profileUser,
    required this.isFollowing,
    required this.isSentRequest,
    required this.myUser,
  });

  final UsersModel profileUser;
  final UsersModel myUser;
  final bool isFollowing;
  final bool isSentRequest;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Padding(
          padding: AppPadding.screenPadding,
          child: FirebaseAuth.instance.currentUser!.uid == profileUser.uId
              ? Row(
                  children: [
                    Expanded(
                      child: ProfileButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfileScreen(
                                        profileUser: profileUser,
                                      )));
                        },
                        color: AppColors.blueColor,
                        textColor: AppColors.realWhiteColor,
                        text: 'Edit Profile',
                      ),
                    ),
                    const HorizontalSpace(10),
                    Expanded(
                      child: ProfileButton(
                        onPressed: () {
                          FirebaseAuthServices().signOut(context);
                        },
                        color: AppColors.realWhiteColor,
                        textColor: AppColors.blackColor,
                        text: 'Sign out',
                      ),
                    ),
                  ],
                )
              : isSentRequest
                  ? ProfileButton(
                      onPressed: () {
                        BlocProvider.of<ProfileCubit>(context)
                            .removeFollowRequest(profileUser.uId);
                      },
                      color: AppColors.whiteColor,
                      textColor: AppColors.blackColor,
                      text: 'Cancel')
                  : isFollowing
                      ? ProfileButton(
                          onPressed: () {
                            BlocProvider.of<ProfileCubit>(context)
                                .removeFollower(profileUser.uId);
                          },
                          color: AppColors.realWhiteColor,
                          textColor: AppColors.blackColor,
                          text: 'Unfollow',
                        )
                      : ProfileButton(
                          onPressed: () {
                            BlocProvider.of<ProfileCubit>(context)
                                .sendFollowRequest(
                                    user: profileUser, myUser: myUser);
                          },
                          color: AppColors.blueColor,
                          textColor: AppColors.realWhiteColor,
                          text: 'Follow',
                        ),
        );
      },
    );
  }
}
