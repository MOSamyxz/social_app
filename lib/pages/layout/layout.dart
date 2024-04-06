import 'package:chatapp/core/constants/colors.dart';
import 'package:chatapp/cubit/app_cubit.dart';
import 'package:chatapp/pages/home/home_screen.dart';
import 'package:chatapp/pages/notification/notification_screen.dart';
import 'package:chatapp/pages/profile/profile_screen.dart';
import 'package:chatapp/pages/search/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..controllerInit()
        ..getUserData(),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: PageView(
                controller: BlocProvider.of<AppCubit>(context).pageController,
                onPageChanged: BlocProvider.of<AppCubit>(context).onItemTapped,
                children: const [
                  HomeScreen(),
                  SearchScreen(),
                  NotificationScreen(),
                  ProfileScreen(),
                ],
              ),
            ),
            bottomNavigationBar: CupertinoTabBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: 'notifications',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'profile',
                ),
              ],
              currentIndex: BlocProvider.of<AppCubit>(context).currentPage,
              activeColor: AppColors.blueColor,
              inactiveColor: AppColors.greyColor,
              onTap: BlocProvider.of<AppCubit>(context).navigationTapped,
            ),
          );
        },
      ),
    );
  }
}
