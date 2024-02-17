import 'package:chatapp/pages/post/add_posts/cubit/post_cubit.dart';
import 'package:chatapp/pages/post/add_posts/widget/add_post_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostCubit()..init(),
      child: const AppPostView(),
    );
  }
}
