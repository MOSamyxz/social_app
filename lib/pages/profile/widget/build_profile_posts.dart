import 'package:chatapp/data/model/user_model.dart';
import 'package:chatapp/pages/home/cubit/home_cubit.dart';
import 'package:chatapp/pages/profile/widget/profile_post._builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildProfilePosts extends StatelessWidget {
  const BuildProfilePosts({
    super.key,
    required this.profileUser,
  });
  final UsersModel profileUser;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            width: ScreenUtil().screenWidth,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProfilePostList(user: profileUser),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
