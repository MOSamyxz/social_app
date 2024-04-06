/* // ignore_for_file: use_build_context_synchronously

import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/core/utils/utils.dart';
import 'package:chatapp/core/widgets/horizontal_space.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/data/model/post_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/home/cubit/home_cubit.dart';
import 'package:chatapp/pages/home/widget/post_time_from_now.dart';
import 'package:chatapp/pages/post/firebase_posts/firestore_posts.dart';
import 'package:chatapp/pages/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SharedPostHeader extends StatelessWidget {
  const SharedPostHeader({
    Key? key,
    required this.post,
    required this.user,
  }) : super(key: key);

  final Post post;
  final UsersModel user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            await BlocProvider.of<HomeCubit>(context)
                .getUserById(post.sharerId);
            UsersModel profileUser =
                BlocProvider.of<HomeCubit>(context).userById;
            Future.delayed(const Duration(seconds: 1));
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProfileScreen(
                  profileUser: profileUser,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(AppSize.s10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: isArabicText(post.content)
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              children: [
                Row(
                  textDirection: TextDirection.ltr,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: AppSize.r20,
                      backgroundImage: NetworkImage(post.sharerProfileUrl!),
                    ),
                    const HorizontalSpace(5),
                    Column(
                      textDirection: TextDirection.ltr,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          textDirection: TextDirection.ltr,
                          post.sharerName!,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        PostTimeFromNow(post: post),
                      ],
                    ),
                    const Spacer(),
                    post.sharerId == user.uId
                        ? IconButton(
                            onPressed: () {
                              showDialog(
                                useRootNavigator: false,
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: ListView(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      shrinkWrap: true,
                                      children: [
                                        _buildDialogOption('Delete', () {
                                          _deletePost(postId: post.postId);
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        }),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.more_vert),
                          )
                        : Container(),
                  ],
                ),
                const VerticalSpace(5),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _buildDialogOption(String text, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Text(text),
    ),
  );
}

void _deletePost({required String postId}) {
  FireStorePosts().deletePost(postId);
}
 */