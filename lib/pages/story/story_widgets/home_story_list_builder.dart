import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/home/widget/post_widgets/post_shimmer.dart';
import 'package:chatapp/pages/story/story_widgets/add_story_item.dart';
import 'package:chatapp/pages/story/story_widgets/story_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
