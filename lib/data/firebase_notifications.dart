import 'dart:convert';
import 'package:chatapp/core/services/local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class FirebaseNotification {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<String?> registerDeviceToken() async {
    return await messaging.getToken();
  }

  void setupFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      message.data['type'] == 'comment'
          ? AwesomeNotificationServices().commentNotification(
              title: message.notification!.title!,
              body: message.notification!.body!)
          : AwesomeNotificationServices().likeNotification(
              title: message.notification!.title!,
              body: message.notification!.body!,
            );
    });
  }

  void requestPermission() async {
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  sendMessage(
      {required String title,
      required String discreption,
      required String token,
      required Map<String, dynamic>? data}) async {
    var headersList = {
      'Accept': '*/*',
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAAc2mAk9U:APA91bG4WuOEmoLlVnJ65TNDRF16dtE9CC1guFbrE7NZGzR4wZpfTgn0CLL4QGGeCFuOzhZC_gFPWm6b26RGoqmc-AGTNIDvJ_UTqkKXPwFhLDgyzgxX8PJGESDBK117yUx74T71cLsD'
    };
    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    var body = {
      "to": token,
      "notification": {
        "title": title,
        "body": discreption,
        "mutable_content": true,
        "sound": "Tri-tone"
      },
      "data": data
    };

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }
  }
}
