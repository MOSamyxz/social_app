import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/home/widget/home_body.dart';
import 'package:chatapp/pages/home/widget/post_widgets/post_shimmer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getUserData()
        ..getVerifiedMembers(),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          if (state is GetCurrentUserDataSuccessState ||
              state is GetVerifiedMembersDataSuccessState) {
            return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  UsersModel user = BlocProvider.of<AppCubit>(context).getUser;
                  return HomeBody(snapshot: snapshot, user: user);
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                return const PostShimmer();
              },
            );
          }
          return const PostShimmer();
        },
      ),
    );
  }
}
