import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/model/story_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/home/widget/post_widgets/post_shimmer.dart';
import 'package:chatapp/pages/story/add_story_screen.dart';
import 'package:chatapp/pages/story/story_view_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeStoryListBuilder extends StatelessWidget {
  const HomeStoryListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    UsersModel myUser = BlocProvider.of<AppCubit>(context).getUser;
    return Container(
      padding: EdgeInsets.all(10.w),
      color: Theme.of(context).cardTheme.color,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('lastPublishedStory', isGreaterThan: DateTime.now())
              .orderBy('lastPublishedStory', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const StoryShimmer();
            } else {
              return SizedBox(
                height: ScreenUtil().screenHeight * 0.16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AddStoryItem(
                      myUser: myUser,
                    ),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: ((context, index) {
                            var users = UsersModel.fromMap(
                                snapshot.data!.docs[index].data());
                            snapshot.data!.docs.map((doc) {
                              return UsersModel.fromMap(doc.data());
                            }).toList();
                            if (myUser.followers.contains(users.uId) ||
                                users.uId == myUser.uId) {
                              return StoryItem(
                                user: users,
                                itemCount: snapshot.data!.docs.length,
                              );
                            } else {
                              return const SizedBox();
                            }
                          })),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}

class StoryItem extends StatelessWidget {
  const StoryItem({
    super.key,
    required this.user,
    required this.itemCount,
  });
  final UsersModel user;
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uId)
            .collection('stories')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            // Handle the case when the snapshot is empty or the index is out of range
            return const SizedBox.shrink();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const StoryShimmer();
          }
          var storyModel = snapshot.data!.docs
              .map((doc) => StoryModel.fromMap(doc.data()))
              .toList();

          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StoryViewScreen(
                            snapshot: snapshot,
                            stories: storyModel,
                            itemCount: snapshot.data!.docs.length,
                          )));
            },
            child: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 95,
                        height: 95,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [
                                  AppColors.darkBlueColor,
                                  AppColors.lighterBlueColor
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight),
                            borderRadius: BorderRadius.circular(95)),
                      ),
                      CircleAvatar(
                        radius: AppSize.r44,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                      ),
                      CircleAvatar(
                        backgroundImage: NetworkImage(user.imageUrl),
                        radius: AppSize.r40,
                      ),
                    ],
                  ),
                  const VerticalSpace(5),
                  Container(
                    alignment: Alignment.center,
                    width: 95,
                    child: Text(
                      user.userName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class AddStoryItem extends StatelessWidget {
  const AddStoryItem({
    super.key,
    required this.myUser,
  });
  final UsersModel myUser;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 95,
                    height: 95,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [
                              AppColors.darkBlueColor,
                              AppColors.lighterBlueColor
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight),
                        borderRadius: BorderRadius.circular(95)),
                  ),
                  CircleAvatar(
                    radius: AppSize.r44,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(myUser.imageUrl),
                    radius: AppSize.r40,
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddStoryScreen(
                                myUser: myUser,
                              )));
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: AppSize.r20,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                    ),
                    CircleAvatar(
                        radius: AppSize.r15,
                        backgroundColor: AppColors.greyColor,
                        child: const FaIcon(
                          FontAwesomeIcons.plus,
                          color: AppColors.blackColor,
                        )),
                  ],
                ),
              ),
            ],
          ),
          const VerticalSpace(5),
          const Text('Add Story')
        ],
      ),
    );
  }
}
