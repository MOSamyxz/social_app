import 'package:chatapp/data/model/post_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/search/widget/build_post_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchPostListBuilder extends StatelessWidget {
  const SearchPostListBuilder({
    Key? key,
    required this.snapshot,
    required this.user,
  }) : super(key: key);

  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;
  final UsersModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var post = Post.fromMap(snapshot.data!.docs[index].data());
              return BuildPostCard(
                post: post,
                index: index,
                user: user,
              );
            },
          ),
        ),
      ],
    );
  }
}
