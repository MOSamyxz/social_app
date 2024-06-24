import 'package:chatapp/data/model/message_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/chat/chat/widgets/build_image_message.dart';
import 'package:chatapp/pages/chat/chat/widgets/build_text_message.dart';
import 'package:chatapp/pages/chat/chat/widgets/build_video_message.dart';
import 'package:flutter/material.dart';

class BuildMessageContent extends StatelessWidget {
  const BuildMessageContent({
    super.key,
    required this.borderRadius,
    required this.messege,
    required this.user,
    required this.myUser,
  });

  final BorderRadius borderRadius;
  final MessageModel messege;
  final UsersModel user;
  final UsersModel myUser;

  @override
  Widget build(BuildContext context) {
    return messege.messageType == 'text'
        ? BuildTextMessage(messege: messege)
        : messege.messageType == 'image'
            ? BuildImageMessage(
                messege: messege,
                user: user,
                myUser: myUser,
                borderRadius: borderRadius)
            : BuildVideoMessage(
                borderRadius: borderRadius,
                messege: messege,
                user: user,
                myUser: myUser);
  }
}
