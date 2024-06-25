import 'package:chatapp/data/model/chat_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/chat/chats/widgets/chat_shimmer.dart';
import 'package:chatapp/pages/chat/chats/widgets/chat_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatTileStream extends StatelessWidget {
  const ChatTileStream({
    super.key,
    required this.chats,
  });

  final ChatModel chats;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(chats.receiverID)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var users = UsersModel.fromMap(snapshot.data!.data()!);
            return Column(
              children: [
                InkWell(
                    onTap: () {}, child: ChatTile(user: users, chats: chats)),
                const Divider()
              ],
            );
          }
          // ignore: prefer_const_constructors
          return ChatShimmer();
        });
  }
}
