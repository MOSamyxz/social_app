import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/utils/to_ar_num_converter.dart';
import 'package:chatapp/core/utils/utils.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/model/story_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/story/cubit/story_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                story.fileUrl!,
                caption: Text(story.content!, textAlign: TextAlign.center),
                controller: storyController,
              );
            } else {
              return StoryItem.pageImage(
                url: story.fileUrl!,
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
    return BlocProvider(
      create: (context) => StoryCubit()..init(),
      child: BlocBuilder<StoryCubit, StoryState>(
        builder: (context, state) {
          UsersModel myUser = BlocProvider.of<AppCubit>(context).getUser;
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
                            StoryView(
                              inline: true,
                              onStoryShow: (storyItem, index) {
                                BlocProvider.of<StoryCubit>(context)
                                    .indexChange(index);
                                BlocProvider.of<StoryCubit>(context).viewStory(
                                    userId: widget.stories[index].storyAutherId,
                                    storyId: widget.stories[index].storyId);
                              },
                              storyItems: storyItems,
                              onComplete: () {
                                Future.delayed(const Duration(seconds: 1), () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                });
                              },
                              onVerticalSwipeComplete: (direction) {
                                if (direction == Direction.down) {
                                  Future.delayed(const Duration(seconds: 1),
                                      () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  });
                                } else if (direction == Direction.up) {
                                  // Handle swipe up
                                }
                              },
                              controller: BlocProvider.of<StoryCubit>(context)
                                  .storyController,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 50.h, left: 20.w),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: AppSize.r20,
                                    backgroundImage: NetworkImage(
                                        story.storyAutherProfileUrl),
                                  ),
                                  const HorizontalSpace(10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(story.storyAutherName),
                                      Text(getStoryTimeText(story.createdAt)),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 20.h),
                            child:
                                //story.storyAutherId == myUser.uId?
                                Container(
                              width: ScreenUtil().screenWidth,
                              color: AppColors.blackColor.withOpacity(0.2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('${story.views.length}'),
                                  const HorizontalSpace(5),
                                  const Icon(Icons.visibility_outlined)
                                ],
                              ),
                            ) //:const SizedBox(),
                            )
                      ],
                    );
                  }));
        },
      ),
    );
  }
}

String getStoryTimeText(DateTime createdAt) {
  String fromNow = createdAt.fromNow();
  List<String> fromNowSplit = fromNow.split(' ');

  switch (fromNow) {
    case 'a few seconds ago':
      return 'Just now';
    case 'منذ ثانية واحدة':
      return 'الآن';
    case 'a minute ago':
      return '1m';
    case 'منذ دقيقة واحدة':
      return '${1.toArabicNumbers}د';
    case '2 minutes ago':
      return '2m';
    case 'منذ دقيقتين':
      return '${2.toArabicNumbers}د';
    case 'an hour ago':
      return '1h';
    case 'منذ ساعة واحدة':
      return '${1.toArabicNumbers}س';
    case 'منذ ساعتين':
      return '${2.toArabicNumbers}س';
    default:
      if (fromNowSplit.length > 1) {
        if (fromNowSplit[1] == 'minutes') {
          return '${fromNowSplit[0]}m';
        } else if (fromNowSplit[2] == 'دقيقة' || fromNowSplit[2] == 'دقائق') {
          return '${fromNowSplit[1]}د';
        } else if (fromNowSplit[1] == 'hours') {
          return '${fromNowSplit[0]}h';
        } else if (fromNowSplit[2] == 'ساعة' || fromNowSplit[2] == 'ساعات') {
          return '${fromNowSplit[1]}س';
        }
      }
      return fromNow;
  }
}
