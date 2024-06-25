import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/data/model/post_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/saved_posts/widgets/saved_post_item.dart';
import 'package:chatapp/pages/search/widget/post_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListSavedPost extends StatelessWidget {
  const ListSavedPost({super.key, required this.user, required this.snapshot});

  final UsersModel user;
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.screenPadding,
      child: ListView.separated(
          itemCount: snapshot.data!.docs.length,
          separatorBuilder: (context, index) => const VerticalSpace(10),
          itemBuilder: (context, index) {
            var post = Post.fromMap(snapshot.data!.docs[index].data());

            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PostView(
                              user: user,
                              posterName: post.posterName,
                              postId: post.postId,
                            )));
              },
              child: SavedPostItem(post: post),
            );
          }),
    );
  }
}
