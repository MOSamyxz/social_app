import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/home/widget/post_shimmer.dart';
import 'package:chatapp/pages/profile/widget/posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfilePostList extends StatelessWidget {
  const ProfilePostList({
    super.key,
    required this.user,
  });
  final UsersModel user;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .where('posterId', isEqualTo: user.uId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const PostShimmer();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No posts'));
        } else {
          return ProfilePostListBuilder(snapshot: snapshot, user: user);
        }
      },
    );
  }
}
