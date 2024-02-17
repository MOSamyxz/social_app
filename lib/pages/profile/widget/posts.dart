import 'package:chatapp/data/model/like_data_model.dart';
import 'package:chatapp/data/model/post_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/home/widget/post_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePostListBuilder extends StatelessWidget {
  const ProfilePostListBuilder({
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
                          .where('userId',
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
                            return PostCard(
                              index: index,
                              user: user,
                              post: post,
                              likesData: likesData,
                              commentsLength: commentsLenght,
                            );
                          }
                          // Handle the case when likesData has data and comments is null or empty
                          else {
                            return PostCard(
                              index: index,
                              user: user,
                              post: post,
                              likesData: LikesDataModel(
                                  userId: '',
                                  userName: '',
                                  imageUrl: '',
                                  likeType: '',
                                  postId: ''),
                              commentsLength: commentsLenght,
                            );
                          }
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      });
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              });
        });
  }
}
