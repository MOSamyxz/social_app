import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/services/cache_helper.dart';
import 'package:chatapp/core/utils/to_ar_num_converter.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/data/model/chat_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:chatapp/pages/chat/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

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
                  Text(
                      getLastMessageTimeText(
                          chats.lastMessageCreatedAt, context),
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

String getLastMessageTimeText(DateTime createdAt, BuildContext context) {
  final DateTime now = DateTime.now();
  final Duration difference = now.difference(createdAt);
  final int duration = difference.inMinutes;
  final String durationAr = duration.toArabicNumbers;
  final String durationEn = duration.toString();
  final String durationArEn =
      CacheHelper.sharedPreferences.getString('lang') == 'ar'
          ? durationAr
          : durationEn;
  if (duration < 1) {
    return 'الآن';
  } else if (duration < 60) {
    return '$durationArEn${S.of(context).min}';
  }

  final hours = duration ~/ 60;
  final String hoursAr = hours.toArabicNumbers;
  final String hoursEn = hours.toString();
  final String hoursArEn =
      CacheHelper.sharedPreferences.getString('lang') == 'ar'
          ? hoursAr
          : hoursEn;

  if (hours < 24) {
    return '$hoursArEn${S.of(context).hour}';
  }

  final days = hours ~/ 24;
  final String daysAr = days.toArabicNumbers;
  final String daysEn = days.toString();
  final String daysArEn =
      CacheHelper.sharedPreferences.getString('lang') == 'ar' ? daysAr : daysEn;
  if (days < 7) {
    return '$daysArEn${S.of(context).day}';
  }

  return DateFormat.yMMMMEEEEd().format(createdAt);
}
