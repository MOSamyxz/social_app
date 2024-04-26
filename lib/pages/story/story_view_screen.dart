import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/model/story_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/story/cubit/story_cubit.dart';
import 'package:chatapp/pages/story/story_widgets/story_header.dart';
import 'package:chatapp/pages/story/story_widgets/story_view_item.dart';
import 'package:chatapp/pages/story/story_widgets/story_views_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_view/story_view.dart';

class StoryViewScreen extends StatefulWidget {
  const StoryViewScreen(
      {super.key,
      required this.snapshot,
      required this.stories,
      required this.itemCount});
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;
  final List<StoryModel> stories;
  final int itemCount;
  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> {
  late List<StoryItem> storyItems;
  late StoryController storyController;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    storyController = StoryController();
    pageController = PageController();
    storyItems = widget.snapshot.data!.docs
        .map((doc) {
          var story = StoryModel.fromMap(doc.data());
          if (story.expiryTime.toDate().isAfter(DateTime.now())) {
            if (story.storyType == 'post') {
              return StoryItem.text(
                title: story.content!,
                backgroundColor: Colors.red,
              );
            } else if (story.storyType == 'video') {
              return StoryItem.pageVideo(
                duration: story.duration,
                story.fileUrl!,
                caption: Text(story.content!, textAlign: TextAlign.center),
                controller: storyController,
              );
            } else {
              return StoryItem.pageImage(
                url: story.fileUrl!,
                captionOuterPadding: EdgeInsets.symmetric(vertical: 40.h),
                caption: Text(
                  story.content!,
                  textAlign: TextAlign.center,
                ),
                controller: storyController,
              );
            }
          } else {
            // Story has expired, you can handle it accordingly
            return null;
          }
        })
        .where((storyItem) => storyItem != null)
        .toList()
        .cast<StoryItem>();
  }

  @override
  Widget build(BuildContext context) {
    UsersModel user = BlocProvider.of<AppCubit>(context).getUser;

    return BlocProvider(
      create: (context) => StoryCubit()..init(),
      child: BlocConsumer<StoryCubit, StoryState>(
        listener: (context, state) {
          if (state is GettUsersDataByIdSuccessState) {
            List<UsersModel> users =
                BlocProvider.of<StoryCubit>(context).usersById;
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10.w, top: 10.h),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(users[index].imageUrl),
                          ),
                          const HorizontalSpace(10),
                          Text(users[index].userName)
                        ],
                      ),
                    );
                  }),
                );
              },
            );
          }
        },
        builder: (context, state) {
          StoryModel story =
              widget.stories[BlocProvider.of<StoryCubit>(context).currentIndex];
          return Scaffold(
              body: PageView.builder(
                  itemCount: widget.itemCount,
                  itemBuilder: (context, index) {
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            StoryViewItem(
                                widget: widget, storyItems: storyItems),
                            StoryHeader(story: story, user: user)
                          ],
                        ),
                        if (story.storyAutherId == user.uId)
                          StoryViewsItem(story: story)
                      ],
                    );
                  }));
        },
      ),
    );
  }
}
