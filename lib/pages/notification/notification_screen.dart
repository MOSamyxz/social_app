import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/notification/cubit/notification_cubit.dart';
import 'package:chatapp/pages/notification/received_requests.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                          ? GestureDetector(
                              onTap: () {
                                BlocProvider.of<NotificationCubit>(context)
                                    .getUsersById(snapshotUser.receivedRequest);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardTheme.color,
                                ),
                                child: Padding(
                                  padding: AppPadding.screenPadding,
                                  child: Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        width: 20.w,
                                        height: 20.w,
                                        decoration: BoxDecoration(
                                            color:
                                                AppColors.red.withOpacity(0.8),
                                            borderRadius:
                                                BorderRadius.circular(20.w)),
                                        child: Text(
                                          '${snapshotUser.receivedRequest.length}',
                                          style: const TextStyle(
                                              color: AppColors.realWhiteColor),
                                        ),
                                      ),
                                      const HorizontalSpace(5),
                                      const Expanded(
                                          child: Text('Received requests')),
                                      const FaIcon(FontAwesomeIcons.arrowRight)
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      const Center(
                        child: Text('No Notifications yet'),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        });
  }
}
