import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/utils/get_time.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/data/firestore_story/firestore_story.dart';
import 'package:chatapp/data/model/story_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoryHeader extends StatelessWidget {
  const StoryHeader({
    super.key,
    required this.story,
    required this.user,
    required this.itemCount,
  });

  final StoryModel story;
  final UsersModel user;
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50.h, left: 20.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: AppSize.r20,
            backgroundImage: NetworkImage(story.storyAutherProfileUrl),
          ),
          const HorizontalSpace(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(story.storyAutherName),
                  const HorizontalSpace(2),
                ],
              ),
              Text(getTimeText(story.createdAt, context, false)),
            ],
          ),
          const Spacer(),
          user.uId == story.storyAutherId
              ? IconButton(
                  onPressed: () {
                    showDialog(
                      useRootNavigator: false,
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: ListView(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shrinkWrap: true,
                            children: [
                              _buildDialogOption('Delete', () {
                                _deleteStory(
                                    storyId: story.storyId,
                                    itemcount: itemCount);
                                Navigator.of(context).pop(); // Close the dialog
                                Navigator.of(context).pop(); // Close the dialog
                              }),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}

void _deleteStory({required String storyId, required int itemcount}) {
  FireStoreStories().removeStory(storyId, itemcount);
}

Widget _buildDialogOption(String text, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Text(text),
    ),
  );
}
