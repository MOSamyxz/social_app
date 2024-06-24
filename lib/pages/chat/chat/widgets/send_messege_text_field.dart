import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/chat/chat/chat_cubit/chat_cubit.dart';
import 'package:chatapp/pages/post/add_posts/widget/image_video_view.dart';
import 'package:chatapp/pages/story/story_widgets/image_video_picker_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SendMessegeTextField extends StatelessWidget {
  const SendMessegeTextField({
    super.key,
    required this.receiver,
    required this.controller,
  });
  final UsersModel receiver;
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit()..init(),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocProvider.of<ChatCubit>(context).file != null
                  ? Container(
                      color: AppColors.greyColor,
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 4.h),
                      padding: AppPadding.screenPadding,
                      height: ScreenUtil().screenHeight * 0.2,
                      child: ImageVideoView(
                        file: BlocProvider.of<ChatCubit>(context).file!,
                        fileType:
                            BlocProvider.of<ChatCubit>(context).messageType,
                        onPressed: () {
                          BlocProvider.of<ChatCubit>(context).deletFile();
                        },
                      ),
                    )
                  : SizedBox(),
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller:
                          BlocProvider.of<ChatCubit>(context).messageController,
                      decoration: InputDecoration(
                          hintText: 'Messege... ',
                          hintStyle: TextStyle(
                              color: AppColors.darkGreyColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).cardTheme.color!),
                              borderRadius: BorderRadius.circular(30)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).cardTheme.color!),
                              borderRadius: BorderRadius.circular(30)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).cardTheme.color!),
                              borderRadius: BorderRadius.circular(30)),
                          filled: true,
                          fillColor: Theme.of(context).cardTheme.color),
                    )),
                    ImageVideoPickerButton(
                        onTap: () {
                          BlocProvider.of<ChatCubit>(context).pickedVideo();
                        },
                        icon: FontAwesomeIcons.film),
                    ImageVideoPickerButton(
                      onTap: () {
                        BlocProvider.of<ChatCubit>(context).pickedImage();
                      },
                      icon: FontAwesomeIcons.camera,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<ChatCubit>(context)
                              .sendMessage(recipient: receiver);

                          controller.animateTo(
                            0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.fastOutSlowIn,
                          );
                        },
                        child: CircleAvatar(
                            backgroundColor: Theme.of(context).cardTheme.color,
                            child: const FaIcon(FontAwesomeIcons.paperPlane)),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
