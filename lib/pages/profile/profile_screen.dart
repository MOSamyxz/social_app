import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/profile/cubit/profile_cubit.dart';
import 'package:chatapp/pages/profile/widget/build_profile_posts.dart';
import 'package:chatapp/pages/profile/widget/profile_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, this.profileUser}) : super(key: key);

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
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          UsersModel user =
              widget.profileUser ?? BlocProvider.of<AppCubit>(context).getUser;

          return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                            bool isSentRequest = user.receivedRequest.contains(
                                FirebaseAuth.instance.currentUser!.uid);
                            bool isFollowing = user.followers.contains(
                                FirebaseAuth.instance.currentUser!.uid);
                            // Show a loading indicator while waiting for getUserData() to complete
                            return ProfileHeader(
                                user: user,
                                postLen: postLen,
                                isFollowing: isFollowing,
                                isSentRequest: isSentRequest);
                          } else {
                            var snapshotUser = UsersModel.fromMap(
                                snapshot.data!.data() as Map<String, dynamic>);

                            bool isSentRequest = snapshotUser.receivedRequest
                                .contains(
                                    FirebaseAuth.instance.currentUser!.uid);
                            bool isFollowing = snapshotUser.followers.contains(
                                FirebaseAuth.instance.currentUser!.uid);
                            return ProfileHeader(
                                user: snapshotUser,
                                postLen: postLen,
                                isFollowing: isFollowing,
                                isSentRequest: isSentRequest);
                          }
                        }),
                    VerticalSpace(10.h),
                    BuildProfilePosts(
                      profileUser: user,
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }
}
