import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/utils/to_ar_num_converter.dart';
import 'package:chatapp/core/utils/utils.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/model/post_model.dart';
import 'package:chatapp/data/model/user_model.dart';

import 'package:chatapp/pages/home/widget/post_widgets/video_view_saved.dart';
import 'package:chatapp/pages/search/widget/post_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavedPostsScreen extends StatelessWidget {
  const SavedPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UsersModel user = BlocProvider.of<AppCubit>(context).getUser;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uId)
            .collection('savedPosts')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Saved Posts'),
              ),
              body: Padding(
                padding: AppPadding.screenPadding,
                child: ListView.separated(
                    itemCount: snapshot.data!.docs.length,
                    separatorBuilder: (context, index) =>
                        const VerticalSpace(10),
                    itemBuilder: (context, index) {
                      var post =
                          Post.fromMap(snapshot.data!.docs[index].data());

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
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppSize.r10),
                                color: Theme.of(context).cardTheme.color),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: ScreenUtil().screenWidth * 0.25,
                                  height: ScreenUtil().screenWidth * 0.25,
                                  child: post.fileUrl == ''
                                      ? Padding(
                                          padding: const EdgeInsets.all(1),
                                          child: Image.network(
                                            post.posterProfileUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : post.postType == 'postMediaImage'
                                          ? Padding(
                                              padding: const EdgeInsets.all(1),
                                              child:
                                                  Image.network(post.fileUrl!),
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.all(1),
                                              child: VideoViewSaved(
                                                aspectRatio: 1,
                                                video: Uri.parse(post.fileUrl!),
                                                isSearchView: false,
                                              ),
                                            ),
                                ),
                                const HorizontalSpace(10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(post.posterName),
                                      Text(
                                        post.content,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        children: [
                                          Text(post.postType == 'post'
                                              ? 'Post'
                                              : post.postType ==
                                                      'postMediaImage'
                                                  ? 'Image'
                                                  : 'Video'),
                                          const Text(' ● '),
                                          Text(getPostTimeText(post.savedAt!))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      );
                    }),
              ),
            );
          }
        });
  }
}

String getPostTimeText(DateTime savedAt) {
  String fromNow = savedAt.fromNow();
  List<String> fromNowSplit = fromNow.split(' ');

  switch (fromNow) {
    case 'a few seconds ago':
      return 'Just now';
    case 'منذ ثانية واحدة':
      return 'الآن';
    case 'a minute ago':
      return '1m';
    case 'منذ دقيقة واحدة':
      return '${1.toArabicNumbers}د';
    case '2 minutes ago':
      return '2m';
    case 'منذ دقيقتين':
      return '${2.toArabicNumbers}د';
    case 'an hour ago':
      return '1h';
    case 'منذ ساعة واحدة':
      return '${1.toArabicNumbers}س';
    case 'منذ ساعتين':
      return '${2.toArabicNumbers}س';
    case 'a day ago':
      return '1d';
    case 'منذ يوم واحد':
      return '${1.toArabicNumbers}ي';
    case 'منذ يومين':
      return '${2.toArabicNumbers}ي';
    case 'a month ago':
      return '1M';
    case 'منذ شهر واحد':
      return '${1.toArabicNumbers}ش';
    case 'منذ شهرين':
      return '${2.toArabicNumbers}ش';

    case 'a year ago':
      return '1y';
    case 'منذ عام واحد':
      return '${1.toArabicNumbers}ع';
    default:
      if (fromNowSplit.length > 1) {
        if (fromNowSplit[1] == 'minutes') {
          return '${fromNowSplit[0]}m';
        } else if (fromNowSplit[2] == 'دقيقة' || fromNowSplit[2] == 'دقائق') {
          return '${fromNowSplit[1]}د';
        } else if (fromNowSplit[1] == 'hours') {
          return '${fromNowSplit[0]}h';
        } else if (fromNowSplit[2] == 'ساعة' || fromNowSplit[2] == 'ساعات') {
          return '${fromNowSplit[1]}س';
        } else if (fromNowSplit[1] == 'days') {
          return '${fromNowSplit[0]}d';
        } else if (fromNowSplit[2] == 'يوم' || fromNowSplit[2] == 'ايام') {
          return '${fromNowSplit[1]}ي';
        } else if (fromNowSplit[1] == 'months') {
          return '${fromNowSplit[0]}M';
        } else if (fromNowSplit[2] == 'شهر' || fromNowSplit[2] == 'اشهر') {
          return '${fromNowSplit[1]}ش';
        } else if (fromNowSplit[1] == 'years') {
          return '${fromNowSplit[0]}y';
        } else if (fromNowSplit[2] == 'عامًا' || fromNowSplit[2] == 'اعوام') {
          return '${fromNowSplit[1]}ع';
        }
      }
      return fromNow;
  }
}
