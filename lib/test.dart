import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/utils/to_ar_num_converter.dart';
import 'package:chatapp/core/utils/utils.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/core/widgets/shimmer.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/model/chat_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/Chat/chat_screen.dart';
import 'package:chatapp/pages/Chat/cubit/chats_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
<<<<<<<<<<<<<<  ✨ Codeium Command 🌟 >>>>>>>>>>>>>>>>
+  Widget build(BuildContext context) {
+    final myUser = BlocProvider.of<AppCubit>(context).getUser;
+    return BlocProvider(
+      create: (context) => ChatsCubit(),
+      child: BlocConsumer<ChatsCubit, ChatsState>(
+        listener: (context, state) {},
+        builder: (context, state) {
+          return Scaffold(
+            appBar: AppBar(
+              title: const Text('Chats'),
+            ),
+            body: Padding(
+              padding: AppPadding.screenPadding,
+              child: Column(
+                children: [
+                  const VerticalSpace(10),
+                  Expanded(
+                    child: _buildChatsList(context, myUser),
+                  ),
+                ],
+              ),
+            ),
+          );
+        },
+      ),
+    );
+  }
+
+  Widget _buildChatsList(BuildContext context, UsersModel myUser) {
+    return StreamBuilder(
+      stream: _chatsStream(myUser),
+      builder: (context, snapshot) {
+        if (snapshot.connectionState == ConnectionState.waiting) {
+          return const ChatShimmer();
+        } else if (snapshot.data!.docs.isEmpty) {
+          return const Text('No messages');
+        } else {
+          return ListView.builder(
+            itemCount: snapshot.data!.docs.length,
+            itemBuilder: (context, index) {
+              final chat = ChatModel.fromMap(snapshot.data!.docs[index].data());
+              return _buildChatTile(context, chat);
+            },
+          );
+        }
+      },
+    );
+  }
+
+  Stream<QuerySnapshot> _chatsStream(UsersModel myUser) {
+    return FirebaseFirestore.instance
+        .collection('users')
+        .doc(myUser.uId)
+        .collection('chats')
+        .snapshots();
+  }
+
+  Widget _buildChatTile(BuildContext context, ChatModel chat) {
+    return StreamBuilder(
+      stream: _userStream(chat.receiverID),
+      builder: (context, snapshot) {
+        if (snapshot.hasData) {
+          final user = UsersModel.fromMap(snapshot.data!.data()!);
+          return Column(
+            children: [
+              InkWell(
+                onTap: () {},
+                child: ChatTile(user: user, chats: chat),
+              ),
+              const Divider(),
+            ],
+          );
+        }
+        return const ChatShimmer();
+      },
+    );
+  }
+
+  Stream<DocumentSnapshot> _userStream(String receiverID) {
+    return FirebaseFirestore.instance
+        .collection('users')
+        .doc(receiverID)
+        .snapshots();
+  }
-  Widget build(BuildContext context) {
-    UsersModel myUser = BlocProvider.of<AppCubit>(context).getUser;
-    return BlocProvider(
-      create: (context) => ChatsCubit(),
-      child: BlocConsumer<ChatsCubit, ChatsState>(
-          listener: (context, state) {},
-          builder: (context, state) {
-            return Scaffold(
-              appBar: AppBar(
-                title: const Text('Cahts'),
-              ),
-              body: Padding(
-                padding: AppPadding.screenPadding,
-                child: Column(
-                  children: [
-                    const VerticalSpace(10),
-                    Expanded(
-                      child: StreamBuilder(
-                          stream: FirebaseFirestore.instance
-                              .collection('users')
-                              .doc(myUser.uId)
-                              .collection('chats')
-                              .snapshots(),
-                          builder: (context, snapshot) {
-                            if (snapshot.connectionState ==
-                                ConnectionState.waiting) {
-                              return const ChatShimmer();
-                            } else if (snapshot.data!.docs.isEmpty) {
-                              return const Text('no messeges');
-                            } else {
-                              return ListView.builder(
-                                itemCount: snapshot.data!.docs.length,
-                                itemBuilder: (context, index) {
-                                  var chats = ChatModel.fromMap(
-                                      snapshot.data!.docs[index].data());
-                                  return StreamBuilder(
-                                      stream: FirebaseFirestore.instance
-                                          .collection('users')
-                                          .doc(chats.receiverID)
-                                          .snapshots(),
-                                      builder: (context, snapshot) {
-                                        if (snapshot.hasData) {
-                                          var users = UsersModel.fromMap(
-                                              snapshot.data!.data()!);
-                                          return Column(
-                                            children: [
-                                              InkWell(
-                                                  onTap: () {},
-                                                  child: ChatTile(
-                                                      user: users,
-                                                      chats: chats)),
-                                              const Divider()
-                                            ],
-                                          );
-                                        }
-                                        // ignore: prefer_const_constructors
-                                        return ChatShimmer();
-                                      });
-                                },
-                              );
-                            }
-                          }),
-                    ),
-                  ],
-                ),
-              ),
-            );
-          }),
-    );
-  }
<<<<<<<  37a8660a-5485-413e-aa46-55f8f1a64165  >>>>>>>
}

class ChatShimmer extends StatelessWidget {
  const ChatShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.screenPadding,
      child: Row(
        children: [
          CircleShimmer(
            size: AppSize.r25,
          ),
          ContainerShimmer(
            width: AppSize.r10,
            height: AppSize.r44,
          )
        ],
      ),
    );
  }
}

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
                  Text(getLastMessegeTimeText(chats.lastMessageCreatedAt),
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

String getLastMessegeTimeText(DateTime createdAt) {
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
