import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/model/messege_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/chat/full_screen_chat.dart';
import 'package:chatapp/pages/chat/full_screen_video_chat.dart';
import 'package:chatapp/pages/home/widget/post_widgets/video_view_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble(
      {super.key,
      required this.messege,
      required this.myUser,
      required this.user});
  final MessegeModel messege;
  final UsersModel myUser;
  final UsersModel user;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: messege.senderId == myUser.uId
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8.w),
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 4.h),
        decoration: BoxDecoration(
          color: messege.senderId == myUser.uId
              ? AppColors.blueColor
              : BlocProvider.of<AppCubit>(context).isDark
                  ? AppColors.darkGreyColor
                  : AppColors.greyColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.r),
            topRight: Radius.circular(15.r),
            bottomLeft: messege.senderId == myUser.uId
                ? Radius.circular(15.r)
                : Radius.zero,
            bottomRight: messege.senderId == myUser.uId
                ? Radius.zero
                : Radius.circular(15.r),
          ),
        ),
        child: messege.messegeType == 'text'
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      messege.messegeContent!,
                      softWrap: true,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  const HorizontalSpace(5),
                  Column(
                    children: [
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        formatDateTime(
                          '${messege.messegeCreatedAt}',
                        ),
                        style: TextStyle(fontSize: 11.sp),
                      ),
                    ],
                  ),
                ],
              )
            : messege.messegeType == 'image'
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FullImageScreenChat(
                                    messege: messege,
                                    user: user,
                                    myUser: myUser,
                                  )));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.r),
                        topRight: Radius.circular(15.r),
                        bottomLeft: messege.senderId == myUser.uId
                            ? Radius.circular(15.r)
                            : Radius.zero,
                        bottomRight: messege.senderId == myUser.uId
                            ? Radius.zero
                            : Radius.circular(15.r),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CachedNetworkImage(
                            imageUrl: messege.messegeFileUrl!,
                            width: ScreenUtil().screenWidth * 0.5,
                          ),
                          messege.messegeContent == ''
                              ? SizedBox()
                              : SizedBox(
                                  width: ScreenUtil().screenWidth * 0.5,
                                  child: Text(
                                    messege.messegeContent!,
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                )
                        ],
                      ),
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.r),
                      topRight: Radius.circular(15.r),
                      bottomLeft: messege.senderId == myUser.uId
                          ? Radius.circular(15.r)
                          : Radius.zero,
                      bottomRight: messege.senderId == myUser.uId
                          ? Radius.zero
                          : Radius.circular(15.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: ScreenUtil().screenWidth * 0.5,
                          child: VideoViewHome(
                            video: Uri.parse(messege.messegeFileUrl!),
                            isSearchView: true,
                            child: FullScreenVideoChat(
                              messege: messege,
                              user: user,
                              myUser: myUser,
                            ),
                          ),
                        ),
                        messege.messegeContent == ''
                            ? SizedBox()
                            : Text(
                                messege.messegeContent!,
                                style: TextStyle(fontSize: 16.sp),
                              )
                      ],
                    ),
                  ),
      ),
    );
  }
}

String formatDateTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  String formattedTime = DateFormat('h:mm a').format(dateTime);
  return formattedTime;
}
