import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/notification/cubit/notification_cubit.dart';
import 'package:chatapp/pages/notification/received_requests.dart';
import 'package:chatapp/pages/notification/widgets/notification_list_builder.dart';
import 'package:chatapp/pages/notification/widgets/received_request_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UsersModel user = BlocProvider.of<AppCubit>(context).getUser;

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var snapshotUser =
              UsersModel.fromMap(snapshot.data!.data() as Map<String, dynamic>);
          return BlocProvider(
            create: (context) => NotificationCubit(),
            child: BlocConsumer<NotificationCubit, NotificationState>(
              listener: (context, state) {
                if (state is GettUsersDataByIdSuccessState) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Builder(builder: (context) {
                                return ReceivedRequsestsScreen(user: user);
                              })));
                }
              },
              builder: (context, state) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Notifications'),
                  ),
                  body: Column(
                    children: [
                      snapshotUser.receivedRequest.isNotEmpty
                          ? ReceivedRequstButton(snapshotUser: snapshotUser)
                          : const SizedBox(),
                      VerticalSpace(10.h),
                      NotificationListBuilder(user: user)
                    ],
                  ),
                );
              },
            ),
          );
        });
  }
}
