import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/profile/widget/build_state_column.dart';
import 'package:flutter/material.dart';

class ProfileStates extends StatelessWidget {
  const ProfileStates({
    super.key,
    required this.postLen,
    required this.user,
  });

  final int postLen;
  final UsersModel user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BuildStateColumn(num: postLen, label: 'Posts'),
        BuildStateColumn(num: user.followers.length, label: "followers"),
        BuildStateColumn(num: user.following.length, label: "following"),
      ],
    );
  }
}
