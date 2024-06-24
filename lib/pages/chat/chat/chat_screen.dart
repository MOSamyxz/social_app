import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/model/message_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/chat/chat/chat_cubit/chat_cubit.dart';
import 'package:chatapp/pages/chat/chat/chat_cubit/widgets/send_messege_text_field.dart';
import 'package:chatapp/pages/chat/chat/widgets/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({
    super.key,
    required this.user,
  });
  final UsersModel user;
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    UsersModel myUser = BlocProvider.of<AppCubit>(context).getUser;
    return BlocProvider(
      create: (context) => ChatCubit()..init(),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(myUser.uId)
                  .collection('chats')
                  .doc(user.uId)
                  .collection('messages')
                  .orderBy('messageCreatedAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text(user.userName),
                    ),
                    body: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              reverse: true,
                              controller: _controller,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                var messege = MessageModel.fromMap(
                                    snapshot.data!.docs[index].data());
                                return ChatBuble(
                                    messege: messege,
                                    myUser: myUser,
                                    user: user);
                              }),
                        ),
                        SendMessegeTextField(
                            receiver: user, controller: _controller)
                      ],
                    ),
                  );
                }
                return const CircularProgressIndicator();
              });
        },
      ),
    );
  }
}
