import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/data/model/comment_model.dart';
import 'package:chatapp/data/model/post_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/post/comments/widgets/comment_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentList extends StatelessWidget {
  const CommentList({
    super.key,
    required this.post,
    required this.user,
    this.physics,
  });

  final Post post;
  final UsersModel user;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().screenHeight,
      child: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .doc(post.postId)
                .collection('comments')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                List<CommentModel> comments = snapshot.data!.docs.map((doc) {
                  return CommentModel.fromMap(doc.data());
                }).toList();
                return Expanded(
                  child: ListView.separated(
                    physics: physics,
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final isLiked = comments[index]
                          .likes!
                          .contains(FirebaseAuth.instance.currentUser!.uid);

                      return CommentItem(
                        comments: comments,
                        post: post,
                        user: user,
                        isLiked: isLiked,
                        index: index,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const VerticalSpace(5);
                    },
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
