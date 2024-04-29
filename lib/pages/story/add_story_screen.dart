import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/post/add_posts/widget/post_button.dart';
import 'package:chatapp/pages/story/cubit/story_cubit.dart';
import 'package:chatapp/pages/story/story_widgets/add_story_text_fIeld.dart';
import 'package:chatapp/pages/story/story_widgets/image_video_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              title: const Text('Add Story'),
              actions: [
                PostButton(
                    text: 'Add Story',
                    onPressed: () {
                      BlocProvider.of<StoryCubit>(context).creatStory(context,
                          storyAuther: myUser.userName,
                          storyAutherProfileUrl: myUser.imageUrl);
                    })
              ],
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocProvider.of<StoryCubit>(context).file == null
                            ? Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: ScreenUtil().screenHeight * 0.75,
                                decoration:
                                    const BoxDecoration(color: Colors.red),
                                child: Text(BlocProvider.of<StoryCubit>(context)
                                    .storyTextController
                                    .text))
                            : const Center(child: ImageVideoViews()),
                        SizedBox(
                          height: 60.h,
                        )
                      ]),
                ),
                Column(
                  children: [
                    BlocProvider.of<StoryCubit>(context).isLoading
                        ? const LinearProgressIndicator()
                        : const SizedBox(),
                    const Spacer(),
                    const AddStoryTextField(),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
