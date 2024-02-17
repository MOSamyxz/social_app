import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:chatapp/pages/post/add_posts/cubit/post_cubit.dart';

import 'package:chatapp/pages/post/add_posts/widget/add_psot_header.dart';
import 'package:chatapp/pages/post/add_posts/widget/post_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPostScreen extends StatelessWidget {
  const EditPostScreen({
    super.key,
    required this.postContent,
    required this.postContentController,
    required this.postId,
  });
  final String postContent;
  final String postId;
  final TextEditingController postContentController;

  @override
  Widget build(BuildContext context) {
    UsersModel user = BlocProvider.of<AppCubit>(context).getUser;

    return BlocProvider(
      create: (context) => PostCubit()..init(),
      child: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Edit Post'), // Set the title here
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.s10),
                  child: PostButton(
                    user: user,
                    text: 'Edit',
                    onPressed: () {
                      BlocProvider.of<PostCubit>(context).updatePost(
                        context,
                        postId: postId,
                        postContent: postContentController.text,
                      );
                      Navigator.pop(context);
                    },
                  ),
                )
              ], // Set the actions here
            ),
            //bottomNavigationBar: const ImageVideoAddPostButton(),
            body: BlocBuilder<PostCubit, PostState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: AppPadding.screenPadding,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              AppPostHeader(user: user),
                              TextFormField(
                                controller: postContentController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: S.of(context).whatOnMind,
                                  hintStyle: const TextStyle(
                                    fontSize: 18,
                                    color: AppColors.darkGreyColor,
                                  ),
                                ),
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
