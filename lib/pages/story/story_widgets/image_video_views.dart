import 'dart:ui';

import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/pages/story/cubit/story_cubit.dart';
import 'package:chatapp/pages/story/story_widgets/image_video_view_story.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageVideoViews extends StatelessWidget {
  const ImageVideoViews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryCubit, StoryState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: ScreenUtil().screenHeight * 0.75,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(
                    BlocProvider.of<StoryCubit>(context).file!,
                    fit: BoxFit.cover,
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 10,
                        sigmaY:
                            10), // Adjust sigmaX and sigmaY for blur intensity
                    child: Container(
                      color: Colors.black
                          .withOpacity(0), // Adjust opacity for blur effect
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ImageVideoViewStory(
                  fileType: BlocProvider.of<StoryCubit>(context).storyType!,
                  file: BlocProvider.of<StoryCubit>(context).file!,
                  onPressed: () {
                    BlocProvider.of<StoryCubit>(context).deletFile();
                  },
                ),
                BlocProvider.of<StoryCubit>(context).storyTextController.text ==
                        ''
                    ? const SizedBox()
                    : Container(
                        padding: EdgeInsets.only(bottom: 25.h),
                        alignment: Alignment.center,
                        width: double.infinity,
                        color: AppColors.blackColor.withOpacity(0.3),
                        child: Text(BlocProvider.of<StoryCubit>(context)
                            .storyTextController
                            .text),
                      )
              ],
            ),
          ],
        );
      },
    );
  }
}
