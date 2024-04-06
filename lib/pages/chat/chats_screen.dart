import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/Chat/chat_screen.dart';
import 'package:chatapp/pages/Chat/cubit/chats_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CahtsScreen extends StatelessWidget {
  const CahtsScreen({super.key});

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
              body: Padding(
                padding: AppPadding.screenPadding,
                child: Column(
                  children: [
                    const VerticalSpace(10),
                    Expanded(
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else {
                              return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  var users = UsersModel.fromMap(
                                      snapshot.data!.docs[index].data());
                                  return users.uId != myUser.uId
                                      ? Column(
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChatScreen(
                                                          userId: users.uId,
                                                        ),
                                                      ));
                                                },
                                                child: ChatTile(
                                                  user: users,
                                                )),
                                            const Divider()
                                          ],
                                        )
                                      : const SizedBox();
                                },
                              );
                            }
                          }),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
    required this.user,
  });
  final UsersModel user;
  @override
  Widget build(BuildContext context) {
    return Row(
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
              backgroundColor: Colors.green,
            )
          ],
        ),
        const HorizontalSpace(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.userName),
            Text(
              'Last message..!',
              style: Theme.of(context).textTheme.labelSmall,
            )
          ],
        )
      ],
    );
  }
}
