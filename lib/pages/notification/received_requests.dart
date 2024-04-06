import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/widgets/custom_bautton.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/notification/cubit/notification_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceivedRequsestsScreen extends StatelessWidget {
  const ReceivedRequsestsScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UsersModel user;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text('User data not found'));
        }

        final snapshotUser =
            UsersModel.fromMap(snapshot.data!.data() as Map<String, dynamic>);

        return BlocProvider(
          create: (context) =>
              NotificationCubit()..getUsersById(snapshotUser.receivedRequest),
          child: BlocConsumer<NotificationCubit, NotificationState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetUsersDataByIdLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else {
                List<UsersModel> users =
                    BlocProvider.of<NotificationCubit>(context).usersById;

                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Received requests'),
                  ),
                  body: ListView.separated(
                    itemCount: users.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSize.s20, vertical: AppSize.s10),
                        child: Row(
                          crossAxisAlignment: snapshotUser.receivedRequest
                                  .contains(users[index].uId)
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(users[index].imageUrl),
                            ),
                            const HorizontalSpace(10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: snapshotUser.receivedRequest
                                                      .contains(
                                                          users[index].uId) ||
                                                  snapshotUser.followers
                                                      .contains(
                                                          users[index].uId)
                                              ? users[index].userName
                                              : '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                        TextSpan(
                                          text: snapshotUser.receivedRequest
                                                  .contains(users[index].uId)
                                              ? ' has sent you a follow request'
                                              : snapshotUser.followers.contains(
                                                      users[index].uId)
                                                  ? ' is now following You'
                                                  : 'You deleted this request',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!,
                                        ),
                                      ],
                                    ),
                                  ),
                                  snapshotUser.receivedRequest
                                          .contains(users[index].uId)
                                      ? Row(
                                          children: [
                                            Expanded(
                                              child: CustomButton(
                                                radius: AppSize.r7,
                                                onPressed: () {
                                                  BlocProvider.of<
                                                              NotificationCubit>(
                                                          context)
                                                      .acceptFollowRequest(
                                                          users[index].uId);
                                                },
                                                height: 30.h,
                                                child: const Text(
                                                  'Accept',
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .realWhiteColor),
                                                ),
                                              ),
                                            ),
                                            const HorizontalSpace(10),
                                            Expanded(
                                              child: CustomButton(
                                                radius: AppSize.r7,
                                                onPressed: () {
                                                  BlocProvider.of<
                                                              NotificationCubit>(
                                                          context)
                                                      .removeFollowRequest(
                                                          users[index].uId);
                                                },
                                                height: 30.h,
                                                color: Theme.of(context)
                                                    .cardTheme
                                                    .color,
                                                child: const Text(
                                                  'Delete',
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}
