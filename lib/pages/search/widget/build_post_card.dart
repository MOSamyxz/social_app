import 'package:chatapp/data/model/like_data_model.dart';
import 'package:chatapp/data/model/post_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/home/widget/post_widgets/post_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BuildPostCard extends StatelessWidget {
  const BuildPostCard({
    Key? key,
    required this.post,
    required this.index,
    required this.user,
  }) : super(key: key);

  final Post post;
  final int index;
  final UsersModel user;

  @override
  Widget build(BuildContext context) {
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
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    // Handle the case when likesData has data and comments has data
                    if (snapshot.data!.docs.isNotEmpty) {
                      LikesDataModel likesData =
                          LikesDataModel.fromMap(snapshot.data!.docs[0].data());
                      return PostCard(
                        user: user,
                        post: post,
                        likesData: likesData,
                        commentsLength: commentsLenght,
                      );
                    }
                    // Handle the case when likesData has data and comments is null or empty
                    else {
                      return PostCard(
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
                    return const Center(child: CircularProgressIndicator());
                  }
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
