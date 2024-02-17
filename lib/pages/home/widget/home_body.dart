import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/home/widget/home_custom_app_bar.dart';
import 'package:chatapp/pages/home/widget/home_fab.dart';
import 'package:chatapp/pages/home/widget/post_list_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.user,
    required this.snapshot,
  });

  final UsersModel user;
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const HomeFAB(),
      body: SafeArea(
        child: Column(
          children: [
            const HomeCustomAppBar(),
            HomePostListBuilder(snapshot: snapshot, user: user)
          ],
        ),
      ),
    );
  }
}
