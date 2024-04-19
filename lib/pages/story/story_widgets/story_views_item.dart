import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/model/story_model.dart';

class StoryViewsItem extends StatelessWidget {
  const StoryViewsItem({
    super.key,
    required this.story,
  });

  final StoryModel story;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
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
        );
  }
}
