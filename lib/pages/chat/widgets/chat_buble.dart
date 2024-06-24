import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/model/message_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/chat/widgets/build_message_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble(
      {super.key,
      required this.messege,
      required this.myUser,
      required this.user});
  final MessageModel messege;
  final UsersModel myUser;
  final UsersModel user;

  @override
  Widget build(BuildContext context) {
    final isMessageSender = messege.senderId == myUser.uId;
    final alignment =
        isMessageSender ? Alignment.centerRight : Alignment.centerLeft;
    final margin = isMessageSender
        ? EdgeInsets.only(right: 10.w, left: 60.w, top: 4.h)
        : EdgeInsets.only(left: 10.w, right: 60.w, top: 4.h);
    final backgroundColor = isMessageSender
        ? AppColors.blueColor
        : BlocProvider.of<AppCubit>(context).isDark
            ? AppColors.darkGreyColor
            : AppColors.greyColor;
    final borderRadius = BorderRadius.only(
      topLeft: Radius.circular(15.r),
      topRight: Radius.circular(15.r),
      bottomLeft: isMessageSender ? Radius.circular(15.r) : Radius.zero,
      bottomRight: isMessageSender ? Radius.zero : Radius.circular(15.r),
    );

    return Align(
      alignment: alignment,
      child: Container(
          padding: EdgeInsets.all(8.w),
          margin: margin,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: borderRadius,
          ),
          child: BuildMessageContent(
              borderRadius: borderRadius,
              messege: messege,
              user: user,
              myUser: myUser)),
    );
  }
}

String formatDateTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  String formattedTime = DateFormat('h:mm a').format(dateTime);
  return formattedTime;
}
