import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/model/post_model.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/home/cubit/home_cubit.dart';
import 'package:chatapp/pages/post/comments/widgets/comment_list.dart';
import 'package:chatapp/pages/post/comments/widgets/comment_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({
    super.key,
    required this.post,
  });
  final Post post;

  @override
  Widget build(BuildContext context) {
    UsersModel user = BlocProvider.of<AppCubit>(context).getUser;

    return BlocProvider(
      create: (context) => HomeCubit()..init(),
      child: Scaffold(
        backgroundColor: BlocProvider.of<AppCubit>(context).isDark
            ? AppColors.darkScaffoldColor
            : AppColors.realWhiteColor,
        appBar: AppBar(
          backgroundColor: BlocProvider.of<AppCubit>(context).isDark
              ? AppColors.darkScaffoldColor
              : AppColors.realWhiteColor,
          title: const Text('Comments'),
        ),
        body: Column(
          children: [
            Expanded(child: CommentList(post: post, user: user)),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return CommentTextField(user: user, post: post);
              },
            )
          ],
        ),
      ),
    );
  }
}
