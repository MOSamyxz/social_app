import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/chat/chats/cubit/chats_cubit.dart';
import 'package:chatapp/pages/chat/chats/widgets/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UsersModel myUser = BlocProvider.of<AppCubit>(context).getUser;
    return BlocProvider(
      create: (context) => ChatsCubit(),
      child: BlocConsumer<ChatsCubit, ChatsState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Cahts'),
              ),
              body: ChatList(myUser: myUser),
            );
          }),
    );
  }
}
