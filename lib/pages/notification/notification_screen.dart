import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/utils/to_ar_num_converter.dart';
import 'package:chatapp/core/utils/utils.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/model/notifications_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/notification/cubit/notification_cubit.dart';
import 'package:chatapp/pages/notification/received_requests.dart';
import 'package:chatapp/pages/search/widget/post_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UsersModel user = BlocProvider.of<AppCubit>(context).getUser;

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var snapshotUser =
              UsersModel.fromMap(snapshot.data!.data() as Map<String, dynamic>);
          return BlocProvider(
            create: (context) => NotificationCubit(),
            child: BlocConsumer<NotificationCubit, NotificationState>(
              listener: (context, state) {
                if (state is GettUsersDataByIdSuccessState) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Builder(builder: (context) {
                                return ReceivedRequsestsScreen(user: user);
                              })));
                }
              },
              builder: (context, state) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Notifications'),
                  ),
                  body: Column(
                    children: [
                      snapshotUser.receivedRequest.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                BlocProvider.of<NotificationCubit>(context)
                                    .getUsersById(snapshotUser.receivedRequest);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardTheme.color,
                                ),
                                child: Padding(
                                  padding: AppPadding.screenPadding,
                                  child: Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        width: 20.w,
                                        height: 20.w,
                                        decoration: BoxDecoration(
                                            color:
                                                AppColors.red.withOpacity(0.8),
                                            borderRadius:
                                                BorderRadius.circular(20.w)),
                                        child: Text(
                                          '${snapshotUser.receivedRequest.length}',
                                          style: const TextStyle(
                                              color: AppColors.realWhiteColor),
                                        ),
                                      ),
                                      const HorizontalSpace(5),
                                      const Expanded(
                                          child: Text('Received requests')),
                                      const FaIcon(FontAwesomeIcons.arrowRight)
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      VerticalSpace(10.h),
                      NotificationListBuilder(user: user)
                    ],
                  ),
                );
              },
            ),
          );
        });
  }
}

class NotificationListBuilder extends StatelessWidget {
  const NotificationListBuilder({
    super.key,
    required this.user,
  });
  final UsersModel user;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uId)
            .collection('notifications')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            int length = snapshot.data!.docs.length;
            return Expanded(
              child: ListView.separated(
                itemCount: length,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  NotificationsModel notificationsModel =
                      NotificationsModel.fromMap(
                          snapshot.data!.docs[index].data());

                  return NotificationItem(
                    notificationsModel: notificationsModel,
                    user: user,
                  );
                },
              ),
            );
          }
          return const CircularProgressIndicator();
        });
  }
}

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.notificationsModel,
    required this.user,
  });
  final NotificationsModel notificationsModel;
  final UsersModel user;
  @override
  Widget build(BuildContext context) {
    int lastNotification = notificationsModel.reactName!.length;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PostView(
                      user: user,
                      posterName: notificationsModel.posterName,
                      postId: notificationsModel.postId,
                    )));
      },
      child: Padding(
        padding: AppPadding.screenPadding,
        child: Row(
          children: [
            CircleAvatar(
              radius: AppSize.r30,
              backgroundImage: NetworkImage(
                  notificationsModel.reactImageUrl![lastNotification - 1]),
            ),
            const HorizontalSpace(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  lastNotification == 1
                      ? Text(
                          '${notificationsModel.reactName![lastNotification - 1]} liked your post',
                          style: const TextStyle(fontSize: 16),
                        )
                      : Text(
                          '${notificationsModel.reactName![lastNotification - 1]} and ${lastNotification - 1} others liked your post',
                          style: const TextStyle(fontSize: 16),
                          maxLines: 2,
                        ),
                  Text(getNotificationTimeText(notificationsModel.createdAt))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

String getNotificationTimeText(DateTime createdAt) {
  String fromNow = createdAt.fromNow();
  String formatedCreatedAt = DateFormat.yMMMMEEEEd().format(createdAt);
  List<String> fromNowSplit = fromNow.split(' ');

  switch (fromNow) {
    case 'a few seconds ago':
      return 'Just now';
    case 'منذ ثانية واحدة':
      return 'الآن';
    case 'a minute ago':
      return '1m';
    case 'منذ دقيقة واحدة':
      return '${1.toArabicNumbers}د';
    case '2 minutes ago':
      return '2m';
    case 'منذ دقيقتين':
      return '${2.toArabicNumbers}د';
    case 'an hour ago':
      return '1h';
    case 'منذ ساعة واحدة':
      return '${1.toArabicNumbers}س';
    case 'منذ ساعتين':
      return '${2.toArabicNumbers}س';
    case 'a day ago':
      return '1d';
    case 'منذ يوم واحد':
      return '${1.toArabicNumbers}ي';
    case 'منذ يومين':
      return '${2.toArabicNumbers}ي';

    default:
      if (fromNowSplit.length > 1) {
        if (fromNowSplit[1] == 'minutes') {
          return '${fromNowSplit[0]}m';
        } else if (fromNowSplit[2] == 'دقيقة' || fromNowSplit[2] == 'دقائق') {
          return '${fromNowSplit[1]}د';
        } else if (fromNowSplit[1] == 'hours') {
          return '${fromNowSplit[0]}h';
        } else if (fromNowSplit[2] == 'ساعة' || fromNowSplit[2] == 'ساعات') {
          return '${fromNowSplit[1]}س';
        } else if (fromNowSplit[1] == 'days' &&
            int.parse(fromNowSplit[0]) < 7) {
          return '${fromNowSplit[0]}d';
        } else if (fromNow == 'منذ ٣ ايام' &&
            fromNow == 'منذ ٤ ايام' &&
            fromNow == 'منذ ٥ ايام' &&
            fromNow == 'منذ ٦ ايام' &&
            fromNow == 'منذ ۷ ايام') {
          return '${fromNowSplit[1]}ي';
        }
      }
      return formatedCreatedAt;
  }
}
