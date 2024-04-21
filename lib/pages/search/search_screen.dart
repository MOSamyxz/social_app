import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/pages/home/cubit/home_cubit.dart';
import 'package:chatapp/pages/home/widget/post_widgets/post_shimmer.dart';
import 'package:chatapp/pages/search/widget/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => AppCubit()
            ..getVerifiedMembers()
            ..getUserData(),
        ),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          if (state is GetVerifiedMembersDataSuccessState ||
              state is GetCurrentUserDataSuccessState) {
            return const SearchView();
          }
          return const PostShimmer();
        },
      ),
    );
  }
}
