import 'package:chatapp/pages/Chat/chat_cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
    required this.userId,
  });
  final String userId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit()..getCurrentChats(userId),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  'Chat: ${BlocProvider.of<ChatCubit>(context).getUser.userName}'),
            ),
            body: Text(BlocProvider.of<ChatCubit>(context).getUser.email),
          );
        },
      ),
    );
  }
}
