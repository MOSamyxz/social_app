import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/home/widget/post_widgets/post_shimmer.dart';
import 'package:chatapp/pages/profile/cubit/profile_cubit.dart';
import 'package:chatapp/pages/profile/widget/build_profile_posts.dart';
import 'package:chatapp/pages/profile/widget/profile_header.dart';
import 'package:chatapp/pages/saved_posts/saved_posts.dart';
import 'package:chatapp/pages/settings/settings_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
    this.profileUser,
  }) : super(key: key);

  final UsersModel? profileUser;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int postLen = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      UsersModel user =
          widget.profileUser ?? BlocProvider.of<AppCubit>(context).getUser;

      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('posterId', isEqualTo: user.uId)
          .get();

      postLen = postSnap.docs.length;

      setState(() {});
    } catch (e) {
      e.toString();
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
        BlocProvider(
          create: (context) => AppCubit()
            ..getUserData()
            ..getVerifiedMembers(),
        ),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          if (state is GetCurrentUserDataSuccessState ||
              state is GetVerifiedMembersDataSuccessState) {
            return BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                UsersModel user = widget.profileUser ??
                    BlocProvider.of<AppCubit>(context).getUser;
                UsersModel myUser = BlocProvider.of<AppCubit>(context).getUser;

                return Scaffold(
                    appBar: AppBar(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      actions: [
                        FirebaseAuth.instance.currentUser!.uid == user.uId
                            ? Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SavedPostsScreen()));
                                      },
                                      icon: const FaIcon(
                                          FontAwesomeIcons.bookmark)),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SettingScreen()));
                                      },
                                      icon:
                                          const FaIcon(FontAwesomeIcons.gear)),
                                ],
                              )
                            : const SizedBox()
                      ],
                    ),
                    body: SingleChildScrollView(
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
                                  bool isSentRequest = user.receivedRequest
                                      .contains(FirebaseAuth
                                          .instance.currentUser!.uid);
                                  bool isFollowing = user.followers.contains(
                                      FirebaseAuth.instance.currentUser!.uid);
                                  // Show a loading indicator while waiting for getUserData() to complete
                                  return ProfileHeader(
                                    user: user,
                                    postLen: postLen,
                                    isFollowing: isFollowing,
                                    isSentRequest: isSentRequest,
                                    myUser: myUser,
                                  );
                                } else {
                                  var snapshotUser = UsersModel.fromMap(
                                      snapshot.data!.data()
                                          as Map<String, dynamic>);

                                  bool isSentRequest = snapshotUser
                                      .receivedRequest
                                      .contains(FirebaseAuth
                                          .instance.currentUser!.uid);
                                  bool isFollowing = snapshotUser.followers
                                      .contains(FirebaseAuth
                                          .instance.currentUser!.uid);
                                  return ProfileHeader(
                                      user: snapshotUser,
                                      myUser: myUser,
                                      postLen: postLen,
                                      isFollowing: isFollowing,
                                      isSentRequest: isSentRequest);
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
                    ));
              },
            );
          }
          return const PostShimmer();
        },
      ),
    );
  }
}
