import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/post/add_posts/widget/image_video_view.dart';
import 'package:chatapp/pages/story/cubit/story_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddStoryScreen extends StatelessWidget {
  const AddStoryScreen({super.key, required this.myUser});
  final UsersModel myUser;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoryCubit()..init(),
      child: BlocBuilder<StoryCubit, StoryState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Add Story'),
              actions: [
                MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSize.r12), // <-- Radius
                    ),
                    color: AppColors.blueColor,
                    minWidth: 30,
                    onPressed: () {
                      BlocProvider.of<StoryCubit>(context).creatStory(context,
                          storyAuther: myUser.userName,
                          storyAutherProfileUrl: myUser.imageUrl);
                    },
                    child: Text('Add Story'))
              ],
            ),
            body: SingleChildScrollView(
              child: Expanded(
                child: Column(children: [
                  BlocProvider.of<StoryCubit>(context).file == null
                      ? Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: ScreenUtil().screenHeight * 0.75,
                          decoration: const BoxDecoration(color: Colors.red),
                          child: Text(BlocProvider.of<StoryCubit>(context)
                              .storyTextController
                              .text))
                      : Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            ImageVideoView(
                              fileType: BlocProvider.of<StoryCubit>(context)
                                  .storyType!,
                              file: BlocProvider.of<StoryCubit>(context).file!,
                            ),
                            BlocProvider.of<StoryCubit>(context)
                                        .storyTextController
                                        .text ==
                                    ''
                                ? const SizedBox()
                                : Container(
                                    padding: EdgeInsets.only(bottom: 25.h),
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    color:
                                        AppColors.blackColor.withOpacity(0.3),
                                    child: Text(
                                        BlocProvider.of<StoryCubit>(context)
                                            .storyTextController
                                            .text),
                                  )
                          ],
                        ),
                  AddStoryTextFIeld(),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}

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
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: InkWell(
              onTap: () {
                BlocProvider.of<StoryCubit>(context).pickedVideo();
              },
              child: CircleAvatar(
                  backgroundColor: Theme.of(context).cardTheme.color,
                  child: const FaIcon(FontAwesomeIcons.film)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: InkWell(
              onTap: () {
                BlocProvider.of<StoryCubit>(context).pickedImage();
              },
              child: CircleAvatar(
                  backgroundColor: Theme.of(context).cardTheme.color,
                  child: const FaIcon(FontAwesomeIcons.camera)),
            ),
          ),
        ],
      ),
    );
  }
}
