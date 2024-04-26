import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/utils/to_ar_num_converter.dart';
import 'package:chatapp/core/utils/utils.dart';
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
  });

  final StoryModel story;
  final UsersModel user;

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
              Text(getStoryTimeText(story.createdAt)),
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
                                _deleteStory(storyId: story.storyId);
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

void _deleteStory({required String storyId}) {
  FireStoreStories().removeStory(storyId);
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
