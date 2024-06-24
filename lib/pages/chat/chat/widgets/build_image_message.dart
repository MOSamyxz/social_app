import 'package:chatapp/data/model/message_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/chat/chat/full_screen_chat.dart';
import 'package:chatapp/pages/chat/chat/widgets/chat_buble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BuildImageMessage extends StatelessWidget {
  const BuildImageMessage({
    super.key,
    required this.messege,
    required this.user,
    required this.myUser,
    required this.borderRadius,
  });

  final MessageModel messege;
  final UsersModel user;
  final UsersModel myUser;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
        borderRadius: borderRadius,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CachedNetworkImage(
              imageUrl: messege.messageFileUrl!,
              width: ScreenUtil().screenWidth * 0.5,
            ),
            messege.messageContent == ''
                ? const SizedBox()
                : SizedBox(
                    width: ScreenUtil().screenWidth * 0.5,
                    child: Text(
                      messege.messageContent!,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
            Text(
              formatDateTime(
                '${messege.messageCreatedAt}',
              ),
              style: TextStyle(fontSize: 11.sp),
            ),
          ],
        ),
      ),
    );
  }
}
