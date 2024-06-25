import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/profile/cubit/profile_cubit.dart';
import 'package:chatapp/pages/profile/widget/build_profile_posts.dart';
import 'package:chatapp/pages/profile/widget/profile_header.dart';
import 'package:chatapp/pages/saved_posts/saved_posts.dart';
import 'package:chatapp/pages/settings/settings_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
    this.profileUser,
  }) : super(key: key);

  final UsersModel? profileUser;

  @override
  Widget build(BuildContext context) {
    UsersModel user = profileUser ?? BlocProvider.of<AppCubit>(context).getUser;
    UsersModel myUser = BlocProvider.of<AppCubit>(context).getUser;
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                actions: [if (myUser.uId == user.uId) const MyProfileAppBar()],
              ),
              body: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('posts')
                      .where('posterId', isEqualTo: user.uId)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    var postLen = snapshot.data!.docs.length;
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(user.uId)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  var snapshotUser = UsersModel.fromMap(
                                      snapshot.data!.data()
                                          as Map<String, dynamic>);

                                  return ProfileHeader(
                                    user: snapshotUser,
                                    myUser: myUser,
                                    postLen: postLen,
                                  );
                                }
                              }),
                          VerticalSpace(10.h),
                          myUser.following.contains(user.uId) ||
                                  myUser.uId == user.uId
                              ? BuildProfilePosts(
                                  profileUser: user,
                                )
                              : const Text(
                                  'You need to follow this user first.!'),
                        ],
                      ),
                    );
                  }));
        },
      ),
    );
  }
}

class MyProfileAppBar extends StatelessWidget {
  const MyProfileAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SavedPostsScreen()));
            },
            icon: const FaIcon(FontAwesomeIcons.bookmark)),
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingScreen()));
            },
            icon: const FaIcon(FontAwesomeIcons.gear)),
      ],
    );
  }
}
