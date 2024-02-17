import 'package:chatapp/core/constants/size.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:chatapp/pages/post/add_posts/cubit/post_cubit.dart';
import 'package:chatapp/pages/post/add_posts/widget/add_post_body.dart';
import 'package:chatapp/pages/post/add_posts/widget/image_video_button.dart';
import 'package:chatapp/pages/post/add_posts/widget/post_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppPostView extends StatelessWidget {
  const AppPostView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UsersModel user = BlocProvider.of<AppCubit>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).createPost), // Set the title here
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.s10),
            child: PostButton(
              user: user,
              text: S.of(context).post,
              onPressed: () {
                BlocProvider.of<PostCubit>(context).createPost(
                  context,
                  posterName: user.userName,
                  posterProfileUrl: user.imageUrl,
                );
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
              AddPostBody(user: user),
              const ImageVideoAddPostButton()
            ],
          );
        },
      ),
    );
  }
}
