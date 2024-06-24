import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/data/model/chat_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/chat/chats/widgets/chat_tile_stream.dart';
import 'package:chatapp/test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  const ChatList({
    super.key,
    required this.myUser,
  });

  final UsersModel myUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.screenPadding,
      child: Column(
        children: [
          const VerticalSpace(10),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(myUser.uId)
                    .collection('chats')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ChatShimmer();
                  } else if (snapshot.data!.docs.isEmpty) {
                    return const Text('no messeges');
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var chats = ChatModel.fromMap(
                            snapshot.data!.docs[index].data());
                        return ChatTileStream(chats: chats);
                      },
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
