import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/pages/story/cubit/story_cubit.dart';
import 'package:chatapp/pages/story/story_widgets/image_video_picker_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddStoryTextFIeld extends StatelessWidget {
  const AddStoryTextFIeld({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller:
                BlocProvider.of<StoryCubit>(context).storyTextController,
            onChanged: (value) {
              BlocProvider.of<StoryCubit>(context).onchanged(value);
            },
            decoration: InputDecoration(
                hintText: 'What\'s on your mind? ',
                hintStyle: TextStyle(
                    color: AppColors.darkGreyColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).cardTheme.color!),
                    borderRadius: BorderRadius.circular(30)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).cardTheme.color!),
                    borderRadius: BorderRadius.circular(30)),
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).cardTheme.color!),
                    borderRadius: BorderRadius.circular(30)),
                filled: true,
                fillColor: Theme.of(context).cardTheme.color),
          )),
          ImageVideoPickerButton(
              onTap: () {
                BlocProvider.of<StoryCubit>(context).pickedVideo();
              },
              icon: FontAwesomeIcons.film),
          ImageVideoPickerButton(
            onTap: () {
              BlocProvider.of<StoryCubit>(context).pickedImage();
            },
            icon: FontAwesomeIcons.camera,
          ),
        ],
      ),
    );
  }
}
