import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/utils/get_time.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/data/model/chat_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/chat/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
    required this.user,
    required this.chats,
  });
  final UsersModel user;
  final ChatModel chats;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                user: user,
              ),
            ));
      },
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: AppSize.r25,
                backgroundImage: NetworkImage(user.imageUrl),
              ),
              CircleAvatar(
                radius: AppSize.r5,
                backgroundColor: user.isOnline ? Colors.green : Colors.grey,
              )
            ],
          ),
          const HorizontalSpace(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.userName),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: ScreenUtil().screenWidth * 0.1,
                    child: Text(
                      chats.lastMessage == ''
                          ? chats.lastMessageType
                          : chats.lastMessage,
                      style: Theme.of(context).textTheme.labelSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(getTimeText(chats.lastMessageCreatedAt, context, false),
                      style: Theme.of(context).textTheme.labelSmall)
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
