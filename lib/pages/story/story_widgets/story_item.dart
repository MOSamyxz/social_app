import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/data/model/story_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/home/widget/post_widgets/post_shimmer.dart';
import 'package:chatapp/pages/story/story_view_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
