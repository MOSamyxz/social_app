import 'package:chatapp/core/constants/assets.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
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
                itemCount: snapshot.data?.docs.length ?? 0,
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
                            child: Image.asset(
                              _getLikeAsset(likesData.likeType),
                              width: AppSize.r25,
                            ))
                      ],
                    ),
                    title: Row(
                      children: [
                        Text(likesData.userName),
                        const HorizontalSpace(2),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}

String _getLikeAsset(String likeType) {
  switch (likeType) {
    case 'Like':
      return AppAssets.like;
    case 'Love':
      return AppAssets.love;
    case 'Sad':
      return AppAssets.sad;
    case 'HaHa':
      return AppAssets.haha;
    case 'Wow':
      return AppAssets.wow;
    default:
      return AppAssets.angry;
  }
}
