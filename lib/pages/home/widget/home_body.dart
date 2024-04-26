import 'package:chatapp/core/constants/assets.dart';
import 'package:chatapp/core/widgets/vertical_space.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/home/widget/home_custom_app_bar.dart';
import 'package:chatapp/pages/home/widget/home_fab.dart';
import 'package:chatapp/pages/home/widget/post_widgets/post_list_builder.dart';
import 'package:chatapp/pages/post/add_posts/cubit/post_cubit.dart';
import 'package:chatapp/pages/story/story_widgets/home_story_list_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.user,
    required this.snapshot,
  });

  final UsersModel user;
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostCubit(),
      child: Scaffold(
        floatingActionButton: const HomeFAB(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const HomeCustomAppBar(),
                const HomeStoryListBuilder(),
                const Divider(),
                if (user.following.isEmpty && user.postList.isEmpty)
                  RefreshIndicator(
                    onRefresh: () async {
                      await Future.delayed(const Duration(seconds: 1));
                      await BlocProvider.of<AppCubit>(context).getUserData();
                    },
                    child: LayoutBuilder(builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const VerticalSpace(50),
                            Image.asset(
                              AppAssets.noPost,
                              width: 100.w,
                            ),
                            const Text(
                              'No posts to show,\n Follow some people or post your first post now !',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }),
                  )
                else
                  HomePostListBuilder(snapshot: snapshot, user: user)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
