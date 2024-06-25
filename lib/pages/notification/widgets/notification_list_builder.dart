import 'package:chatapp/data/model/notifications_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/notification/widgets/comment_notification_item.dart';
import 'package:chatapp/pages/notification/widgets/react_notification_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

                  return notificationsModel.isComment
                      ? CommentNotificationItem(
                          notificationsModel: notificationsModel, user: user)
                      : ReactNotificationItem(
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
