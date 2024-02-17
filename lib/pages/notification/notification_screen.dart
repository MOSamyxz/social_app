import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/notification/cubit/notification_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationCubit(),
      child: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Notifications'),
            ),
            body: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    var user = UsersModel.fromMap(
                        snapshot.data!.data() as Map<String, dynamic>);
                    BlocProvider.of<NotificationCubit>(context)
                        .getUsersById(user.receivedRequest);
                    List<UsersModel> requests =
                        BlocProvider.of<NotificationCubit>(context).usersById;
                    return ListView.builder(
                        itemCount: requests.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    AppSize.r12), // <-- Radius
                              ),
                              tileColor: Theme.of(context).cardTheme.color,
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(requests[index].imageUrl),
                              ),
                              title: RichText(
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: requests[index].userName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                    TextSpan(
                                        text: ' has sent you a followe request',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!),
                                  ],
                                ),
                              ),
                              trailing: TextButton(
                                  onPressed: () {
                                    BlocProvider.of<NotificationCubit>(context)
                                        .acceptFollowRequest(
                                            requests[index].uId);
                                  },
                                  child: const Text(
                                    'Accept',
                                    style:
                                        TextStyle(color: AppColors.blueColor),
                                  )),
                            ),
                          );
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          );
        },
      ),
    );
  }
}
