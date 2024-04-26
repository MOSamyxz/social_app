import 'package:chatapp/data/model/like_data_model.dart';
import 'package:chatapp/data/model/post_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/home/home_screen.dart';
import 'package:chatapp/pages/home/widget/post_widgets/post_card.dart';
import 'package:chatapp/pages/home/widget/post_widgets/post_shimmer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePostListBuilder extends StatelessWidget {
  const HomePostListBuilder({
    super.key,
    required this.snapshot,
    required this.user,
  });

  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;
  final UsersModel user;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context, index) {
          var post = Post.fromMap(snapshot.data!.docs[index].data());
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .doc(post.postId)
                  .collection('comments')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  // Access and display the likesData for the current post
                  int commentsLenght = snapshot.data!.docs.length;
                  return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('posts')
                          .doc(post.postId)
                          .collection('likesData')
                          .where('userId', isEqualTo: user.uId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          // Handle the case when likesData has data and comments has data
                          if (snapshot.data!.docs.isNotEmpty) {
                            LikesDataModel likesData = LikesDataModel.fromMap(
                                snapshot.data!.docs[0].data());
                            return user.following.contains(post.posterId) ||
                                    post.posterId == user.uId
                                ? PostCard(
                                    user: user,
                                    post: post,
                                    likesData: likesData,
                                    commentsLength: commentsLenght,
                                  )
                                : const SizedBox();
                          }
                          // Handle the case when likesData has data and comments is null or empty
                          else {
                            return user.following.contains(post.posterId) ||
                                    post.posterId == user.uId
                                ? PostCard(
                                    user: user,
                                    post: post,
                                    likesData: LikesDataModel(
                                        userId: '',
                                        userName: '',
                                        imageUrl: '',
                                        likeType: '',
                                        postId: ''),
                                    commentsLength: commentsLenght,
                                  )
                                : const SizedBox();
                          }
                        } else {
                          return const PostShimmer();
                        }
                      });
                } else {
                  return const PostShimmer();
                }
              });
        });
  }
}
