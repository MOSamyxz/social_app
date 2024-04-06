import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/core/constants/padding.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/generated/l10n.dart';
import 'package:chatapp/pages/post/add_posts/cubit/post_cubit.dart';
import 'package:chatapp/pages/post/add_posts/widget/add_post_header.dart';
import 'package:chatapp/pages/post/add_posts/widget/image_video_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPostBody extends StatelessWidget {
  const AddPostBody({
    super.key,
    required this.user,
  });

  final UsersModel user;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: AppPadding.screenPadding,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              AppPostHeader(user: user),
              TextFormField(
                controller: BlocProvider.of<PostCubit>(context).postController,
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
              if (BlocProvider.of<PostCubit>(context).file != null)
                ImageVideoView(
                  file: BlocProvider.of<PostCubit>(context).file!,
                  fileType: BlocProvider.of<PostCubit>(context).fileType!,
                  onPressed: () {
                    BlocProvider.of<PostCubit>(context).deletFile();
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}
