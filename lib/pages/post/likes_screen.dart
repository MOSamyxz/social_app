import 'package:chatapp/core/constants/assets.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/data/model/like_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LikesScreen extends StatelessWidget {
  const LikesScreen({super.key, required this.postId});
  final String postId;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .collection('likesData')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return Scaffold(
            body: SafeArea(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  LikesDataModel likesData =
                      LikesDataModel.fromMap(snapshot.data!.docs[index].data());
                  return ListTile(
                    leading: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(likesData.imageUrl),
                        ),
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.green,
                          child: likesData.likeType == 'Like'
                              ? Image.asset(
                                  AppAssets.like,
                                  width: AppSize.r25,
                                )
                              : likesData.likeType == 'Love'
                                  ? Image.asset(
                                      AppAssets.love,
                                      width: AppSize.r25,
                                    )
                                  : likesData.likeType == 'Sad'
                                      ? Image.asset(
                                          AppAssets.sad,
                                          width: AppSize.r25,
                                        )
                                      : likesData.likeType == 'HaHa'
                                          ? Image.asset(
                                              AppAssets.haha,
                                              width: AppSize.r25,
                                            )
                                          : likesData.likeType == 'Wow'
                                              ? Image.asset(
                                                  AppAssets.wow,
                                                  width: AppSize.r25,
                                                )
                                              : Image.asset(
                                                  AppAssets.angry,
                                                  width: AppSize.r25,
                                                ),
                        )
                      ],
                    ),
                    title: Text(likesData.userName),
                  );
                },
              ),
            ),
          );
        });
  }
}
