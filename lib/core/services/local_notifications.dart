import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chatapp/pages/notification/notification_screen.dart';
import 'package:flutter/material.dart';

class AwesomeNotificationServices {
  Future<void> initializeNotifications() async {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'like_notification',
          channelName: 'Like Notification',
          channelDescription: 'Like notification channel',
          defaultColor: Colors.teal,
          ledColor: Colors.teal,
          playSound: true,
          importance: NotificationImportance.Max,
        ),
        NotificationChannel(
          channelKey: 'comment_notification',
          channelName: 'Comment Notification',
          channelDescription: 'Comment notification channel',
          defaultColor: Colors.teal,
          ledColor: Colors.teal,
          playSound: true,
          importance: NotificationImportance.Max,
        ),
      ],
    );
  }

  listenActionStream(context) {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: (ReceivedAction receivedAction) async {
      await Navigator.of(context).push(MaterialPageRoute(
          builder: ((context) => const NotificationScreen())));
    });
  }

  Future<void> likeNotification({
    required String title,
    required String body,
  }) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 0,
        channelKey: 'like_notification',
        title: title,
        body: body,
      ),
    );
  }

  Future<void> commentNotification({
    required String title,
    required String body,
  }) async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'comment_notification',
        title: title,
        body: body,
      ),
    );
  }
}
