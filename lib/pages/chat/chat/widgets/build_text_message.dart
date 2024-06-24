import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/data/model/message_model.dart';
import 'package:chatapp/pages/chat/chat/widgets/chat_buble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildTextMessage extends StatelessWidget {
  const BuildTextMessage({
    super.key,
    required this.messege,
  });

  final MessageModel messege;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            messege.messageContent!,
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
                '${messege.messageCreatedAt}',
              ),
              style: TextStyle(fontSize: 11.sp),
            ),
          ],
        ),
      ],
    );
  }
}
