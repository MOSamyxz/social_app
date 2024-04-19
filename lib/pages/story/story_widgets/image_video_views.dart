import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/pages/post/add_posts/widget/image_video_view.dart';
import 'package:chatapp/pages/story/cubit/story_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageVideoViews extends StatelessWidget {
  const ImageVideoViews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ImageVideoView(
          fileType: BlocProvider.of<StoryCubit>(context).storyType!,
          file: BlocProvider.of<StoryCubit>(context).file!,
        ),
        BlocProvider.of<StoryCubit>(context).storyTextController.text == ''
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
    );
  }
}
